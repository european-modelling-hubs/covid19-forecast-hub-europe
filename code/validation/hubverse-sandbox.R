# Test out hubUtils package

remotes::install_github("Infectious-Disease-Modeling-Hubs/hubUtils",
                        dependencies = TRUE)
library(hubUtils)
library(dplyr)

# Connect to a local Hub
hub_path <- here::here()
hub_con <- connect_hub(hub_path)
mod_out_path <- paste0(hub_path, "/data-processed")
mod_out_con <- connect_model_output(mod_out_path)
data <- collect(mod_out_con)

validate_config(hub_path = here::here(),
                config = "tasks")

