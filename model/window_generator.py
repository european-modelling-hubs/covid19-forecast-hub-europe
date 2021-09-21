import matplotlib.pyplot as plt
import tensorflow as tf
import numpy as np
from scipy.stats import poisson


class WindowGenerator:
    def __init__(self, config, input_width, label_width, shift, df, mode="all", label_columns=None, country="None"):
        self.config = config
        # Store the raw data.
        self.df = df
        self.df_train = df[0:int(len(df) * (self.config.train_data_pcnt / 100))]
        self.df_valid = df[int(len(df)*(self.config.train_data_pcnt/100)):
                           int(len(df)*((self.config.train_data_pcnt +
                                        self.config.valid_data_pcnt)/100))]
        self.df_test = df[-int(len(df) * (self.config.test_data_pcnt / 100)):]
        # self.df_mean = self.df_train_raw.mean()
        # self.df_std = self.df_train_raw.std()
        self.mode = mode
        self.country = country

        # self.df = (self.df_raw - self.df_mean) / self.df_std
        # self.df = (self.df_raw - self.df_train_raw.min()) / (self.df_train_raw.max() - self.df_train_raw.min())
        # self.df_train = (self.df_train_raw - self.df_train_raw.min()) / (self.df_train_raw.max() - self.df_train_raw.min())
        # self.df_valid = (self.df_valid_raw - self.df_train_raw.min()) / (self.df_train_raw.max() - self.df_train_raw.min())
        # self.df_test = (self.df_test_raw - self.df_train_raw.min()) / (self.df_train_raw.max() - self.df_train_raw.min())
        # self.df = df
        self.ds_train = None
        self.ds_val = None
        self.ds_test = None
        self._example = None

        # Work out the label column indices.
        self.label_columns = label_columns
        if label_columns is not None:
            self.label_columns_indices = {name: i for i, name in enumerate(label_columns)}
        self.column_indices = {name: i for i, name in enumerate(self.df.columns)}

        # Work out the window parameters.
        self.input_width = input_width  # self.config.rnn_window_size
        self.label_width = label_width  # self.config.rnn_window_size
        self.shift = shift  # self.config.rnn_output_size

        self.total_window_size = self.input_width + self.shift

        self.input_slice = slice(0, self.input_width)
        self.input_indices = np.arange(self.total_window_size)[self.input_slice]

        self.label_start = self.total_window_size - self.label_width
        self.labels_slice = slice(self.label_start, None)
        self.label_indices = np.arange(self.total_window_size)[self.labels_slice]

    def __repr__(self):
        return '\n'.join([
            f'Total window size: {self.total_window_size}',
            f'Input indices: {self.input_indices}',
            f'Label indices: {self.label_indices}',
            f'Label column name(s): {self.label_columns}'])

    def split_window(self, features):
        inputs = features[:, self.input_slice, :]
        labels = features[:, self.labels_slice, :]
        if self.label_columns is not None:
            labels = tf.stack(
                [labels[:, :, self.column_indices[name]] for name in self.label_columns],
                axis=-1)

        # Slicing doesn't preserve static shape information, so set the shapes manually.
        # This way the `tf.data.Datasets` are easier to inspect.
        inputs.set_shape([None, self.input_width, None])
        labels.set_shape([None, self.label_width, None])

        return inputs, labels

    # def plot(self, model=None, plot_col='close', max_subplots=3, plot_model="random"):
    #     config = Configuration()
    #     if config.display_images:
    #         if plot_model is "train":
    #             inputs_raw, labels_raw = self.example_train
    #         elif plot_model is "val":
    #             inputs_raw, labels_raw = self.example_val
    #         elif plot_model is "test":
    #             inputs_raw, labels_raw = self.example_test
    #         else:
    #             inputs_raw, labels_raw = self.example_random
    #         plot_col_index = self.column_indices[plot_col]
    #         inputs = (inputs_raw * self.df_std) + self.df_mean
    #         labels = (labels_raw[:, :, plot_col_index:plot_col_index + 1] * self.df_std) + self.df_mean
    #
    #         plt.figure(figsize=(12, 8))
    #         max_n = min(max_subplots, len(inputs))
    #         for n in range(max_n):
    #             plt.subplot(max_n, 1, n + 1)
    #             plt.ylabel(f'{plot_col}')
    #
    #             if self.label_columns:
    #                 label_col_index = self.label_columns_indices.get(plot_col, None)
    #             else:
    #                 label_col_index = plot_col_index
    #
    #             plt.plot(self.input_indices, inputs_raw[n, :, label_col_index],
    #                      label='Inputs', marker='.', zorder=-10)
    #             plt.scatter(self.label_indices, labels[n, :, label_col_index],
    #                         edgecolors='k', label='Labels', c='#2ca02c', s=64)
    #             if model is not None:
    #                 predictions_raw = model(inputs_raw)
    #                 predictions = (predictions_raw[:, :, plot_col_index:plot_col_index + 1] * self.df_std) + self.df_mean
    #                 plt.plot(range(self.label_indices[0]), predictions[n, :, label_col_index], marker='.', zorder=-10)
    #                 plt.scatter(range(self.label_indices[0]), predictions[n, :, label_col_index],
    #                             marker='X', edgecolors='k', label='Predictions', c='#ff7f0e', s=64)
    #
    #             if n == 0:
    #                 plt.legend()
    #                 plt.title(f'Conjunto de {plot_model} - {plot_col} - '
    #                           f'{datetime.datetime.now().strftime("%Y-%m-%dT%H:%M:%S.0Z")}')
    #
    #         plt.xlabel('Time [days]')
    #         plt.show()
    #
    #         return

    def plot_linear_model(self, model=None, plot_col='cases', plot_model="random", plot_quantile=True,
                          image_path=None, x=None, y=None):
        plot_col_index = self.column_indices[plot_col]

        if self.label_columns:
            label_col_index = self.label_columns_indices.get(plot_col, None)
        else:
            label_col_index = plot_col_index

        fig, ax = plt.subplots(1, 1, figsize=(12, 8))
        # dates = self.df_test.index
        num_days = len(x)

        pred_cases_raw = model(x)
        mean = pred_cases_raw.mean()
        std = pred_cases_raw.stddev()
        # mean_desc = self.descale(predictions_raw=mean, col=plot_col)
        # std_desc = self.descale(predictions_raw=std, col=plot_col)
        posterior_quantile = np.percentile(mean, self.config.quantiles, axis=-1, interpolation="midpoint")
        ax.plot(range(num_days), mean, '--X', color='#ff7f0e', label='Posterior median', lw=3, markersize=6)
        if plot_quantile:
            ax.plot(range(num_days), mean + 2 * std, color='b', label='50% quantile', alpha=.4, lw=3)
            ax.plot(range(num_days), mean - 2 * std, color='b', label='50% quantile', alpha=.4, lw=3)
            # ax.fill_between(range(num_days), posterior_quantile[self.config.quantile_50_low_index, :num_days],
            #                 posterior_quantile[self.config.quantile_50_high_index, :num_days],
            #                 color='b', label='50% quantile', alpha=.4, lw=3)
            # ax.fill_between(range(num_days), posterior_quantile[self.config.quantile_95_low_index, :num_days],
            #                 posterior_quantile[self.config.quantile_95_high_index, :num_days],
            #                 color='b', label='95% quantile', alpha=.2, lw=3)

        # observed_raw = y[:, :, label_col_index]
        # observed = self.descale(y, plot_col)
        ax.plot(range(num_days), y[:num_days], '--o', color='k', markersize=6, label='Observed '+plot_col)

        ax.xaxis.set_tick_params(rotation=45)
        ax.set_title(plot_model + " set for " + self.country + " " + plot_col)
        ax.set_xlabel('Day', fontsize='large')
        ax.set_ylabel(plot_col, fontsize='large')
        fontsize = 'large'
        ax.legend(loc='upper left', fontsize=fontsize)
        ax.axhline(y=0, color='k', linestyle='--')

        plt.tight_layout()
        if self.config.save_images:
            plt.savefig(image_path + "_predictions.png")
        if self.config.display_images:
            plt.show()

        return

    def plot_bayesian(self, model=None, plot_col='cases', max_subplots=3, plot_model="random", plot_quantile=True,
                      image_path=None):
        # if config.display_images:
        if plot_model is "train":
            x_test, y_test = self.example_train
        elif plot_model is "val":
            x_test, y_test = self.example_val
        elif plot_model is "test":
            x_test, y_test = self.example_test
        else:
            x_test, y_test = self.example_random
        plot_col_index = self.column_indices[plot_col]

        if self.label_columns:
            label_col_index = self.label_columns_indices.get(plot_col, None)
        else:
            label_col_index = plot_col_index

        # x_test, y_test = tuple(zip(*self.example_test))
        # x_test, y_test = self.example_test

        fig, ax = plt.subplots(1, 1, figsize=(24, 16))
        # dates = self.df_test.index
        num_days = len(x_test)

        ax.set_title(self.country)

        pred_cases_raw = model(x_test)
        # samples = pred_cases_raw[:, :, label_col_index]
        samples = pred_cases_raw.sample()
        samples_desc = self.descale(predictions_raw=samples, col=plot_col)
        posterior_quantile = np.percentile(samples_desc, self.config.quantiles, axis=-1, interpolation="midpoint")
        ax.plot(range(num_days), posterior_quantile[self.config.median_quantile_index, :num_days],
                '--X', color='#ff7f0e', label='Posterior median', lw=2, markersize=6)
        if plot_quantile:
            ax.fill_between(range(num_days), posterior_quantile[self.config.quantile_50_low_index, :num_days, 0],
                            posterior_quantile[self.config.quantile_50_high_index, :num_days, 0],
                            color='b', label='50% quantile', alpha=.4)
            ax.fill_between(range(num_days), posterior_quantile[self.config.quantile_95_low_index, :num_days, 0],
                            posterior_quantile[self.config.quantile_95_high_index, :num_days, 0],
                            color='b', label='95% quantile', alpha=.2)

        observed_raw = y_test[:, :, label_col_index]
        observed = self.descale(observed_raw, plot_col)
        # observed = (observed_raw * (self.df_raw["cases"].max() - self.df_raw["cases"].min())) \
        #            + self.df_raw["cases"].min()
        # observed = (observed_raw * self.df_std["cases"]) + self.df_mean["cases"]
        ax.plot(range(num_days), observed[:num_days], '--o', color='k', markersize=6, label='Observed '+plot_col)

        ax.xaxis.set_tick_params(rotation=45)
        ax.set_title(self.country + " " + plot_col)
        ax.set_xlabel('Day', fontsize='large')
        ax.set_ylabel(plot_col, fontsize='large')
        fontsize = 'medium'
        ax.legend(loc='upper right', fontsize=fontsize)
        ax.axhline(y=0, color='k', linestyle='--')

        plt.tight_layout()
        if self.config.save_images:
            plt.savefig(image_path + "_predictions.png")
        if self.config.display_images:
            plt.show()

        return

    # def make_plot_runs(self, alpha_data=1, ylim=[-7, 8], model=None, runs=200, plot_col='close',
    #                    max_subplots=3, plot_model="random"):
    #     config = Configuration()
    #     if config.display_images:
    #         if plot_model is "train":
    #             inputs_raw, labels_raw = self.example_train
    #         elif plot_model is "val":
    #             inputs_raw, labels_raw = self.example_val
    #         elif plot_model is "test":
    #             inputs_raw, labels_raw = self.example_test
    #         else:
    #             inputs_raw, labels_raw = self.example_random
    #         plot_col_index = self.column_indices[plot_col]
    #         inputs = (inputs_raw * self.df_std) + self.df_mean
    #         labels = (labels_raw[:, :, plot_col_index:plot_col_index + 1] * self.df_std) + self.df_mean
    #
    #         plt.figure(figsize=(12, 8))
    #         max_n = min(max_subplots, len(inputs))
    #         for n in range(max_n):
    #             plt.subplot(max_n, 1, n + 1)
    #             plt.ylabel(f'{plot_col}')
    #
    #             if self.label_columns:
    #                 label_col_index = self.label_columns_indices.get(plot_col, None)
    #             else:
    #                 label_col_index = plot_col_index
    #
    #             plt.plot(self.input_indices, inputs[n, :, label_col_index],
    #                      label='Inputs', marker='.', zorder=-10)
    #             plt.scatter(self.label_indices, labels[n, :, label_col_index],
    #                         edgecolors='k', label='Labels', c='#2ca02c', s=64)
    #             if model is not None:
    #                 predictions_raw = np.zeros((runs, len(inputs_raw)))
    #                 predictions = np.zeros((runs, len(inputs_raw)))
    #                 # for i in range(0, runs):
    #                 predictions_raw = model.predict(inputs_raw)
    #                 predictions = (predictions_raw[:, :,
    #                                plot_col_index:plot_col_index + 1] * self.df_std) + self.df_mean
    #                 ax = plt.subplot()
    #                 ax.scatter(self.label_indices, predictions, color="steelblue", alpha=alpha_data, marker='.')  # observed
    #                 for i in range(0, predictions.shape[0]):
    #                     ax.plot(self.label_indices, predictions[i], color="black", linewidth=.5)
    #                 ax.set_ylim(ylim)
    #
    #         plt.xlabel('Time [days]')
    #         plt.show()

    def print_prediction(self, country, predictions, plot_col="cases"):
        plot_col_index = self.column_indices[plot_col]
        for n in range(len(predictions)):
            print("Predicción de ", country, f", valor de {plot_col} = ",
                  predictions[n, :, plot_col_index:plot_col_index+1])

        return

    def print_bayesian_prediction(self, observed, predictions, plot_col):
        # plot_col_index = self.column_indices[plot_col]
        # if self.label_columns:
        #     label_col_index = self.label_columns_indices.get(plot_col, None)
        # else:
        #     label_col_index = plot_col_index
        # for n in range(len(predictions)):
            # samples = predictions[:, :, label_col_index]
            # posterior_quantile = np.percentile(samples, [2.5, 25, 50, 75, 97.5], axis=-1)
        print(str(self.country).upper() + ":")
        print("Posterior Median = " + str(predictions[self.config.median_quantile_index, plot_col]))
        print("50% quantile = " + str(predictions[self.config.quantile_50_low_index, plot_col]) + ", " +
              str(predictions[self.config.quantile_50_high_index, plot_col]))
        print("95% quantile = " + str(predictions[self.config.quantile_95_low_index, plot_col]) + ", " +
              str(predictions[self.config.quantile_95_high_index, plot_col]))
        print("Observed " + str(observed[0, 0, 0]))

        return

    def plot_bayesian_prediction(self, prior_observed, observed, predictions, plot_col, plot_col_name):
        # plot_col_index = self.column_indices[plot_col]
        # if self.label_columns:
        #     label_col_index = self.label_columns_indices.get(plot_col, None)
        # else:
        #     label_col_index = plot_col_index

        fig, ax = plt.subplots(1, 1, figsize=(20, 14))
        # dates = self.df_test.index
        num_days = len(predictions)
        num_days_prior = len(prior_observed[0])

        ax.set_title(self.country)

        # samples = predictions[:, :, label_col_index]
        # posterior_quantile = np.percentile(samples, [2.5, 25, 50, 75, 97.5], axis=-1)

        ax.plot(num_days_prior, predictions[self.config.median_quantile_index, plot_col], 'X', color='#ff7f0e',
                label='Posterior median', lw=2, markersize=8)
        ax.fill_between(range(num_days), predictions[self.config.quantile_50_low_index, plot_col],
                        predictions[self.config.quantile_50_high_index, plot_col], color='b', label='50% quantile',
                        alpha=.4)
        ax.fill_between(range(num_days), predictions[self.config.quantile_95_low_index, plot_col],
                        predictions[self.config.quantile_95_high_index, plot_col], color='b', label='95% quantile',
                        alpha=.2)

        ax.plot(num_days_prior, observed[0, 0, 0], '--o', color='g',
                markersize=8, label='Observed ' + plot_col_name)
        ax.plot(range(num_days_prior), prior_observed[0, :num_days_prior, plot_col], '--o', color='k',
                markersize=8, label='Observed ' + plot_col_name)

        ax.xaxis.set_tick_params(rotation=45)
        ax.set_title(self.country + " " + plot_col_name)
        ax.set_xlabel('Day', fontsize='large')
        ax.set_ylabel(plot_col, fontsize='large')
        fontsize = 'medium'
        ax.legend(loc='upper left', fontsize=fontsize)
        ax.axhline(y=0, color='k', linestyle='--')

        plt.tight_layout()
        # if self.config.save_images:
        #     plt.savefig(image_path + "_predictions.png")
        if self.config.display_images:
            plt.show()

        return

    def descale(self, predictions_raw, col="cases"):
        col_index = self.column_indices[col]
        # predictions = (predictions_raw[:, :, col_index:col_index + 1] * self.df_std) + self.df_mean
        predictions = (predictions_raw * (self.df_train_raw[col].max() - self.df_train_raw[col].min())) \
                      + self.df_train_raw[col].min()

        return predictions

    def get_col_index(self, col="cases"):
        return self.column_indices[col]

    def make_dataset(self, data_type="train", shuffle=True):
        data = np.array(self.df, dtype=np.float32)
        if data_type == "pred":
            ds = tf.keras.preprocessing.timeseries_dataset_from_array(data=data, targets=None,
                                                                      sequence_length=self.total_window_size,
                                                                      sequence_stride=1, shuffle=shuffle,
                                                                      batch_size=1)
        else:
            ds = tf.keras.preprocessing.timeseries_dataset_from_array(data=data, targets=None,
                                                                      sequence_length=self.total_window_size,
                                                                      sequence_stride=self.config.stride,
                                                                      shuffle=shuffle,
                                                                      batch_size=self.config.batch_size)

        train_size = int(len(ds) * (self.config.train_data_pcnt / 100))
        valid_size = int(len(ds) * (self.config.valid_data_pcnt / 100))
        # test_size = int(len(ds) * (self.config.test_data_pcnt / 100))
        # if self.mode == "train":
        #     if data_type == "train":
        #         ds = ds.take(train_size)
        #     elif data_type == "val":
        #         ds = ds.skip(train_size)
        #         ds = ds.take(valid_size)
        #     else:
        #         ds = ds.skip(train_size)
        #         ds = ds.skip(valid_size)
        #         ds = ds.take(-1)
        if self.mode == "all":
            self.ds_train = ds.take(train_size)
            ds = ds.skip(train_size)
            self.ds_val = ds.take(valid_size)
            ds = ds.skip(valid_size)
            self.ds_test = ds.take(-1)
            if data_type != "pred":
                self.ds_train = self.ds_train.map(self.split_window)
                self.ds_val = self.ds_val.map(self.split_window)
            self.ds_test = self.ds_test.map(self.split_window)

            return self.ds_train, self.ds_val, self.ds_test

        if data_type != "pred":
            ds = ds.map(self.split_window)  # .repeat()

        return ds

    def make_pred_dataset(self, data):
        data = np.array(data, dtype=np.float32)
        ds = tf.keras.preprocessing.timeseries_dataset_from_array(data=data, targets=None,
                                                                  sequence_length=self.total_window_size,
                                                                  sequence_stride=1, shuffle=False,
                                                                  batch_size=1)
        # ds = ds.map(self.split_window)

        return ds

    @property
    def train(self):
        return self.make_dataset("train", shuffle=True)

    @property
    def val(self):
        return self.make_dataset("val", shuffle=True)

    @property
    def test(self):
        return self.make_dataset("test", shuffle=True)

    @property
    def pred(self):
        result = self.make_dataset("pred", shuffle=False)
        return result[2]

    @property
    def example_random(self):
        """Get and cache an example batch of `inputs, labels` for plotting."""
        result = getattr(self, '_example', None)
        if result is None:
            # No example batch was found, so get one from the `.train` dataset
            result = next(iter(self.ds_train))
            # And cache it for next time
            self._example = result
        return result

    @property
    def example_train(self):
        """Get and cache an example batch of `inputs, labels` for plotting."""
        result = next(iter(self.ds_train))
        # And cache it for next time
        self._example = result

        return result

    @property
    def example_val(self):
        """Get and cache an example batch of `inputs, labels` for plotting."""
        result = next(iter(self.ds_val))
        # And cache it for next time
        self._example = result

        return result

    @property
    def example_test(self):
        """Get and cache an example batch of `inputs, labels` for plotting."""
        result = next(iter(self.ds_test))
        # And cache it for next time
        self._example = result

        return result
