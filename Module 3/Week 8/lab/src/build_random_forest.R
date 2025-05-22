#################################################################
### Build a random forest model for the presence and abundance ##
### of a species in the NOAA Bering Sea trawl data set.       ###
#################################################################

# load command line arguments 
# Replace the calls to args with specific values if running this file from the console
args = commandArgs(trailingOnly=TRUE)
species <- args[1]
ntree <- as.numeric(args[2])
mtry <- as.numeric(args[3])


# Load libraries
require(dplyr)
require(reshape2)
require(ggplot2)
require(randomForest)

# Load presence data for species

# Final data processing for random forest model 
# remove Haul.ID, Survey year, lat, lon, and X
# filter rows with NANs out of the dataset
data_presence <- 

# Train model on presence data 
# Train a random forest for the presence data using all columns as covariates
# Build ntree trees and try mtry variables at each split. 
  
rf <- randomForest(...)

# Save rf model and related data to the resutls/rf_models file
write.csv(rf$confusion,paste0("results/rf_models/rf_confusion_",species,"_presence.csv") )
saveRDS(rf, file = paste0("results/rf_models/rf_model_",species,"_presence.rdata"))
saveRDS(data_presence, file = paste0("results/rf_models/rf_data_",species,"_presence.rdata"))

##########################################
####### Repeat for densities data ########
##########################################

# Save random foret model for densities data 
model_performacne <- data.frame(mse = rf$mse[ntree], rsq = rf$rsq[ntree])
write.csv(model_performacne,paste0("results/rf_models/rf_performance_",species,"_density.csv") )
saveRDS(rf, file = paste0("results/rf_models/rf_model_",species,"_density.rdata"))
saveRDS(data_density, file = paste0("results/rf_models/rf_data_",species,"_density.rdata"))


