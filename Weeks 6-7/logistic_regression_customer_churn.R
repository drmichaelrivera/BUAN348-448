########################################################################
########################################################################
# Problem
########################################################################
########################################################################
# In our mini case brief, we highlight the problem, root cause analysis, 
# and key research questions. 

########################################################################
########################################################################
# DATA
########################################################################
########################################################################
# This script is for data preprocessing and initial analysis in a customer churn prediction project.
# It loads necessary libraries, prepares the dataset, and performs basic data cleaning steps.

# Libraries:
# - caret: For partitioning the dataset and training models.
# - dplyr: For data manipulation like selecting columns and handling missing values.
# - ggplot2: For data visualization to explore patterns in the dataset.
# - pROC: For evaluating model performance using AUC and ROC analysis.

# Step 1: Load the dataset
# - Reads the customer churn dataset from a CSV file.
# - The dataset should include customer information relevant for churn prediction.

# Step 2: Data Cleaning and Preprocessing
# - Converts the 'Churn' column to a factor (binary outcome: Yes/No) for classification.
# - Removes unnecessary columns (e.g., 'customerID') to focus on relevant features.
# - Imputes missing values in numeric columns using the median value.
#   This is crucial to ensure the dataset is complete for modeling.
# - Converts categorical variables to factors for better handling in predictive models.

# Importance:
# - This preprocessing is vital to prepare the data for machine learning models.
# - Clean and well-structured data improves model accuracy and performance.
# - Proper handling of missing values and categorical variables ensures
#   that the model training process is robust and reliable.

# Load necessary libraries
library(caret)   # For data partitioning and model training
library(dplyr)   # For data manipulation
library(ggplot2) # For data visualization
library(pROC)    # For AUC and ROC analysis

# Step 1: Load the dataset
# Replace 'Telco-Customer-Churn.csv' with the path to your dataset
dataset <- read.csv('Telco-Customer-Churn.csv')

print(dataset)

# Step 2: Data Cleaning and Preprocessing
# Convert 'Churn' column to a factor (binary outcome: Yes/No)
dataset$Churn <- factor(dataset$Churn, levels = c("No", "Yes"))

# Remove unnecessary columns (e.g., customerID)
dataset <- dataset %>% select(-customerID)

# Impute missing values if necessary
dataset <- dataset %>% mutate_if(is.numeric, ~ifelse(is.na(.), median(., na.rm = TRUE), .))

# Convert categorical variables to factors
dataset <- dataset %>% mutate_if(is.character, as.factor)

########################################################################
########################################################################
# MODEL
########################################################################
########################################################################
# This section of the script performs data splitting, model training, prediction, and evaluation
# for a logistic regression model aimed at predicting customer churn.

# Step 3: Split the Dataset into Training and Testing Sets
# - The dataset is split into training (80%) and testing (20%) sets using the 'caret' package.
# - A random seed is set for reproducibility, ensuring consistent results across runs.
# - The training set is used to train the model, while the testing set is used to evaluate it.

# Step 4: Fit the Logistic Regression Model
# - A logistic regression model is trained using the training data.
# - The model predicts the probability of customer churn based on the features in the dataset.
# - This step is crucial to identify the relationship between predictors and the outcome (Churn).

# Step 5: Model Summary
# - The summary of the fitted model is displayed to understand the significance of each predictor.
# - This helps in interpreting the model coefficients and identifying key factors influencing churn.

# Step 6: Make Predictions on the Test Data
# - The model is used to make predictions on the test data.
# - Probabilities of churn are converted to binary predictions ('Yes' or 'No') using a threshold of 0.5.
# - Predictions are then converted to factors for evaluation purposes.

# Step 7: Evaluate Model Performance
# - Accuracy, Precision, Recall, and F1 Score: Provide a comprehensive evaluation of 
#.   the model's performance, with accuracy measuring the proportion of correct predictions, 
#.   precision indicating the reliability of positive predictions, recall assessing the model's 
#.   ability to identify actual churners, and F1 score balancing precision and recall.
# - Confusion Matrix: Evaluates the model's accuracy, sensitivity, and specificity.
#   It compares the predicted labels with the actual labels in the test set.
# - ROC and AUC: ROC (Receiver Operating Characteristic) curve and AUC (Area Under the Curve)
#   are used to assess the model's ability to distinguish between churners and non-churners.
# - The ROC curve is plotted to visually inspect the model's performance.

# Importance:
# - Splitting the data into training and testing sets helps in evaluating the model's generalization.
# - Logistic regression is a commonly used method for binary classification tasks like churn prediction.
# - Model evaluation through confusion matrix, ROC, and AUC provides insights into model performance.
# - This process is key for building a reliable predictive model to support business decisions.

# Step 3: Split the dataset into training and testing sets
set.seed(123)  # For reproducibility
trainIndex <- createDataPartition(dataset$Churn, p = 0.8, list = FALSE)
train_data <- dataset[trainIndex, ]
test_data <- dataset[-trainIndex, ]

# Step 4: Fit the Logistic Regression Model
model <- glm(Churn ~ ., data = train_data, family = binomial)

# Step 5: Model Summary
summary(model)

# Step 6: Make predictions on the test data
probabilities <- predict(model, newdata = test_data, type = "response")
predictions <- ifelse(probabilities > 0.5, "Yes", "No")

# Convert to factors for evaluation
predictions <- factor(predictions, levels = c("No", "Yes"))

# Step 7: Evaluate Model Performance
# Calculate Accuracy, Precision, Recall, and F1 Score
accuracy <- sum(predictions == test_data$Churn) / length(test_data$Churn)

# Precision: True Positives / (True Positives + False Positives)
precision <- posPredValue(predictions, test_data$Churn, positive = "Yes")

# Recall (Sensitivity): True Positives / (True Positives + False Negatives)
recall <- sensitivity(predictions, test_data$Churn, positive = "Yes")

# F1 Score: Harmonic Mean of Precision and Recall
f1_score <- (2 * precision * recall) / (precision + recall)

# Print all the metrics
cat("Model Performance Metrics:\n")
cat(sprintf("Accuracy: %.2f\n", accuracy))
cat(sprintf("Precision: %.2f\n", precision))
cat(sprintf("Recall: %.2f\n", recall))
cat(sprintf("F1 Score: %.2f\n", f1_score))

# Confusion Matrix
confusionMatrix(predictions, test_data$Churn)

# Confusion Matrix
conf_matrix <- confusionMatrix(predictions, test_data$Churn)

# Extract confusion matrix values
cm_values <- as.data.frame(conf_matrix$table)
colnames(cm_values) <- c("Prediction", "Reference", "Frequency")

# Plot confusion matrix
ggplot(data = cm_values, aes(x = Reference, y = Prediction, fill = Frequency)) +
  geom_tile(color = "white") +
  geom_text(aes(label = Frequency), vjust = 1) +
  scale_fill_gradient(low = "lightblue", high = "blue") +
  labs(title = "Confusion Matrix",
       x = "Actual",
       y = "Predicted") +
  theme_minimal()

# ROC and AUC
roc_curve <- roc(test_data$Churn, probabilities)
auc(roc_curve)

# Plot ROC Curve
plot(roc_curve, col = "blue", main = "ROC Curve for Customer Churn Prediction")

# Interpreting the Output:

# Step 5: Model Summary
# - The model summary provides details on each predictor's coefficient, standard error, z-value, and p-value.
# - Coefficients: Indicate the relationship between each predictor and the probability of churn.
#   Positive coefficients suggest an increase in the predictor increases the likelihood of churn, 
#   while negative coefficients suggest the opposite.
# - P-values: Determine the statistical significance of each predictor. Predictors with p-values 
#   less than a common threshold (e.g., 0.05) are considered significant.
# - Intercept: Represents the baseline log-odds of churn when all predictors are zero.

# Step 7: Evaluate Model Performance
# - Interpreting the Metrics:
#   - Accuracy: Represents the proportion of correct predictions 
#     out of the total predictions. Higher accuracy indicates 
#     better overall performance but may not be reliable in 
#     imbalanced datasets.
#   - Precision: Indicates the proportion of positive predictions 
#     that are actually correct. High precision means that when the 
#     model predicts churn, it is usually accurate.
#   - Recall (Sensitivity): Measures the model's ability to correctly 
#     identify actual churners. High recall means the model successfully 
#     captures most of the churn cases.
#   - F1 Score: The harmonic mean of precision and recall, providing 
#     a single metric that balances both. Useful when you need to 
#     balance the importance of precision and recall, especially 
#     in cases of class imbalance.

# - Confusion Matrix: Shows the model's performance in predicting churn.
#   - True Positives (TP): Correctly predicted 'Yes' for churn.
#   - True Negatives (TN): Correctly predicted 'No' for churn.
#   - False Positives (FP): Incorrectly predicted 'Yes' when it was 'No'.
#   - False Negatives (FN): Incorrectly predicted 'No' when it was 'Yes'.
#   - Key Metrics:
#     - Accuracy: (TP + TN) / Total observations. Represents the proportion of correct predictions.
#     - Sensitivity (Recall): TP / (TP + FN). Measures the model's ability to correctly identify churners.
#     - Specificity: TN / (TN + FP). Measures the model's ability to correctly identify non-churners.

# - ROC Curve and AUC:
#   - ROC Curve: Plots the True Positive Rate (Sensitivity) against the False Positive Rate (1 - Specificity).
#     - A curve closer to the top-left corner indicates better performance.
#   - AUC (Area Under the Curve): Represents the probability that the model ranks a randomly chosen
#     positive instance higher than a randomly chosen negative one.
#     - AUC ranges from 0 to 1, with 0.5 indicating no discrimination (random guessing) and 1 indicating
#       perfect discrimination.
#     - An AUC value closer to 1 indicates a better model.

########################################################################
########################################################################
# IMPACT
########################################################################
########################################################################
# Given our findings, go back to the mini case brief and answer our key
# reearch questions using the above analysis and visualizations.
