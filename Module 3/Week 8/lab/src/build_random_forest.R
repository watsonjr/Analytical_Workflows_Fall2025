#################################################################
### Explore the structure of the NOAA BSAI trawl survey data. ###
### Make plots to visualize basic patters.                    ###
### Example data pipeline for snow crab                       ###
#################################################################

# load command line arguments 
# Replace the calls to args with specific values if running this file from the console
args = commandArgs(trailingOnly=TRUE)
species <- args[1]
ntree <- as.numeric(args[2])
mtry <- as.numeric(args[3])


# Load libraries
library(dplyr)
library(reshape2)
library(ggplot2)
library(randomForest)

# Load presence data for species

# Final data processing for rf model 
# remove Haul.ID, Survey year, lat, lon and X
# filter rows with NANs out of the data set
data_presence <- 

# Train model on presence data 
# train a random forest for the presence data using all colums as covariates
# Build ntree trees and try mtry variables at each split. 
rf <- randomForest(...)

# Save rf data model and related data to the resutls/rf_models file
write.csv(rf$confusion,paste0("results/rf_models/rf_confusion_",species,"_presence.csv") )
saveRDS(rf, file = paste0("results/rf_models/rf_model_",species,"_presence.rdata"))
saveRDS(data_presence, file = paste0("results/rf_models/rf_data_",species,"_presence.rdata"))

##########################################
####### Repeat for densities data ########
##########################################

# save rf data 
model_performacne <- data.frame(mse = rf$mse[ntree], rsq = rf$rsq[ntree])
write.csv(model_performacne,paste0("results/rf_models/rf_performance_",species,"_density.csv") )
saveRDS(rf, file = paste0("results/rf_models/rf_model_",species,"_density.rdata"))
saveRDS(data_density, file = paste0("results/rf_models/rf_data_",species,"_density.rdata"))


