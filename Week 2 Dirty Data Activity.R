# Dirty Data Activity
# If you've download the Week 2 penn_health_records.csv in the same directory as this file you can now move 
# forward with the Dirty Data Activity. This activity has three parts.  First, we will assess. You can run the next 
# block of code.  Review all the comments, commands and output.  Second, we will think critically and reflect. 
# You'll find a series of questions posed. Write answers as comments. Third, we will proceed with cleaning. 
# Run the final code block and again, review the comments, commands and output.  

# Part 1: Assess

# Import necessary libraries
library(dplyr)
library(readr)
library(lubridate)

# Step 1: Load the dataset
# Read the CSV file
data <- read_csv("Week 2 penn_health_records.csv")

# Step 2: Review the Dataset
# Display the first few rows of the dataset
head(data)

# Step 3: Identify Data Issues
# 3.1: Check for missing data (NaNs)
missing_data <- colSums(is.na(data))
print("Missing Data:")
print(missing_data)

# 3.2: Check for inconsistent data formats
# Convert 'DateOfVisit' to datetime
data$DateOfVisit <- ymd(data$DateOfVisit)

# Check for invalid dates
invalid_dates <- sum(is.na(data$DateOfVisit))
print("Invalid Dates:")
print(invalid_dates)

# 3.3: Check for duplicate rows
duplicates <- sum(duplicated(data))
print("Duplicate Rows:")
print(duplicates)

# 3.4: Check for outliers (e.g., Age, Height, Weight)
outliers_age <- data %>% filter(Age < 0 | Age > 100)
outliers_height <- data %>% filter(Height < 140 | Height > 200)
outliers_weight <- data %>% filter(Weight < 50 | Weight > 120)
print("Outliers in Age:")
print(outliers_age)
print("Outliers in Height:")
print(outliers_height)
print("Outliers in Weight:")
print(outliers_weight)

# Part 2: Think Critically and Reflect
# Summarize your findings from above. What appears dirty? Be specific and document the various cases.

# Write your answers as comments below:
# What strategies can be used to handle missing data, and how do these strategies impact the overall analysis of the dataset?
# Provide examples from the Age, Gender, and Height columns.

# Explain the methods you can use to detect outliers in a dataset, particularly in columns like Age, Height, and Weight.
# How would you decide whether to retain, modify, or remove these outliers, and what justifications can you provide for your decision?

# Why is it important to validate and ensure consistency in data formats, such as dates?
# Demonstrate how you can identify and correct inconsistent date formats in the DateOfVisit column, and discuss the potential consequences of not addressing these issues.

# Part 3: Proceed with Cleaning

# 1. Handle Missing Data
# Fill missing names with a placeholder
data$Name[is.na(data$Name)] <- 'Unknown'

# Fill missing ages with the median
data$Age[is.na(data$Age)] <- median(data$Age, na.rm = TRUE)

# Drop rows where Gender is missing
data <- data %>% filter(!is.na(Gender))

# Fill missing heights with the median
data$Height[is.na(data$Height)] <- median(data$Height, na.rm = TRUE)

# Fill missing weights with the median
data$Weight[is.na(data$Weight)] <- median(data$Weight, na.rm = TRUE)

# Fill missing blood pressure and cholesterol with the most frequent value (mode)
mode_bp <- data %>% filter(!is.na(BloodPressure)) %>% count(BloodPressure) %>% top_n(1) %>% pull(BloodPressure)
data$BloodPressure[is.na(data$BloodPressure)] <- mode_bp

mode_chol <- data %>% filter(!is.na(Cholesterol)) %>% count(Cholesterol) %>% top_n(1) %>% pull(Cholesterol)
data$Cholesterol[is.na(data$Cholesterol)] <- mode_chol

# 2. Correct Invalid Dates
# Convert 'DateOfVisit' to Date and handle errors
data$DateOfVisit <- ymd(data$DateOfVisit)

# Fill invalid dates with the most frequent valid date
mode_date <- data %>% filter(!is.na(DateOfVisit)) %>% count(DateOfVisit) %>% top_n(1) %>% pull(DateOfVisit)
data$DateOfVisit[is.na(data$DateOfVisit)] <- mode_date

# 3. Remove Duplicate Rows
data <- data %>% distinct()

# 4. Handle Outliers
# Replace outliers in Age, Height, and Weight with the median
median_age <- median(data$Age, na.rm = TRUE)
median_height <- median(data$Height, na.rm = TRUE)
median_weight <- median(data$Weight, na.rm = TRUE)

data$Age <- ifelse(data$Age < 0 | data$Age > 100, median_age, data$Age)
data$Height <- ifelse(data$Height < 140 | data$Height > 200, median_height, data$Height)
data$Weight <- ifelse(data$Weight < 50 | data$Weight > 120, median_weight, data$Weight)

# Save the cleaned dataset
write_csv(data, "Week 2 penn_health_records_cleaned.csv")

# Verify the cleaning steps
print("Cleaned Data Summary:")
print(summary(data))
print(str(data))
