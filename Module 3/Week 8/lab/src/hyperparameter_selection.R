######################################################
### Run cross-validation test leaving full years   ###
### of data out of the presence dataset.           ###
###                                                ###
### Compute cross-validation metric for several    ###
### models with different hyperparameters, by      ###
### leaving individual years out of the data set.  ###
### The best model is then tested on the           ###
### final 2 years of data.                         ###
######################################################

# load command line arguments 
args = commandArgs(trailingOnly=TRUE)
species <- args[1]

# libraries 
require(parallel)
require(randomForest)
require(dplyr)
require(purrr)
require(ggplot2)
require(reshape2)

# load useful functions from performance_metrics.R

source("src/performance_metrics.R")

########################
### define function ###
########################


# This function trains the random forest model on the dataset 
# training while setting the *choose a hyper-parameter* to h_param
# use help(randomForest) to see how the model's hyperparameters can be modified
train_presence_rf <- function(training, h_param){
  return(rf)
}


# Train the random forest model, leaving year i out of the training dataset
# set the hyperparameter value to h_param
test_model_i <- function(i,h_param,training){
  sub_training_data <- # leave year i out ot the training data set
  sub_testing_data <- # only include year i in the data set
  rf <- # use the train_presence_rf function to train a random forest model on the sub_training_set
  c_mat <- # Use the confusion function in the performance_metrics.R to calculate the random forest confusion matrix on the sub_testing_data
  return(c_mat)
} 


# set up method to calculate teh out of sample performance of the model
# given the value of the hyper parameters h_param
test_hyper_param <- function(h_param,training,cl){
  
  # run model tests set 1:k using parLapply
  output_list <- # use parLapply to run the test_model_i on each year in the training data set
  # type help(parLapply) to learn about the parLapply
  # hint: you will need to create a list of years, including the training data set, the unique() function can help
  # You will also need to create a function to pass to parLapply that runs test_model_i
  # on the training data set and h_param, but only requires the year i and an argument.
    
  
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

# Final data processing for random forest model 
# remove Haul.ID, Survey year, lat, lon, and X
# filter rows with NANs out of the dataset
data_presence <- 
  
# split data into training and final testing set
training <- 
testing <- 

param_levels <- # set hyperparameter levels using a vector c(...)

### Set up virtual parallel processing to run cross validation tests in parallel
nmax <- # detect number of cores on your machine use require(help = "parallel") to find the function for this
nuse <- nmax-2 # use all but 2 cores for the analysis
cl <- # make the virtual parallel computing cluster. again see require(help = "parallel") for helpful functions

# export the functions, data and variables used in the analysis to cluster using parallel::clusterExport
exp_data <- # list names of functions and variables needed in the analysis as strings.
clusterExport(cl, exp_data, envir=environment())

# Loop over the values of each hyperparameter in series 
# and save the performance metric to a data frame named df_metrics

# close the cluster when the task completes
stopCluster(cl) 

# Plot cross-validation metrics as a function of the hyperparameter value
# and save to the `results/parameter_selection` file.


# Save cross-validation metrics 
write.csv(df_metrics,paste0("results/parameter_selection/mtry_",species,"_presence.csv"))


##########################################################
## select best model based on cross validation results ###
## and test its performance on the testing data set    ###
##########################################################

# Select the best value of the hyperparameter
ind <- df_metrics$error_rate == max(df_metrics$error_rate)
best_mtry <- df_metrics$hyper_param[ind] 


# test the selected model on the training data set
rf <- # build rf model on the complete data set. You can use the train_presence_rf  
c_mat <-  # Calculate confusion matrix on testing data set using the confusion function from performance_metrics.R

# calculate final suite of performance metrics using function from performance_metrics.R
# and combine into a data frame 
final_metrics <- 

# save results to results/parameter_selection



