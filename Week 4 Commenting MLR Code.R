# Review each command below and add a detailed comment. When structured in a small block, you can comment the block, but be sure to not forgo detail.

library(dplyr)
library(caret)

data <- data.frame(
  Region = c('North', 'South', 'East', 'West', 'North', 'South', 'East', 'West', 'North', 'South', 'East', 'West', 'North', 'South', 'East', 'West'),
  Dealership_Size = c(2500, 3000, 1800, 2200, 2700, 3200, 1900, 2300, 2600, 3100, 2000, 2400, 2800, 3300, 2100, 2500),
  Marketing_Spend = c(50000, 60000, 45000, 48000, 52000, 62000, 47000, 49000, 51000, 61000, 46000, 50000, 53000, 63000, 48000, 52000),
  Customer_Interactions = c(300, 400, 280, 310, 330, 420, 290, 320, 350, 430, 300, 340, 370, 440, 310, 360),
  Sales = c(120, 150, 100, 110, 130, 160, 105, 115, 125, 155, 110, 120, 140, 170, 115, 130)
)

print(data)

print("Missing values in each column:")
print(colSums(is.na(data)))

data <- data %>%
  mutate(Customer_Interactions = ifelse(is.na(Customer_Interactions), mean(Customer_Interactions, na.rm = TRUE), Customer_Interactions))

data <- data %>%
  distinct()

data$Marketing_Spend <- as.numeric(data$Marketing_Spend)

threshold <- quantile(data$Sales, 0.95)
data <- filter(data, Sales < threshold)

data <- data %>%
  mutate(across(Region, as.factor)) %>%
  mutate(Region = relevel(Region, ref = "East")) %>%
  model.matrix(~ Region - 1, data = .) %>%
  cbind(data, .) %>%
  select(-Region)

X <- data %>%
  select(Dealership_Size, Marketing_Spend, Customer_Interactions, RegionNorth, RegionWest, RegionSouth)

y <- data$Sales

set.seed(42)
trainIndex <- createDataPartition(y, p = 0.8, list = FALSE)
X_train <- X[trainIndex,]
X_test <- X[-trainIndex,]
y_train <- y[trainIndex]
y_test <- y[-trainIndex]

model <- lm(y_train ~ ., data = as.data.frame(cbind(X_train, y_train)))

y_pred <- predict(model, newdata = as.data.frame(X_test))

mse <- mean((y_test - y_pred)^2)
r2 <- summary(model)$r.squared

print(summary(model)$coefficients)
print(paste("Mean squared error:", mse))
print(paste("R-squared value:", r2))
