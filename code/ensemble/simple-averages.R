library(here)
library(vroom)
library(purrr)
library(dplyr)
library(stringr)

target_date <- "2021-03-08"

files <- dir(here("data-processed"), pattern = target_date, 
             include.dirs = TRUE, recursive = TRUE,
             full.names = TRUE) 

models <- files %>%
  map(~ vroom(.x))

teams <- files %>%
  str_remove_all(here("data-processed")) %>%
  str_split("/") %>%
  map_chr( ~ .x[2])

names(models) <- teams

models <- bind_rows(models, .id = "team")

ensemble <- models %>%
  group_by(target, target_end_date, location, quantile) %>%
  summarise(forecasts = n(),
            mean = mean(value),
            median = median(value))


