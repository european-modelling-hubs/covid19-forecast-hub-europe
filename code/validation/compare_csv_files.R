##
# Check if two csv files in data-processed format are identical
# helpful when rewriting processing scrips
#
# Jakob Ketterer, December 2020
##

# set working directory
setwd("~/forecast_hub/covid19-forecast-hub-de/code/validation")

# paths
truth_path <- "../../data-processed/LANL-GrowthRate/2020-12-06_processed_correct/2020-12-06-Poland-LANL-GrowthRate-case.csv"
test_path <- "../../data-processed/LANL-GrowthRate/2020-12-06-Poland-LANL-GrowthRate-case.csv"

# read files to dataframe
truth_df <- read.csv(truth_path)
test_df <- read.csv(test_path)

# sort dataframes by columns target, target_end_date and quantile
truth_sorted <- truth_df[order(truth_df$target, truth_df$target_end_date, truth_df$quantile),]
rownames(truth_sorted) <- NULL
test_sorted <- test_df[order(test_df$target, test_df$target_end_date, test_df$quantile),]
rownames(test_sorted) <- NULL

# compare dataframes: TRUE if equal
all.equal(truth_sorted, test_sorted)
