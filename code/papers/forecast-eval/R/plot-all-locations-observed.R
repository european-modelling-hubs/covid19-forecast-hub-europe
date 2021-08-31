# plot observed values for cases and deaths over hub timeline
library(here)
library(dplyr)
library(covidHubUtils)
library(ggplot2)
library(forcats)
library(gghighlight)


raw_truth <- load_truth(
  truth_source = "JHU",
  temporal_resolution = "weekly",
  truth_end_date = "2021-08-23",
  hub = "ECDC"
)

# some cleaning
truth_plot <- raw_truth %>%
  filter(target_variable %in% c("inc case", "inc death") &
           target_end_date >= as.Date("2021-03-08")) %>%
  mutate(target_variable = recode(target_variable,
                                  "inc case" = "Cases",
                                  "inc death" = "Deaths")) %>%
  group_by(target_end_date) %>%
  mutate(location_name = fct_reorder(location_name, value)) %>%
  ungroup() #

locs <- truth_plot %>%
  group_by(location, target_variable) %>%
  summarise(mean_value = mean(value),
            per_1000 = mean(value / population * 1000))

# countries to highlight
truth_plot <- truth_plot %>%
  value_per_pop = case_when(
    location == "Cases" ~ (value / population) * 1000,
  target_variable == "Deaths" ~ (value / population) * 100000)) %>%

# Plot
truth_plot %>%
  ggplot(aes(x = target_end_date)) +
  geom_col(aes(y = value, fill = location_name)) +
  gghighlight(max(value_per_pop) > 3) +
  scico::scale_fill_scico_d(palette = "roma") +
  facet_wrap(~ target_variable, scales = "free") +
  theme_bw() +
  theme(legend.position = "bottom")
  

# get anomalies
anomalies <- read_csv(here("data-truth", "anomalies", "anomalies.csv"))



truth <- left_join(raw_truth, anomalies) %>%
  mutate(model = NULL) %>%
  rename(true_value = value)