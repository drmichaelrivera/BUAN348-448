########################################################################
# Problem (Not necessary to include this in your code file for the final 
# project. However, this is a necessary phase and should be included in your 
# presentation deck. I include it here to reinforce its connectedness and 
# importance in the process.)
########################################################################

# Problem Statement:
# Zillow, a major player in real estate, has recently come under scrutiny due 
# to significant fluctuations in housing prices in various regions, particularly 
# in response to external factors like rising interest rates and inflation. These 
# fluctuations have raised concerns about the accuracy of Zillow’s price prediction models, 
# particularly their ability to provide reliable estimates for homes listed on the 
# platform. Zillow’s leadership team has tasked the analytics team with analyzing 
# historical housing data to understand the root causes of pricing inaccuracies and 
# propose improvements to the pricing prediction model.

# Key Questions:
# How accurate are Zillow's current price predictions compared to actual selling prices?
#  --Code/Analysis Connection: Use the model's RMSE and R-squared to evaluate prediction performance.
# Which factors (e.g., area, number of bedrooms, bathrooms, etc.) have the most significant impact on price prediction errors?
#  --Code/Analysis Connection: Analyze the coefficients of the multiple regression model to determine which variables contribute most to price prediction.
# Are there any patterns of over- or under-prediction in specific areas or home types?
#  --Code/Analysis Connection: Visualize the residuals (prediction errors) to detect any bias or patterns.
# Do any model assumptions (e.g., linearity, multicollinearity) need to be addressed to improve prediction accuracy?
#  --Code/Analysis Connection: Use residual plots, VIF, and Q-Q plots to check for assumptions and model diagnostics.
# How can Zillow’s pricing algorithm be improved to adapt to current market volatility?
#  -- Code/Analysis Connection: Based on the insights gained from the analysis, explore alternative models (e.g., regularization techniques) to improve the model's robustness.

# Root Cause Analysis:
# 1. Why are Zillow’s pricing predictions sometimes inaccurate?
#    Because the model does not account for all market conditions (e.g., sudden interest rate hikes, regional demand fluctuations).
### 2. Why doesn't the model account for these market conditions?
###    The current variables in the model (e.g., area, number of bedrooms, etc.) are not sufficient to capture dynamic market factors like economic shifts or buyer sentiment.
##### 3. Why weren’t more dynamic factors included in the model?
#####    Zillow’s initial model was built based on static historical data, without incorporating real-time data or external economic indicators.
####### 4. Why is the model dependent on static historical data?
#######    The original algorithm was designed with a focus on past trends rather than adaptive mechanisms that can adjust based on changing market conditions.
######### 5. Why hasn’t the model been updated to include adaptive features?
#########    The decision to update the model has been delayed due to the complexity of incorporating real-time data and the cost of implementing new algorithms.

########################################################################
# DATA
########################################################################
# Load necessary libraries
library(caret)    # For splitting the dataset and evaluating the model
library(car)      # For VIF and other regression diagnostics
library(dplyr)    # For data manipulation
library(GGally)   # For creating advanced scatter plot matrices and correlation plots
library(ggplot2)  # For visualizations
library(readr)    # For reading CSV files
library(tidyr)    # For reshaping and tidying data (e.g., pivoting data frames)

# Step 1: Load the dataset
dataset <- read_csv("Housing.csv")
head(dataset)
str(dataset)
summary(dataset)

# Step 2: Data Cleaning
# 2.1: Replace missing values (if any) with NA
dataset[dataset == ""] <- NA

# 2.2: Impute missing numeric variables with the median
numeric_cols <- sapply(dataset, is.numeric)
dataset[numeric_cols] <- lapply(dataset[numeric_cols], function(x) {
  ifelse(is.na(x), median(x, na.rm = TRUE), x)
})

# 2.3: Check for duplicate rows and remove them
dataset <- dataset %>% distinct()

print(dataset)

# Step 3: Data Visualization (Box plot, Scatter plot matrix, Heatmap)
# 3.1: Box plot for numeric variables
numeric_columns <- dataset %>% select(area, bedrooms, bathrooms, stories, parking, price)

numeric_columns_long <- numeric_columns %>% 
  pivot_longer(cols = -price, names_to = "variable", values_to = "value")
print(numeric_columns_long)

ggplot(numeric_columns_long, aes(x = variable, y = value)) +
  geom_boxplot() +
  ggtitle('Box Plot of Numeric Variables') +
  xlab('Variables') +
  ylab('Values') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(~variable, scales = "free_y")

# 3.2: Scatter plot matrix
ggpairs(dataset %>% select(area, bedrooms, bathrooms, stories, parking, price), 
        title = "Scatter Plot Matrix of Selected Variables")

# 3.3: Correlation heatmap
correlation_matrix <- cor(dataset %>% select_if(is.numeric))
melted_corr_matrix <- as.data.frame(as.table(correlation_matrix))
ggplot(data = melted_corr_matrix, aes(x = Var1, y = Var2, fill = Freq)) + 
  geom_tile() +
  geom_text(aes(label = round(Freq, 2)), color = "black", size = 4) +  # Add correlation values
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1, 1), space = "Lab", 
                       name = "Correlation") +
  theme_minimal() + 
  ggtitle("Correlation Heatmap of Numeric Variables") +
  xlab("Variables") +
  ylab("Variables") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))

# Step 4: Convert categorical variables to factors
dataset <- dataset %>%
  mutate(
    mainroad = factor(mainroad, levels = c("no", "yes")),
    guestroom = factor(guestroom, levels = c("no", "yes")),
    basement = factor(basement, levels = c("no", "yes")),
    hotwaterheating = factor(hotwaterheating, levels = c("no", "yes")),
    airconditioning = factor(airconditioning, levels = c("no", "yes")),
    prefarea = factor(prefarea, levels = c("no", "yes")),
    furnishingstatus = factor(furnishingstatus, levels = c("unfurnished", "semi-furnished", "furnished"))
  )

########################################################################
# MODEL
########################################################################

# Step 5: Split the dataset into training and testing sets
set.seed(123)  # For reproducibility
trainIndex <- createDataPartition(dataset$price, p = 0.8, list = FALSE)
train_data <- dataset[trainIndex, ]
test_data <- dataset[-trainIndex, ]

# Step 6: Fit the Multiple Linear Regression Model
model <- lm(price ~ area + bedrooms + bathrooms + stories + mainroad + guestroom + basement +
              hotwaterheating + airconditioning + parking + prefarea + furnishingstatus, data = train_data)

# Step 7: Model Summary
summary(model)

# Step 8: Make predictions on the test data
predictions <- predict(model, newdata = test_data)

# Step 9: Evaluate Model Performance
# 9.1: Mean Squared Error (MSE) and Root Mean Squared Error (RMSE)
actual_values <- test_data$price
mse <- mean((actual_values- predictions )^2)
rmse <- sqrt(mse)
cat("Mean Squared Error (MSE): ", mse, "\n")
cat("Root Mean Squared Error (RMSE): ", rmse, "\n")

# 9.2: R-squared and Adjusted R-squared
r_squared <- summary(model)$r.squared
adjusted_r_squared <- summary(model)$adj.r.squared
cat("R-squared: ", r_squared, "\n")
cat("Adjusted R-squared: ", adjusted_r_squared, "\n")

########################################################################
# IMPACT (Not necessary to include this in your code file for the final 
# project. However, this is a necessary phase and should be included in your 
# presentation deck. I include it here to reinforce its connectedness and 
# importance in the process.)
########################################################################

# Go back to the mini case and focus on answering the questions.
# Share your findings and suggest a managerial recommendation.
# Two sentences should suffice for each. We find...  Therefore, we suggest...
# Try to tie some aspect of the managerial recommendation to your 5 Whys drivers.
# When finished, we will debrief this mini case as a group. 

