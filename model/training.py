from window_generator import WindowGenerator
from data_management import *
from configuration import Configuration
import model_config

import pandas as pd
import tensorflow as tf
import datetime
import os
from time import time
from tensorflow.keras.callbacks import Callback, ModelCheckpoint, EarlyStopping
import tensorflow_probability as tfp
import tensorflow_probability.python.distributions as tfd
import tensorflow_probability.python.bijectors as tfb
import tensorflow_probability.python.layers as tfl
from tensorflow.keras.layers import Input, Dense, Dropout, GRU
from tensorflow.keras.models import Model
from tensorflow.keras.optimizers import Adam
from visualizations import *


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
        # print(distr)
        # print(y)
        if self.config.label_width == 1:
            y_reshape = y
        else:
            y_reshape = tf.reshape(y, [-1, self.config.input_width, self.config.label_width])
            # print(y_reshape)
        return -distr.log_prob(y_reshape)

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
                tfd.Normal(loc=t[..., :n],
                           scale=1e-5 + tf.nn.softplus(c + t[..., n:])),
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

    def train_linear_model(self, country):
        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        x_train, y_train = next(iter(ds_train))

        # Build model.
        model = tf.keras.Sequential([
            tf.keras.layers.Dense(1),
            tfl.DistributionLambda(lambda t: tfd.Normal(loc=t, scale=1)),
        ])

        # Do inference.
        model.compile(optimizer=tf.optimizers.Adam(learning_rate=0.01), loss=tf.keras.metrics.mse)
        result = model.fit(ds_train, epochs=self.config.epochs, validation_data=ds_val, verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        self.plot_results(model, result, country, ds_train, ds_val, ds_test)

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
        self.plot_results(model, result, country, ds_train, ds_val, ds_test)

        return model

    def train_variational_model(self, country):

        self.window = WindowGenerator(self.config, self.config.input_width, self.config.label_width, self.config.shift,
                                      df=self.df, label_columns=self.config.target_cols,
                                      country=country)
        ds_train, ds_val, ds_test = self.window.make_dataset(shuffle=self.config.shuffle)
        x_train, y_train = next(iter(ds_train))

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
        result = model.fit(ds_train, epochs=self.config.epochs, validation_data=ds_val, verbose=True)

        export_dir = self.config.final_model_path + self.model_path
        model.save_weights(export_dir)
        self.plot_results(model, result, country, ds_train, ds_val, ds_test)

        return model

    def plot_results(self, model, result, country, ds_train, ds_val, ds_test):
        for col in self.config.target_cols:
            self.window.plot_bayesian(model, plot_model="train", plot_col=col,
                                      image_path=self.config.graphs_path + self.image_path)
            self.window.plot_bayesian(model, plot_model="val", plot_col=col,
                                      image_path=self.config.graphs_path + self.image_path)
            self.window.plot_bayesian(model, plot_model="test", plot_col=col,
                                      image_path=self.config.graphs_path + self.image_path)

        # model.save_weights(filepath=self.config.final_model_path + self.model_path + "_model.h5")
        # model_json = model.to_json()
        # with open(self.config.final_model_path + self.model_path + ".json", "w") as json_file:
        #     json_file.write(model_json)
        # tf.keras.models.save_model(model, self.config.final_model_path + self.model_path + "_model.h5")
        # tf.saved_model.save(model, self.config.final_model_path + self.model_path + "_model")
        # model.save(self.model_path + "_model")

        # plot model result
        plot_train_history(result, 'Single Step Training and validation loss for ' + country + " " +
                           datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.0Z"),
                           self.config.final_model_path + self.image_path)
        plot_loss(result.history, "loss for " + country + " "
                  + datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.0Z"),
                  self.config.final_model_path + self.image_path)

        train_performance = model.evaluate(ds_train)
        val_performance = model.evaluate(ds_val)
        test_performance = model.evaluate(ds_test, verbose=1)

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

