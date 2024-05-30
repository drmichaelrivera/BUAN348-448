# Load necessary library
library(tidyverse)

# Check the current working directory
print(getwd())

# List files in the current working directory to verify presence of the CSV file
print(list.files())

# Load the data
data <- read.csv("adjusted_tesla_dealership_sales_data.csv")

# View the first few rows of the data
head(data)

# Create the multiple linear regression model
model <- lm(Monthly_Sales_Revenue ~ Marketing_Spend + Test_Drive_Numbers + Customer_Satisfaction_Score +
              Number_of_Sales_Staff + Local_EV_Incentives + Service_Center_Rating +
              Average_Income + Unemployment_Rate + Competitor_Presence, data = data)

# Summarize the model
summary(model)