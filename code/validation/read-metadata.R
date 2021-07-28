# read metadata

library(here)
library(yaml)
library(purrr)
library(dplyr)

get_metadata <- function(keys,
                          exclude_designated_other = TRUE, 
                          exclude_hub = FALSE) {
  
  metadata_path <- dir(here("data-processed"), recursive = TRUE, full.names = TRUE)
  metadata_path <- metadata_path[grepl(".txt", metadata_path)]
  
  all_metadata <- map_dfr(metadata_path, read_yaml)

  if (exclude_designated_other) {
    all_metadata <- all_metadata %>%
      filter(team_model_designation != "other")
  }
  
  if (exclude_hub) {
    all_metadata <- all_metadata %>%
      filter(!grepl("EuroCOVIDhub", .$model_abbr))
  }
  
  if (missing(keys)) {
    keys <- names(all_metadata)
  }
  
  all_metadata <- all_metadata %>%
    select(model_abbr, all_of(keys))
  
  return(all_metadata)

}


# url checks --------------------------------------------------------------

##' Check a url returns http status 200
##'
##' @return a data frame of models and urls with url_status TRUE if is 200
##' @param metadata metadata in dataframe
##' @param url_fields column/s of urls to check, can include NA

library(dplyr)
library(purrr)
library(httr)
library(tidyr)

check_url <- function(metadata, url_fields) {

  url_check <- metadata %>%
    select(model_abbr, !!!url_fields) %>%
    pivot_longer(cols = -model_abbr,
                 names_to = "url_fields",
                 values_to = "url") %>%
    drop_na() %>%
    rowwise() %>%
    mutate(url_status = status_code(GET(url)),
           url_status = ifelse(url_status == 200,
                               TRUE, FALSE)) %>%
    pivot_wider(id_cols = "model_abbr",
                names_from = "url_fields",
                values_from = c("url_status"))

  return(url_check)
}

# Website checks -------------------------------------------------------------

metadata_urls <- metadata %>%
  select(model_abbr, ends_with("url"), twitter_handles) %>%
  mutate(n_handles = str_count(twitter_handles, "(, )| ") + 1) %>%
  separate(twitter_handles,
           sep = "(, )| ",
           into = paste0("twitter_",
                         seq(1:max(.$n_handles, na.rm = TRUE)),
                         "_url"),
           remove = TRUE) %>%
  mutate(across(starts_with("twitter_"),
                ~ ifelse(!is.na(.x),
                         paste0("www.twitter.com/", .x),
                         NA))) %>%
  select(-n_handles)

metadata_url_check <- check_url(metadata = metadata_urls,
                                url_fields = names(select(metadata_urls,
                                                          ends_with("_url"))))

url_broken <- metadata_url_check %>%
  mutate(any_broken = any(select(., ends_with("url"))))
