import pandas as pd


def read_truth_data(filepath, filepath_deaths, country="all", period="weeks", first_day=None,
                    last_day=None):
    df = pd.read_csv(filepath)
    df_deaths = pd.read_csv(filepath_deaths)
    if country == "all":
        df_filtered = df
        df_deaths_filtered = df_deaths
    else:
        df_filtered = df[(df["location_name"] == country)]
        df_deaths_filtered = df_deaths[(df_deaths["location_name"] == country)]

    df_filtered["value"] = df_filtered["value"].where(df_filtered["value"] >= 0, other=-df_filtered["value"], axis=0)
    df_deaths_filtered["value"] = df_deaths_filtered["value"].where(df_deaths_filtered["value"] >= 0,
                                                                    other=-df_deaths_filtered["value"], axis=0)
    df_filtered["date"] = pd.to_datetime(df_filtered["date"])
    df_filtered.set_index(df_filtered["date"], inplace=True)
    df_deaths_filtered["date"] = pd.to_datetime(df_deaths_filtered["date"])
    df_deaths_filtered.set_index(df_deaths_filtered["date"], inplace=True)
    df_filtered.drop("date", axis=1, inplace=True)
    df_filtered.drop("location", axis=1, inplace=True)
    df_filtered.drop("location_name", axis=1, inplace=True)
    df_filtered["cases"] = df_filtered["value"]
    df_filtered.drop(labels="value", axis=1, inplace=True)
    # df_filtered["deaths"] = df_deaths_filtered["value"]
    # df_filtered.replace(to_replace='United Kingdom', value='United_Kingdom', inplace=True)

    # Include data only after 1th case in a country.
    # mask = df_filtered['cases'].cumsum() >= 1

    # Get the date that the epidemic starts in a country.
    # first_day = df_filtered.index[mask][0]  # - pd.to_timedelta(START_DAYS, 'days')
    if first_day is not None:
        df_filtered = df_filtered.truncate(before=first_day)
    if last_day is not None:
        df_filtered = df_filtered.truncate(after=last_day)

    if period == "weeks":
        # df_filtered = df_filtered.groupby(pd.Grouper(freq="W", key="date"))["cases", "deaths"].sum()
        df_filtered = df_filtered.resample("w-sat", convention="end").sum()

    return df_filtered
