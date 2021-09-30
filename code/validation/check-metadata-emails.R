library(here); library(dplyr); library(tidyr)

# Get metadata emails
models <- covidHubUtils::get_all_models(source = "local_hub_repo", 
                                        hub_repo_path = here())

model_info <- purrr::map_dfr(paste0("data-processed/", models, 
                                    "/metadata-", models, ".txt"),
                             ~ yaml::read_yaml(.x))

ctb <- select(model_info, 
              model_abbr, model_contributors) %>%
  tidyr::separate(model_contributors, into = paste0("ctb_", 1:10), sep = ">", 
                  remove = FALSE) %>%
  mutate(has_email = grepl("@", model_contributors),
         across(ctb_1:ctb_10, ~ gsub(".*<", "", .)))

missing_email <- filter(ctb, !has_email) %>%
  select(model_abbr, model_contributors, has_email)

email_metadata <- filter(ctb, has_email) %>%
  pivot_longer(-c(model_contributors, model_abbr, has_email), 
               names_to = "ctb_order", values_to = "email_address") %>%
  mutate(has_email = grepl("@", email_address),
         email_address = tolower(email_address)) %>%
  filter(has_email) %>%
  distinct(email_address, .keep_all = TRUE) %>%
  bind_rows(missing_email)

rm(ctb, missing_email, models)

# Get google group emails
# Download from google as member list csv
email_google <- readr::read_csv("C:/Users/kaths/Downloads/euro-covid19-forecast-hub.csv",
                                skip = 1) %>%
  select(email_address = "Email address") %>%
  mutate(email_address = tolower(email_address))
  
# Check for matches
missing <- anti_join(email_metadata, email_google, by = "email_address") 

missing_with_emails <- missing %>%
  tidyr::drop_na(email_address) %>%
  pull(email_address)
missing_no_emails <- missing %>%
  filter(!has_email)



