######################################################
### Run cross validation test leaving full years   ###
### of data out fo the presence absence data set.  ###
###                                                ###
### Compute cross validation metric for suite of   ###
### models with different hyper-parameters, by     ###
### leaving individual years out of the data set.  ###
### The best model is then then test on the        ###
### final 2 years of data.                         ###
######################################################

# load command line arguments 
args = commandArgs(trailingOnly=TRUE)
species <- args[1]

# libraries 
library(parallel)
library(randomForest)
library(dplyr)
library(purrr)
library(ggplot2)
library(reshape2)

# load useful functions from performance_metrics.R

source("src/performance_metrics.R")

########################
### define function ###
########################


# This function trains the random forest model on the data set 
# training while setting the *choose a hyper-parameter* to h_param
# use help(randomForest) to see how the models hyper parameters can be modified
train_presence_rf <- function(training, h_param){
  return(rf)
}


# Train the random forest model leaving year i out of the training data set
# set the hyperparameter value to h_param
test_model_i <- function(i,h_param,training){
  sub_training_data <- # leave year i out ot the training data set
  sub_testing_data <- # only include year i in the data set
  rf <- # use the train_presence_rf function to train a random forest model on the sub_training_set
  c_mat <- # Use the confusion function in the performance_metrics.R to calculate the random forest confusion matrix on the sub_testing_data
  return(c_mat)
} 


# set up method to calculate 
test_hyper_param <- function(h_param,training,cl){
  
  # run model tests set 1:k using parLapply
  output_list <- # use parLapply to run the test_model_i on each year in the training data set
  # type help(parLapply) to learn about the parLapply
  # hint: you will need to create a list of years including the the training data set the unique() function can help
  # you will also need to create a function to pass to parLapply that runs test_model_i
  # on the training data set and h_param but only requires the year i and an argument.
  
  c_mat <- reduce(output_list,element_sum)
  
  # calculate model performance metrics using 
  # functions from performance_metrics.R
  metrics <- data.frame(hyper_param = mtry,
                        sensetivity = sensetivity(c_mat), 
                        specificity = specificity(c_mat),
                        error_rate = error_rate(c_mat))
  return(metrics)
}


######################
### run analysis  ###
#####################

# load data set 

# Final data processing for rf model 
# remove Haul.ID, Survey year, lat, lon and X
# filter rows with NANs out of the data set
data_presence <- 
  
# split data into training and final testing set
training <- 
testing <- 

param_levels <- # set hyper parameter levels using a vector c(...)

### Set up virtual parallel processing to run cross validation tests in parallel
nmax <- # detect number of cores on your machine use library(help = "parallel") to find the function for this
nuse <- nmax-2 # use all but 2 cores for the analysis
cl <- # make the virtual parallel computing cluster. again see library(help = "parallel") for helpful functions

# export the functions, data and variables used in the analysis to cluster using parallel::clusterExport
exp_data <- # list names of functions and varibles as strings.
clusterExport(cl, exp_data, envir=environment())

# Loop over the values of each hyperparameter in series 
# and save the performance metric to a data frame named df_metrics

# close cluster when task completes
stopCluster(cl) 

# plot cross validation metrics as a function of the hyper parameter value
# and save to the `results/parameter_selection` file


# save cross validation metrics 
write.csv(df_metrics,paste0("results/parameter_selection/mtry_",species,"_presence.csv"))


##########################################################
## select best model based on cross validation results ###
## and test in its performacne on the testing data set ###
##########################################################

# select the best value fo the hyper parameter
ind <- df_metrics$error_rate == max(df_metrics$error_rate)
best_mtry <- df_metrics$hyper_param[ind] 


# test the selected model on the training data set
rf <- # build rf model on the compete data set. You can use the train_presence_rf function you already defined for this 
c_mat <-  # Calculate confusion matrix on testing data set using the confusion function from performance_metrics.R

# calculate final suite of performance metrics using function from performance_metrics.R
# and combine into a data frame 
final_metrics <- 

# save results to results/parameter_selection



