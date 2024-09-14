# Predictive Analytics Hello World in R

# Load necessary libraries
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Generate sample data
set.seed(0)
X <- runif(100, min=0, max=1)  # Feature
y <- 3 * X + 2 + rnorm(100, mean=0, sd=0.5)  # Target with noise

# Create a data frame
data <- data.frame(Feature = X, Target = y)

# Split the data into training and testing sets
set.seed(0)
train_indices <- sample(1:nrow(data), size = 0.8 * nrow(data))
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Create a linear regression model
model <- lm(Target ~ Feature, data = train_data)

# Make predictions
predictions <- predict(model, newdata = test_data)

# Evaluate the model
mse <- mean((test_data$Target - predictions)^2)

# Print results
cat("Coefficients:", coef(model), "\n")
cat("Mean Squared Error:", mse, "\n")

# Plot the results
ggplot() +
  geom_point(data = test_data, aes(x = Feature, y = Target), color = "black") +
  geom_line(data = test_data, aes(x = Feature, y = predictions), color = "blue", size = 1) +
  labs(title = "Linear Regression Example", x = "Feature", y = "Target") +
  theme_minimal()
