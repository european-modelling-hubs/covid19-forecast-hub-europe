import data_management
import datetime
import os
import numpy as np
import pandas as pd
from configuration import Configuration
from window_generator import WindowGenerator
from training import Training
from predictor import Predictor
# os.system("pip install --upgrade tensorflow-probability")
# os.system("pip uninstall -y tf-nightly tfp-nightly")
import model_config


def main():
    config = Configuration()

    for country in config.countries:
        df = data_management.read_truth_data(config.data_path + "truth_JHU-Incident Cases.csv",
                                             config.data_path + "truth_JHU-Incident Deaths.csv", country=country,
                                             period=config.period, last_day=config.last_day)

        image_path = "{0}_{1}_{2}".format(country, config.target_cols, datetime.datetime.today().strftime("%Y%m%d"))
        if config.is_model_custom_name:
            file_path = config.model_custom_name
        else:
            file_path = "{0}_{1}".format(country, datetime.datetime.today().strftime("%Y%m%d"))
        train = Training(df=df, config=config, model_path=file_path, image_path=image_path)
        # model = train.train_linear_model(country)
        # model = train.train_gru_model(country)
        model = train.train_variational_model(country)
        # model = train.train_flipout_model(country)
        # model = train.train_mc_dropout_model(country)

        df_pred = data_management.read_truth_data(config.data_path + "truth_JHU-Incident Cases.csv",
                                                  config.data_path + "truth_JHU-Incident Deaths.csv", country=country,
                                                  period=config.period)
        predict = Predictor(df=df_pred, config=config, model_path=file_path, image_path=image_path)
        predict.predict_variational_model(country=country, model=model, num_preds=1)

    return


if __name__ == '__main__':
    main()
