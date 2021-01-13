#################################################################################
###### This file has been adapted from code provided in the US COVID19 forecast hub:
###### https://github.com/reichlab/covid19-forecast-hub/blob/master/code/validation/functions_plausibility.R
###### Author of original code: Johannes Bracher
###### The original file has been provided under the MIT license, and so is this adapted version.
#################################################################################
#run from source file
source("functions_plausibility.R")

# make sure locale is English US
#see if you're on Windows or other OS
if(Sys.info()[1]=="Windows") {
  Sys.setlocale("LC_TIME", "English")
} else {
  Sys.setlocale(category = "LC_TIME", locale = "en_US.UTF8")
}


directories <- list.dirs("../../data-processed")[-1]

plausibility_checks <- list()

for(dir in directories){
  plausibility_checks[[dir]] <- validate_directory(dir)
}
