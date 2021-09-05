from window_generator import WindowGenerator
# from data_management import *
# from configuration import Configuration
# from training import Training
# import model_config
#
# import pandas as pd
# import tensorflow as tf
# import datetime
# import os
# from time import time
# from tensorflow.keras.callbacks import Callback, ModelCheckpoint, EarlyStopping
# import tensorflow_probability as tfp
# import tensorflow_probability.python.distributions as tfd
# import tensorflow_probability.python.bijectors as tfb
# import tensorflow_probability.python.layers as tfl
# from tensorflow.keras.layers import Input
# from tensorflow.keras.models import Model
# from tensorflow.keras.optimizers import Adam
from visualizations import *


class Predictor:
    def __init__(self, df: pd.DataFrame, config: Configuration, window: WindowGenerator, model_path: str,
                 image_path: str, **kwargs):
        super().__init__(**kwargs)  # handles standard args (e.g., name)
        self.df = df
        self.config = config
        self.model_path = model_path
        self.image_path = image_path
        self.window = window

    # Specify the surrogate posterior over `keras.layers.Dense` `kernel` and `bias`.
    # def posterior_mean_field(self, kernel_size, bias_size=0, dtype=None):
    #     n = kernel_size + bias_size
    #     c = np.log(np.expm1(1.))
    #     return tf.keras.Sequential([
    #         tfl.VariableLayer(2 * n, dtype=dtype),
    #         tfl.DistributionLambda(lambda t: tfd.Independent(
    #             tfd.Normal(loc=t[..., :n],
    #                        scale=1e-5 + tf.nn.softplus(c + t[..., n:])),
    #             reinterpreted_batch_ndims=1)),
    #     ])
    #
    # # Specify the prior over `keras.layers.Dense` `kernel` and `bias`.
    # def prior_trainable(self, kernel_size, bias_size=0, dtype=None):
    #     n = kernel_size + bias_size
    #     return tf.keras.Sequential([
    #         tfl.VariableLayer(n, dtype=dtype),
    #         tfl.DistributionLambda(lambda t: tfd.Independent(
    #             tfd.Normal(loc=t, scale=1),
    #             reinterpreted_batch_ndims=1)),
    #     ])

    def predict_variational_model(self, country, num_preds=1, model=None):

        # if model is None:
        # model = tf.keras.models.model_from_json(
        #     open(filepath).read(),
        #     custom_objects={'DenseVariational': tfl.DenseVariational}
        # )

        if self.window is None:
            test_df = self.df[(-self.config.input_width - self.config.label_width) * num_preds:]
            self.window = WindowGenerator(config=self.config, input_width=self.config.input_width,
                                          label_width=self.config.label_width, shift=self.config.shift,
                                          df=test_df, label_columns=self.config.target_cols, country=country)

        for col in self.config.target_cols:
            predictions = []
            x_test_desc = []
            y_test_desc = []
            for i in range(num_preds):
                # Build model
                # model = tf.keras.Sequential([
                #    tfl.DenseVariational(1 + len(self.config.target_cols), self.posterior_mean_field, self.prior_trainable,
                #                          kl_weight=1 / window.df_train.shape[0]),
                #     tfl.DistributionLambda(
                #         lambda t: tfd.Normal(loc=t[..., :1],
                #                              scale=1e-3 + tf.math.softplus(0.1 * t[..., 1:]))),
                # ])

                # filepath = self.config.final_model_path + self.model_path + "_model.h5"
                # model = tf.keras.models.load_model(filepath=filepath)

                pred_data = next(iter(self.window.pred))
                x_test, y_test = pred_data
                predictions_raw = model(x_test)
                predictions[i] = self.window.descale(predictions_raw=predictions_raw, col=col)
                y_test_desc[i] = self.window.descale(predictions_raw=y_test, col=col)
                x_test_desc[i] = self.window.descale(predictions_raw=x_test, col=col)

            self.window.print_bayesian_prediction(observed=y_test_desc, predictions=predictions, plot_col=col)
            self.window.plot_bayesian_prediction(prior_observed=x_test_desc, observed=y_test_desc,
                                                 predictions=predictions, plot_col=col)

        return
