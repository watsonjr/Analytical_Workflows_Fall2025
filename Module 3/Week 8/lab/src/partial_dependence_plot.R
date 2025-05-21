#####################################
### Make partial dependence plots ###
#####################################

# load in command line arguments
args = commandArgs(trailingOnly=TRUE)
species <- args[1]
variable <- args[2]

# load pdp package for partial dependence plots, and ggplot + ggplotify for saving
require(pdp)
require(randomForest)
require(ggplot2)
require(ggplotify) 
require(dplyr)

# Read in saved random forest model using paste0 to include the species name

# Read in training data this is required for the pdp::partial function

# Make partial dependence plot for the variable specified by the command line arguments
# using pdp::partial
# type help(partial) into the console for documentation
# Note some additional key word arguments will need to be passed to 
# the partial function for categorical models


# Convert to ggplot and add white background
p <- as.ggplot(plt) + theme(panel.background = element_rect("white")) 

# save!
ggsave(paste0("results/figures/pdp_", species,"_", variable,"_presence.png"), 
       plot = p, height = 4, width = 5)


####################################
#### repeat for densities model ####
####################################

