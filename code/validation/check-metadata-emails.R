library(here); library(dplyr)

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

missing_email <- filter(ctb, has_email == FALSE) %>%
  select(model_abbr, model_contributors, has_email)

emails <- filter(ctb, has_email == TRUE) %>%
  pivot_longer(-c(model_contributors, model_abbr, has_email), 
               names_to = "ctb_order", values_to = "email_address") %>%
  mutate(has_email = grepl("@", email_address)) %>%
  filter(has_email == TRUE) %>%
  distinct(email_address, .keep_all = TRUE) %>%
  bind_rows(missing_email)

         