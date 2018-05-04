## STAT 651 FINAL PROJECT - DEPENDENT RANDOM WEIGHTING
## Code for creating plots of simulation results

# Load libraries 
library(tidyverse)
library(ggplot2)
library(wesanderson)

## -----------------------------------------------------------------
## Data Steps for Simulation Data
## -----------------------------------------------------------------

# Read in data frames with results from simulations
resARmbb <- read.csv("./data/resARmbb.csv")
resMAmbb <- read.csv("./data/resMAmbb.csv")
resARdrw <- read.csv("./data/resAR_DRW.csv")
resMAdrw <- read.csv("./data/resMA_DRW.csv")

# Add columns for resampling method and data type in resARmbb
resARmbb <- resARmbb %>%
  mutate(method = rep("MBB", length(blocksize)),
         datatype = rep("AR", length(blocksize))) %>%
  select(method, datatype, 1:7)

# Add columns for resampling method and data type in resMAmbb
resMAmbb <- resMAmbb %>%
  mutate(method = rep("MBB", length(blocksize)),
         datatype = rep("MA", length(blocksize))) %>%
  select(method, datatype, 1:7)

# Add columns for resampling method and data type in resARmbb
resARdrw <- resARdrw %>%
  mutate(method = rep("DRW", length(blocksize)),
         datatype = rep("AR", length(blocksize))) %>%
  select(method, datatype, 1:7)

# Add columns for resampling method and data type in resMAmbb
resMAdrw <- resMAdrw %>%
  mutate(method = rep("DRW", length(blocksize)),
         datatype = rep("MA", length(blocksize))) %>%
  select(method, datatype, 1:7)

# Join the AR and MA mbb results
joinedres <- rbind(resARmbb, resMAmbb, resARdrw, resMAdrw) %>%
  rename(blocksize_binwidth = blocksize)

# Create a separate data frame with mean results
meanres <- joinedres %>%
  select(-coverage_median, - MSE_median, -norm_MSE_median, -MSE_mean) %>%
  rename(coverage = coverage_mean, norm_MSE = norm_MSE_mean) %>%
  gather("statistic", "mean_value", 4:5)

# Create a separate data frame with median results
medianres <- joinedres %>%
  select(-coverage_mean, - MSE_mean, -norm_MSE_mean, - MSE_median) %>%
  rename(coverage = coverage_median, norm_MSE = norm_MSE_median) %>%
  gather("statistic", "median_value", 4:5)

# Join the mean and median results in a dataframe for plotting
full_res <- full_join(meanres, medianres, 
                      by = c("method", "datatype", "blocksize_binwidth", "statistic"))

# Turn the variable "statistic" into a factor
full_res$statistic <- factor(full_res$statistic)

# Change label names for the variable "statistic"
levels(full_res$statistic) <- c("Coverage Rate", "Normalized MSE")

## -----------------------------------------------------------------
## Plots of Simulation Results
## -----------------------------------------------------------------

# Plots of the mean results
#pdf("./presentation/images/resmean.pdf", height = 4, width = 6)
ggplot(full_res, aes(x = factor(blocksize_binwidth), y = mean_value)) + 
  geom_point(aes(color = method, shape = method)) + 
  facet_grid(statistic ~ datatype, scale = "free_y") +
  geom_hline(data = data.frame(yint = 0.95, statistic = "Coverage Rate"),
             aes(yintercept = yint), linetype = "dotted") +
  theme_bw() + 
  labs(x = "Binwidth/Blocksize", y = "", color = "Method", shape = "Method") +
  scale_color_manual(values = wes_palette("Zissou"))
#dev.off()

# Plots of the median results
#pdf("./presentation/images/resmedian.pdf", height = 4, width = 6)
ggplot(full_res, aes(x = factor(blocksize_binwidth), y = median_value)) + 
  geom_point(aes(color = method, shape = method)) + 
  facet_grid(statistic ~ datatype, scale = "free_y") + 
  geom_hline(data = data.frame(yint = 0.95, statistic = "Coverage Rate"),
             aes(yintercept = yint), linetype = "dotted") +
  theme_bw() + 
  labs(x = "Binwidth/Blocksize", y = "", color = "Method", shape = "Method") +
  scale_color_manual(values = wes_palette("Zissou"))
#dev.off()
