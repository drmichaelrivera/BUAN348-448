# Run code and answer the following questions:

# Which model has the lowest Mean Squared Error (MSE), and what does this indicate about the model's performance?
# Interpretation: The MSE is a measure of the average squared difference between the predicted and actual values. The model with the lowest MSE is typically considered the best at predicting the output variable because it has the smallest prediction error. However, it's essential to consider both MSE and R-squared when evaluating models.

# How do the R-squared values compare across the models, and what can you infer from these values about the models' explanatory power?
# Interpretation: The R-squared value indicates the proportion of the variance in the dependent variable that is predictable from the independent variables. A higher R-squared value generally suggests that the model explains a greater proportion of the variance, implying better performance. However, caution is needed as high R-squared can sometimes result from overfitting, especially in complex models like ElasticNet.

# Based on the coefficients and intercepts provided, how do the different models handle the features, and what might this indicate about the importance of each feature in predicting sales?
# Interpretation: The coefficients in a regression model indicate the expected change in the dependent variable (Sales) for a one-unit change in the independent variable, holding all other variables constant. Comparing coefficients across models, especially between Ridge, Lasso, and ElasticNet, can reveal which features are consistently influential. Lasso and ElasticNet can shrink some coefficients to zero, effectively selecting a subset of features, which might indicate the most important features for prediction. Ridge, on the other hand, will shrink coefficients but not eliminate them, showing all features' influence.


# Load necessary libraries
library(dplyr)
library(glmnet)
library(caret)

# Create the dataset
data <- data.frame(
  Region = c('North', 'South', 'East', 'West', 'North', 'South', 'East', 'West', 'North', 'South', 'East', 'West', 'North', 'South', 'East', 'West'),
  Dealership_Size = c(2500, 3000, 1800, 2200, 2700, 3200, 1900, 2300, 2600, 3100, 2000, 2400, 2800, 3300, 2100, 2500),
  Marketing_Spend = c(50000, 60000, 45000, 48000, 52000, 62000, 47000, 49000, 51000, 61000, 46000, 50000, 53000, 63000, 48000, 52000),
  Customer_Interactions = c(300, 400, 280, 310, 330, 420, 290, 320, 350, 430, 300, 340, 370, 440, 310, 360),
  Sales = c(120, 150, 100, 110, 130, 160, 105, 115, 125, 155, 110, 120, 140, 170, 115, 130)
)

# Data Cleaning Tasks

# Check for missing values and handle them
print("Missing values in each column:")
print(colSums(is.na(data)))

# Remove duplicate rows if any
data <- data %>%
  distinct()

# Ensure consistent data formats
data$Marketing_Spend <- as.numeric(data$Marketing_Spend)

# Convert categorical variable to dummy variables
region_dummies <- model.matrix(~ Region - 1, data)
data <- cbind(data, region_dummies)

# Drop the original 'Region' column
data <- data %>%
  select(-Region)

# Define the dependent variable (DV) and independent variables (IVs)
X <- data %>%
  select(Dealership_Size, Marketing_Spend, Customer_Interactions, RegionNorth, RegionWest, RegionSouth)
y <- data$Sales

# Split the data into training and testing sets
set.seed(42)
trainIndex <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[trainIndex, ]
X_test <- X[-trainIndex, ]
y_train <- y[trainIndex]
y_test <- y[-trainIndex]

# Standardize the data
scaler <- preProcess(X_train, method = c("center", "scale"))
X_train_scaled <- predict(scaler, X_train)
X_test_scaled <- predict(scaler, X_test)

# Convert to matrices for glmnet
X_train_matrix <- as.matrix(X_train_scaled)
X_test_matrix <- as.matrix(X_test_scaled)
y_train_vector <- as.vector(y_train)

# Create and fit models
results <- list()

# Linear Regression
model_lm <- lm(y_train ~ ., data = as.data.frame(cbind(X_train_scaled, y_train)))
y_pred_lm <- predict(model_lm, newdata = as.data.frame(X_test_scaled))
mse_lm <- mean((y_test - y_pred_lm)^2)
r2_lm <- summary(model_lm)$r.squared
results[["Linear Regression"]] <- list(Coefficients = coef(model_lm), Intercept = coef(model_lm)[1], `Mean squared error` = mse_lm, `R-squared value` = r2_lm)

# Ridge Regression
model_ridge <- cv.glmnet(X_train_matrix, y_train_vector, alpha = 0)
y_pred_ridge <- predict(model_ridge, s = model_ridge$lambda.min, newx = X_test_matrix)
mse_ridge <- mean((y_test - y_pred_ridge)^2)
r2_ridge <- 1 - (sum((y_test - y_pred_ridge)^2) / sum((y_test - mean(y_test))^2))
results[["Ridge Regression"]] <- list(Coefficients = coef(model_ridge, s = model_ridge$lambda.min), `Mean squared error` = mse_ridge, `R-squared value` = r2_ridge)

# Lasso Regression
model_lasso <- cv.glmnet(X_train_matrix, y_train_vector, alpha = 1)
y_pred_lasso <- predict(model_lasso, s = model_lasso$lambda.min, newx = X_test_matrix)
cat("Lasso Predictions:", y_pred_lasso, "\n")
mse_lasso <- mean((y_test - y_pred_lasso)^2)
r2_lasso <- 1 - (sum((y_test - y_pred_lasso)^2) / sum((y_test - mean(y_test))^2))
results[["Lasso Regression"]] <- list(Coefficients = coef(model_lasso, s = model_lasso$lambda.min), `Mean squared error` = mse_lasso, `R-squared value` = r2_lasso)

# ElasticNet Regression
model_enet <- cv.glmnet(X_train_matrix, y_train_vector, alpha = 0.5)
y_pred_enet <- predict(model_enet, s = model_enet$lambda.min, newx = X_test_matrix)
cat("ElasticNet Predictions:", y_pred_enet, "\n")
mse_enet <- mean((y_test - y_pred_enet)^2)
r2_enet <- 1 - (sum((y_test - y_pred_enet)^2) / sum((y_test - mean(y_test))^2))
results[["ElasticNet Regression"]] <- list(Coefficients = coef(model_enet, s = model_enet$lambda.min), `Mean squared error` = mse_enet, `R-squared value` = r2_enet)

# Output the results for each model
for (name in names(results)) {
  cat("\n", name, ":\n", sep = "")
  print(results[[name]])
}
