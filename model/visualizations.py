import matplotlib.pyplot as plt
import matplotlib.gridspec as gridspec
import matplotlib as mpl
import pandas as pd
import numpy as np
import seaborn as sns

from configuration import Configuration


def plot_series(series, n_steps, y=None, y_pred=None, x_label="$t$", y_label="$x(t)$"):
    plt.plot(series, ".-")
    if y is not None:
        plt.plot(n_steps, y, "bx", markersize=10)
    if y_pred is not None:
        plt.plot(n_steps, y_pred, "ro")
    plt.grid(True)
    if x_label:
        plt.xlabel(x_label, fontsize=16)
    if y_label:
        plt.ylabel(y_label, fontsize=16, rotation=0)
    plt.hlines(0, 0, 100, linewidth=1)
    plt.axis([0, n_steps + 1, -1, 1])


# def plot_learning_curves(loss, val_loss):
#     plt.plot(np.arange(len(loss)) + 0.5, loss, "b.-", label="Training loss")
#     plt.plot(np.arange(len(val_loss)) + 1, val_loss, "r.-", label="Validation loss")
#     plt.gca().xaxis.set_major_locator(mpl.ticker.MaxNLocator(integer=True))
#     plt.axis([1, 20, 0, 0.05])
#     plt.legend(fontsize=14)
#     plt.xlabel("Epochs")
#     plt.ylabel("Loss")
#     plt.grid(True)


def plot_loss(history, title, image_path):
    config = Configuration()
    loss_history = pd.DataFrame(history)
    # loss_history.columns = columns
    loss_history.plot(logy=True, lw=2)
    plt.title(title)

    if config.save_images:
        plt.savefig(image_path + "_loss.png")
    if config.display_images:
        plt.show()

def plot_train_history(history, title, image_path):
    config = Configuration()
    loss = history.history['loss']
    val_loss = history.history['val_loss']

    epochs = range(len(loss))

    plt.figure()

    plt.plot(epochs, loss, 'b', label='Training loss')
    plt.plot(epochs, val_loss, 'r', label='Validation loss')
    plt.title(title)
    plt.legend()

    if config.save_images:
        plt.savefig(image_path + "_train_history.png")
    if config.display_images:
        plt.show()


def plot_in_out_sample(actuals, predictions, ax, target_col):
    config = Configuration()
    if config.display_images:
        actuals[target_col].plot(lw=3, ax=ax, c='k')
        predictions["prediction"].plot(lw=1, ax=ax, c='r')
        ax.set_title('In- and Out-of-sample Predictions')


def plot_correlations(results, ax, target_col):
    corr = {}
    for run, df in results.groupby('data'):
        corr[run] = df[target_col].corr(df.prediction)
    sns.scatterplot(x=target_col, y='prediction', data=results, hue='data', ax=ax)
    ax.text(x=.02, y=.85, s='Valid IC ={:.2%}'.format(corr['valid']), transform=ax.transAxes)
    ax.text(x=.02, y=.75, s='Train IC={:.2%}'.format(corr['train']), transform=ax.transAxes)
    ax.set_title('Correlation')
    ax.legend(loc='lower right')


def plot_error(predict, y, ax, error: float, title_text: str):
    sns.distplot(predict.squeeze() - y.squeeze(), ax=ax)
    ax.set_title(title_text)
    ax.text(x=.03, y=.9, s='RMSE ={:.4f}'.format(error), transform=ax.transAxes)


def print_report(actuals: pd.DataFrame, predictions: pd.DataFrame):
    print("Fecha    |    Predicción   |   Valor real")
    for i in range(0, len(actuals)):
        print(predictions.index[i], predictions.values[i], "  |  ", actuals.values[i], "  |  ",
              predictions.values[i]-actuals.values[i])
    print("Mean difference: {:.2f}".format(np.mean(np.abs(actuals.values - predictions.values))))
    print("Std difference: {:.2f}".format(np.std(np.abs(actuals.values - predictions.values))))
