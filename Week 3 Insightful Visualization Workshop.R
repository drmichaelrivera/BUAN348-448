# Load libraries
library(ggplot2)
library(GGally)
library(readr)
library(corrplot)
library(dplyr)
library(tidyr)

# Import the data
file_path <- 'Week 3 retail_dataset_extended.csv'
df <- read_csv(file_path)

# Output the data
print(head(df))

# Generate some basic statistical measures
print(summary(df))

# Placeholder for the box plot
# Box Plot: Create box plots for the continuous variables in the dataset.
# continuous_vars <- select(df, where(is.numeric))
# continuous_vars_long <- continuous_vars %>% pivot_longer(everything(), names_to = "variable", values_to = "value")
# ggplot(continuous_vars_long, aes(x = variable, y = value)) + 
#   geom_boxplot() + 
#   labs(title="Box Plots of Continuous Variables") + 
#   theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Placeholder for the scatter plot matrix
# Scatter Plot Matrix: Generate a scatter plot matrix to explore relationships between variables.
# ggpairs(select(df, where(is.numeric)))

# Placeholder for the correlation heat map
# Correlation Heat Map: Develop a correlation heat map to identify correlations between variables.
# numeric_df <- select(df, where(is.numeric))
# corr_matrix <- cor(numeric_df, use = "complete.obs")
# corrplot(corr_matrix, method = "color", addCoef.col = "black", tl.col = "black", tl.srt = 45)

# Placeholder for visualization of choice 1
# Visualization of Choice 1: Describe the visualization here.
# Example: ggplot(df, aes(x = Sales)) + geom_histogram(binwidth=50) + labs(title="Histogram of Sales")

# Placeholder for visualization of choice 2
# Visualization of Choice 2: Describe the visualization here.
# Example: ggplot(df, aes(x = Sales, y = Profit)) + geom_point() + labs(title="Scatter Plot of Sales vs Profit")
