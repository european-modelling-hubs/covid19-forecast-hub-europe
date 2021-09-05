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

    countries = [
        'Austria',
        # 'Belgium',
        # 'Bulgaria',
        # 'Croatia',
        # 'Cyprus',
        # 'Czechia',
        # 'Denmark',
        # 'Estonia',
        # 'Finland',
        # 'France',
        # 'Germany',
        # 'Greece',
        # 'Hungary',
        # 'Iceland',
        # 'Ireland',
        # 'Italy',
        # 'Latvia',
        # 'Liechtenstein',
        # 'Lithuania',
        # 'Luxembourg',
        # 'Malta',
        # 'Netherlands',
        # 'Norway',
        # 'Poland',
        # 'Portugal',
        # 'Romania',
        # 'Slovakia',
        # 'Slovenia',
        # 'Spain',
        # 'Sweden',
        # 'Switzerland',
        # 'United Kingdom'
    ]

    for country in countries:
        df = data_management.read_truth_data(config.data_path + "truth_JHU-Incident Cases.csv",
                                             config.data_path + "truth_JHU-Incident Deaths.csv", country, config.period)

        image_path = "{0}_{1}_{2}".format(country, config.target_cols, datetime.datetime.today().strftime("%Y%m%d"))
        file_path = "{0}_{1}".format(country, datetime.datetime.today().strftime("%Y%m%d"))
        train = Training(df=df, config=config, model_path=file_path, image_path=image_path)
        model = train.train_variational_model(country)
        # predict = Predictor(df=df, config=config, model_path=file_path, window=train.window, image_path=image_path)
        # predict.predict_variational_model(country=country, model=model, num_preds=5)

    return


if __name__ == '__main__':
    main()
