import datetime
import os

import numpy as np
import tensorflow as tf
import tensorflow_probability as tfp
import tensorflow_probability.python.distributions as tfd
import tensorflow_probability.python.layers as tfl
from tensorflow.keras.callbacks import Callback
from tensorflow.keras.layers import Input, Dense, Dropout, Concatenate
from tensorflow.keras.models import Model
from tensorflow.keras.optimizers import Adam

from visualizations import *
from window_generator import WindowGenerator


class CustomVariational(tfl.DenseVariational):
    def get_config(self):
        config = super().get_config().copy()
        config.update({
            'units': self.units,
            'make_posterior_fn': self._make_posterior_fn,
            'make_prior_fn': self._make_prior_fn
        })
        return config


class Training:
    def __init__(self, df: pd.DataFrame, config: Configuration,
                 model_path: str, image_path: str, **kwargs):
        super().__init__(**kwargs)  # handles standard args (e.g., name)
        self.df = df
        self.config = config
        self.model_path = model_path
        self.image_path = image_path
        self.window = None

    def nll(self, y, distr):
        return -distr.log_prob(y)

    def normal_sp(self, params):
        return tfd.Normal(loc=params,  # loc=params[:, 0:1],
                          scale=1e-3 + tf.math.softplus(0.05 * params[:, 1:2]))  # both parameters are learnable

    def normal_exp(self, params):
        return tfd.Normal(loc=params[:, 0:1], scale=tf.math.exp(params[:, 1:2]))  # both parameters are learnable

    def train_flipout_model(self, country):
        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        x, y = next(iter(ds_train))

        kernel_divergence_fn = lambda q, p, _: tfd.kl_divergence(q, p) / (x.shape[1] * 1.0)
        bias_divergence_fn = lambda q, p, _: tfd.kl_divergence(q, p) / (x.shape[1] * 1.0)

        inputs = Input(shape=(self.config.input_width, len(self.config.cols)))

        hidden = tfl.DenseFlipout(20, bias_posterior_fn=tfl.util.default_mean_field_normal_fn(),
                                  bias_prior_fn=tfl.default_multivariate_normal_fn,
                                  kernel_divergence_fn=kernel_divergence_fn,
                                  bias_divergence_fn=bias_divergence_fn, activation="relu")(inputs)
        hidden = tfl.DenseFlipout(50, bias_posterior_fn=tfl.util.default_mean_field_normal_fn(),
                                  bias_prior_fn=tfl.default_multivariate_normal_fn,
                                  kernel_divergence_fn=kernel_divergence_fn,
                                  bias_divergence_fn=bias_divergence_fn, activation="relu")(hidden)
        hidden = tfl.DenseFlipout(20, bias_posterior_fn=tfl.util.default_mean_field_normal_fn(),
                                  bias_prior_fn=tfl.default_multivariate_normal_fn,
                                  kernel_divergence_fn=kernel_divergence_fn,
                                  bias_divergence_fn=bias_divergence_fn, activation="relu")(hidden)
        params = tfl.DenseFlipout(2, bias_posterior_fn=tfl.util.default_mean_field_normal_fn(),
                                  bias_prior_fn=tfl.default_multivariate_normal_fn,
                                  kernel_divergence_fn=kernel_divergence_fn,
                                  bias_divergence_fn=bias_divergence_fn)(hidden)
        dist = tfl.DistributionLambda(self.normal_sp)(params)

        model_vi = Model(inputs=inputs, outputs=dist)
        model_vi.compile(Adam(learning_rate=0.001), loss=self.nll)
        model_params = Model(inputs=inputs, outputs=params)
        result = model_vi.fit(ds_train, epochs=self.config.epochs, validation_data=ds_val, verbose=True)
                              # steps_per_epoch=50, validation_steps=25)

        export_dir = self.config.final_model_path + self.model_path
        model_vi.save_weights(export_dir)
        self.plot_results(model_vi, result, country, ds_train, ds_val, ds_test)

        return model_vi

    def train_mc_dropout_model(self, country):
        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)

        inputs = Input(shape=(self.config.input_width, len(self.config.cols)))
        hidden = Dense(20, activation="relu")(inputs)
        hidden = Dropout(0.1)(hidden, training=True)
        hidden = Dense(50, activation="relu")(hidden)
        hidden = Dropout(0.1)(hidden, training=True)
        hidden = Dense(50, activation="relu")(hidden)
        hidden = Dropout(0.1)(hidden, training=True)
        hidden = Dense(50, activation="relu")(hidden)
        hidden = Dropout(0.1)(hidden, training=True)
        hidden = Dense(20, activation="relu")(hidden)
        hidden = Dropout(0.1)(hidden, training=True)
        params_mc = Dense(2)(hidden)
        dist_mc = tfl.DistributionLambda(self.normal_exp, name='normal_exp')(params_mc)

        model_mc = Model(inputs=inputs, outputs=dist_mc)
        model_mc.compile(Adam(learning_rate=0.01), loss=self.nll)
        result = model_mc.fit(ds_train, epochs=self.config.epochs, validation_data=ds_val, verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model_mc.save_weights(export_dir)
        self.plot_results(model_mc, result, country, ds_train, ds_val, ds_test)

        return model_mc

    # Specify the surrogate posterior over `keras.layers.Dense` `kernel` and `bias`.
    def posterior_mean_field(self, kernel_size, bias_size=0, dtype=None):
        n = kernel_size + bias_size
        c = np.log(np.expm1(1.))
        return tf.keras.Sequential([
            tfl.VariableLayer(2 * n, dtype=dtype),
            tfl.DistributionLambda(lambda t: tfd.Independent(
                tfd.Normal(loc=t[:, :n],
                           scale=1e-5 + tf.nn.softplus(c + t[:, n:])),
                reinterpreted_batch_ndims=1)),
        ])

    # Specify the prior over `keras.layers.Dense` `kernel` and `bias`.
    def prior_trainable(self, kernel_size, bias_size=0, dtype=None):
        n = kernel_size + bias_size
        return tf.keras.Sequential([
            tfl.VariableLayer(n, dtype=dtype),
            tfl.DistributionLambda(lambda t: tfd.Independent(
                tfd.Normal(loc=t, scale=1),
                reinterpreted_batch_ndims=1)),
        ])

    def train_flex_sd_model(self, country):
        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        # ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        # x_train, y_train = next(iter(ds_train))
        data_train = np.array(self.window.df_train, dtype=np.float32)
        x_train = data_train[:-self.window.label_width-self.window.shift]
        y_train = np.squeeze(data_train[self.window.input_width+self.window.shift:])
        data_valid = np.array(self.window.df_valid, dtype=np.float32)
        x_valid = data_valid[:-self.window.label_width-self.window.shift]
        y_valid = np.squeeze(data_valid[self.window.input_width+self.window.shift:])
        data_test = np.array(self.window.df_test, dtype=np.float32)
        x_test = data_test[:-self.window.label_width-self.window.shift]
        y_test = np.squeeze(data_test[self.window.input_width+self.window.shift:])

        def my_dist(params):
            return tfd.Normal(loc=params[:, 0:1],
                              scale=1e-3 + tf.math.softplus(0.05 * params[:, 1:2]))  # both parameters are learnable

        inputs = Input(shape=(1,))
        out1 = Dense(1)(inputs)
        hidden1 = Dense(10, activation="relu")(inputs)
        hidden1 = Dense(5, activation="relu")(hidden1)
        hidden2 = Dense(5, activation="relu")(hidden1)
        out2 = Dense(1)(hidden2)
        params = Concatenate()([out1, out2])
        dist = tfl.DistributionLambda(my_dist)(params)
        model = Model(inputs=inputs, outputs=dist)

        # Do inference.
        model.compile(optimizer=tf.optimizers.Adam(learning_rate=0.01), loss=self.nll)
        result = model.fit(x_train, y_train, epochs=self.config.epochs, validation_data=(x_valid, y_valid),
                           verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        # self.plot_results(model, result, country, "linear", ds_train, ds_val, ds_test)
        self.plot_results(model, result, country, "linear", x_train, y_train, x_valid, y_valid, x_test, y_test)

        return model

    def train_linear_model(self, country):
        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        # ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        # x_train, y_train = next(iter(ds_train))
        data_train = np.array(self.window.df_train, dtype=np.float32)
        x_train = data_train[:-self.window.label_width-self.window.shift]
        y_train = np.squeeze(data_train[self.window.input_width+self.window.shift:])
        data_valid = np.array(self.window.df_valid, dtype=np.float32)
        x_valid = data_valid[:-self.window.label_width-self.window.shift]
        y_valid = np.squeeze(data_valid[self.window.input_width+self.window.shift:])
        data_test = np.array(self.window.df_test, dtype=np.float32)
        x_test = data_test[:-self.window.label_width-self.window.shift]
        y_test = np.squeeze(data_test[self.window.input_width+self.window.shift:])

        # Build model.
        # model = tf.keras.Sequential([
        #     tf.keras.layers.Dense(1),
        #     tfl.DistributionLambda(lambda t: tfd.Normal(loc=t, scale=1)),
        # ])
        model = tf.keras.Sequential([
            tf.keras.layers.Dense(2),
            tfl.DistributionLambda(lambda t: tfd.Normal(loc=t[:, :1],
                                                        scale=1e-3 + tf.math.softplus(0.05 * t[:, 1:]))),
        ])
        # model = tf.keras.Sequential([
        #     tfl.DenseVariational(2, self.posterior_mean_field, self.prior_trainable),
        #     tfl.DistributionLambda(
        #         lambda t: tfd.Normal(loc=t[:, :1],
        #                              scale=1e-3 + tf.math.softplus(0.01 * t[:, 1:]))),
        # ])

        # Do inference.
        model.compile(optimizer=tf.optimizers.Adam(learning_rate=0.01), loss=self.nll)
        result = model.fit(x_train, y_train, epochs=self.config.epochs, validation_data=(x_valid, y_valid), verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        # self.plot_results(model, result, country, "linear", ds_train, ds_val, ds_test)
        self.plot_results(model, result, country, "linear", x_train, y_train, x_valid, y_valid, x_test, y_test)

        return model

    def train_gru_model(self, country):
        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        x_train, y_train = next(iter(ds_train))
        model = tf.keras.Sequential([
            tf.keras.layers.GRU(units=10, dropout=0.2, return_sequences=True, activation="relu"),
            tf.keras.layers.GRU(units=10, dropout=0.2, return_sequences=True, activation="relu"),
            tf.keras.layers.GRU(units=10, dropout=0.2, return_sequences=True, activation="relu"),
            tf.keras.layers.Dense(self.config.label_width)  # kernel_initializer=tf.initializers.variance_scaling()
        ])
        # Do inference.
        model.compile(optimizer=tf.optimizers.Adam(learning_rate=0.0001), loss=tf.metrics.mse)
        result = model.fit(ds_train, epochs=self.config.epochs, validation_data=ds_val, verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        self.plot_results(model, result, country, "gru", ds_train, ds_val, ds_test)

        return model

    def train_poisson_model(self, country):

        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        # ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        # x_train, y_train = next(iter(ds_train))
        data_train = np.array(self.window.df_train, dtype=np.float32)
        x_train = data_train[:-self.window.label_width-self.window.shift]
        y_train = np.squeeze(data_train[self.window.input_width+self.window.shift:])
        data_valid = np.array(self.window.df_valid, dtype=np.float32)
        x_valid = data_valid[:-self.window.label_width-self.window.shift]
        y_valid = np.squeeze(data_valid[self.window.input_width+self.window.shift:])
        data_test = np.array(self.window.df_test, dtype=np.float32)
        x_test = data_test[:-self.window.label_width-self.window.shift]
        y_test = np.squeeze(data_test[self.window.input_width+self.window.shift:])

        inputs = Input(shape=(x_train.shape[1],))
        rate = Dense(1, activation=tf.math.softplus)(inputs)
        p_y = tfl.DistributionLambda(tfd.Poisson)(rate)
        model = Model(inputs=inputs, outputs=p_y)

        # Do inference.
        model.compile(optimizer=tf.optimizers.Adam(learning_rate=0.01), loss=self.nll)
        result = model.fit(x_train, y_train, epochs=self.config.epochs, validation_data=(x_valid, y_valid),
                           verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        # self.plot_results(model, result, country, "poisson", ds_train, ds_val, ds_test)
        self.plot_results(model, result, country, "linear", x_train, y_train, x_valid, y_valid, x_test, y_test)

        return model

    def train_variational_model(self, country):

        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        # ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        # x_train, y_train = next(iter(ds_train))
        data_train = np.array(self.window.df_train)
        x_train = data_train[:-self.window.label_width-self.window.shift]
        y_train = np.squeeze(data_train[self.window.input_width+self.window.shift:])
        data_valid = np.array(self.window.df_valid, dtype=np.float32)
        x_valid = data_valid[:-self.window.label_width-self.window.shift]
        y_valid = np.squeeze(data_valid[self.window.input_width+self.window.shift:])
        data_test = np.array(self.window.df_test, dtype=np.float32)
        x_test = data_test[:-self.window.label_width-self.window.shift]
        y_test = np.squeeze(data_test[self.window.input_width+self.window.shift:])

        # Build model
        model = tf.keras.Sequential([
            CustomVariational(1 + len(self.config.target_cols), self.posterior_mean_field, self.prior_trainable,
                              kl_weight=1 / self.window.df_train.shape[0]),
            tfl.DistributionLambda(
                lambda t: tfd.Normal(loc=t[..., :1],
                                     scale=1e-4 + tf.math.softplus(0.001 * t[..., 1:]))),
        ])

        # Do inference.
        model.compile(optimizer=tf.optimizers.Adam(learning_rate=0.005), loss=self.nll)
        result = model.fit(x_train, y_train, epochs=self.config.epochs, validation_data=(x_valid, y_valid),
                           verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        # self.plot_results(model, result, country, "linear", ds_train, ds_val, ds_test)
        self.plot_results(model, result, country, "linear", x_train, y_train, x_valid, y_valid, x_test, y_test)

        return model

    def plot_results(self, model, result, country, model_type, x_train, y_train, x_valid, y_valid, x_test, y_test):
        if model_type is "linear":
            for col in self.config.target_cols:
                self.window.plot_linear_model(model, plot_model="train", plot_col=col, x=x_train, y=y_train,
                                              final_image_path=self.config.graphs_path + self.image_path)
                self.window.plot_linear_model(model, plot_model="val", plot_col=col, x=x_valid, y=y_valid,
                                              final_image_path=self.config.graphs_path + self.image_path)
                self.window.plot_linear_model(model, plot_model="test", plot_col=col, x=x_test, y=y_test,
                                              final_image_path=self.config.graphs_path + self.image_path)
        else:
            for col in self.config.target_cols:
                self.window.plot_bayesian(model, plot_model="train", plot_col=col, x=x_train, y=y_train,
                                          image_path=self.config.graphs_path + self.image_path)
                self.window.plot_bayesian(model, plot_model="val", plot_col=col, x=x_train, y=y_train,
                                          image_path=self.config.graphs_path + self.image_path)
                self.window.plot_bayesian(model, plot_model="test", plot_col=col, x=x_train, y=y_train,
                                          image_path=self.config.graphs_path + self.image_path)

        # model.save_weights(filepath=self.config.final_model_path + self.model_path + "_model.h5")
        # model_json = model.to_json()
        # with open(self.config.final_model_path + self.model_path + ".json", "w") as json_file:
        #     json_file.write(model_json)
        # tf.keras.models.save_model(model, self.config.final_model_path + self.model_path + "_model.h5")
        # tf.saved_model.save(model, self.config.final_model_path + self.model_path + "_model")
        # model.save(self.model_path + "_model")

        # plot model result
        plot_train_history(result, 'Train history loss for ' + country + " " +
                           datetime.datetime.now().strftime("%Y-%m-%d-%H:%M"),
                           self.config.final_model_path + self.image_path)

        train_performance = model.evaluate(x_train, verbose=1)
        val_performance = model.evaluate(x_valid, verbose=1)
        test_performance = model.evaluate(x_test, verbose=1)
        self.evaluate_performance(model, x_test, y_test, ['Poisson Regression (TFP)'])

        perf_filename = self.config.results_path + "Performance_" + datetime.datetime.now().strftime("%Y%m%d") + ".txt"
        if os.path.exists(perf_filename):
            append_write = 'a'  # append if already exists
        else:
            append_write = 'w'  # make a new file if not

        with open(perf_filename, append_write) as file:
            file.write(country + ":\n")
            file.write("Training Evaluation: " + str(train_performance) + str("\n"))
            file.write("Validation Evaluation: " + str(val_performance) + str("\n"))
            file.write("Test Evaluation: " + str(test_performance) + str("\n"))
            file.close()

        return

    def evaluate_performance(self, model, x, y, index):
        y_hat_test = model.predict(x).flatten()

        rmse = np.sqrt(np.mean((y - y_hat_test) ** 2))
        mae = np.mean(np.abs(y - y_hat_test))

        eval_nll = model.evaluate(x, y)  # returns the NLL

        df = pd.DataFrame(
            {'RMSE': rmse, 'MAE': mae, 'NLL (mean)': eval_nll}, index=index
        )
        print(df)

        return

