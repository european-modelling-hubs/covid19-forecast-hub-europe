
class Configuration:
    def __init__(self):
        self.data_path = "C:/Users/pmarc/PycharmProjects/covid19-forecast-hub-europe/data-truth/JHU/"
        self.target_cols = ["cases"]
        self.input_width = 3
        self.label_width = 1  # Number of days to predict
        self.shift = 1
        self.stride = 1
        self.batch_size = 16
        self.train_data_pcnt = 70
        self.valid_data_pcnt = 20
        self.test_data_pcnt = 10
        self.epochs = 1000
        self.steps_per_epoch = 50
        self.validation_steps = 20
        self.patience = 10
        self.checkpoint_path = "Models/Checkpoints/"
        self.final_model_path = "Models/Final/"
        self.results_path = "Models/Results/"
        self.graphs_path = "Models/Graphs/"
        self.is_model_custom_name = False
        self.model_custom_name = "_16052021_M0.h5"
        self.display_images = True
        self.save_images = True
        self.shuffle = False
        self.period = "weeks"
