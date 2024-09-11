# =============================
# OVERVIEW:
# This script performs data cleaning, analysis, and visualization on retail sales data.
# It answers key business questions related to total sales, customer demographics, and spending behavior.
# =============================

# Load necessary libraries
library(dplyr)    # For data manipulation
library(ggplot2)  # For data visualization
library(GGally)   # For scatter plot matrix
library(reshape2) # For creating heatmaps
# Add a command below to load tidyr

# =============================
# LOAD DATA
# Read the CSV data file and store it in a dataframe
sales_data <- read.csv("Week 3 retail_sales_dataset.csv")

# View rows of the dataset to understand its structure
head(sales_data)
tail(sales_data)
print(sales_data)

str(sales_data)
summary(sales_data)

#sales_data <- mutate(sales_data, Log.TA = log(Total.Amount))

#data_filtered <- filter(sales_data, Age < 30)
#head(data_filtered)

# =============================
# STEP 1: HANDLING MISSING AND DUPLICATE DATA
# =============================
# HANDLE MISSING DATA
# Check for missing values in the dataframe
colSums(is.na(sales_data))

# Replace empty strings or 'NaN' with NA in the entire dataframe
sales_data[sales_data == "" | sales_data == "NaN"] <- NA

# Check for missing values in the dataframe again
colSums(is.na(sales_data))

# Fill missing values in Age with the median (if any)
sales_data$Age[is.na(sales_data$Age)] <- median(sales_data$Age, na.rm = TRUE)

# =============================
# HANDLE DUPLICATE DATA
# Check if any duplicates exist
duplicates_count <- sum(duplicated(sales_data))
print(paste("Number of duplicate rows:", duplicates_count))

# Remove any duplicate rows from the dataframe
sales_data <- distinct(sales_data)

# Check if any duplicates remain
duplicates_count <- sum(duplicated(sales_data))
print(paste("Number of duplicate rows:", duplicates_count))

# =============================
# STEP 2: IDENTIFYING REVENUE DECLINE BY PRODUCT CATEGORY
# =============================
# Calculate total sales for each product category
total_sales_per_category <- sales_data %>%
  group_by(Product.Category) %>%
  summarise(total_sales = sum(Total.Amount, na.rm = TRUE)) %>%
  arrange(desc(total_sales))

# Display the total sales per category
print("Total Sales per Category:")
print(total_sales_per_category)

# =============================
# Create a box plot to visualize the spread of total amount spent by category
ggplot(sales_data, aes(x = Product.Category, y = Total.Amount)) +
  geom_boxplot(aes(fill = Product.Category)) +
  ggtitle("Box Plot of Sales by Product Category") +
  xlab("Product Category") +
  ylab("Total Amount")

# A box plot visually represents the distribution of a dataset by showing
# its spread, central tendency, and potential outliers. The box spans the
# interquartile range (IQR), containing the middle 50% of the data, with
# a line inside the box representing the median. The whiskers extend to
# the minimum and maximum values within 1.5 times the IQR, and points
# beyond the whiskers are considered outliers. Symmetry or skewness is
# indicated by the length of the whiskers, showing how the data is
# distributed, with skewness revealed by longer whiskers on one side.

# =============================
# STEP 3: CUSTOMER DEMOGRAPHICS AND SPENDING BEHAVIOR
# =============================
# Analyze the average age of customers for each product category
average_age_per_category <- sales_data %>%
  group_by(Product.Category) %>%
  summarise(avg_age = mean(Age, na.rm = TRUE)) %>%
  arrange(desc(avg_age))

# Display the average age per category
print("Average Customer Age per Category:")
print(average_age_per_category)

# =============================
# Create a scatter plot matrix to explore relationships between Age, Quantity, and Total Amount
ggpairs(sales_data, columns = c("Age", "Quantity", "Total.Amount"),
        title = "Scatter Plot Matrix for Age, Quantity, and Total Amount")

# A scatter plot matrix displays pairwise relationships between multiple 
# variables in a dataset. Each cell in the matrix contains a scatter plot 
# comparing two variables, helping to visualize patterns, correlations, 
# or trends between them. The diagonal of the matrix typically shows 
# each variable's distribution, often as histograms or density plots. 
# Scatter plot matrices are useful for identifying relationships, 
# clustering, or outliers, providing an overview of how variables interact 
# across the dataset.

# =============================
# CHALLENGE: CREATE A CONNECTED SCATTER PLOT
# =============================
# Uncomment the code below and see if you can create a connected scatter plot using
# Date and Total Amount. Our initial dataframe is called sales_data - not data. 

# ggplot(data, aes(x = var1, y = var2)) + geom_line() + geom_point()

# Maybe just charting Date and Total Amount isn't very helpful?

# Let's try consider simplifying by computing monthly averages!

# print(sales_data)

# Ensure the Date column is in the correct Date format
# sales_data <- sales_data %>%
#   mutate(Date = as.Date(Date, format = "%m/%d/%y"))

# Calculate the average Total.Amount by month
# monthly_averages <- sales_data %>%
#   mutate(Month = format(Date, "%Y-%m")) %>%  # Create a new Month column in "YYYY-MM" format
#   group_by(Month) %>%  # Group by the Month column
#   summarize(Average_Total_Amount = mean(Total.Amount, na.rm = TRUE))  # Calculate the average

# Check the summarized data
# print(monthly_averages)

# Plot the monthly averages
# ggplot(monthly_averages, aes(x = Month, y = Average_Total_Amount, group = 1)) +
#   geom_line() +
#   geom_point() +
#   theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels for readability
#   labs(x = "Month", y = "Average Total Amount", title = "Average Total Amount by Month")

# =============================
# STEP 4: GENDER-BASED SPENDING ANALYSIS
# =============================
# Calculate total spending by gender
total_spending_by_gender <- sales_data %>%
  group_by(Gender) %>%
  summarise(total_spending = sum(Total.Amount, na.rm = TRUE)) %>%
  arrange(desc(total_spending))

# Display the total spending by gender
print("Total Spending by Gender:")
print(total_spending_by_gender)

# =============================
# CHALLENGE: CREATE A BAR CHART
# =============================

# Uncomment the code below and see if you can create a barplot using
# Gender and Total.Amount. Our dataframe is called sales_data - not data.
# ggplot(data, aes(x=name, y=value)) +
#   geom_bar(stat = "identity")

# =============================
# STEP 5: ANALYZING THE RELATIONSHIP BETWEEN KEY VARIABLES
# =============================
# Create a heatmap to visualize correlations between numerical variables
correlation_matrix <- cor(sales_data[, c("Age", "Quantity", "Total.Amount")], use = "complete.obs")

# Melt the correlation matrix for visualization
melted_corr_matrix <- melt(correlation_matrix)

# Plot the heatmap using ggplot2
ggplot(data = melted_corr_matrix, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1), space = "Lab", 
                       name="Correlation") +
  ggtitle("Heatmap of Correlations Between Age, Quantity, and Total Amount") +
  xlab("Variables") +
  ylab("Variables")

# A correlation heatmap visually represents the strength and direction of 
# relationships between variables in a dataset. Each cell in the heatmap 
# shows a correlation coefficient, typically ranging from -1 to 1, with 
# color intensity indicating the degree of correlation. Positive correlations 
# are closer to 1, while negative correlations are closer to -1. Heatmaps 
# make it easy to identify strong relationships, patterns, or trends between 
# variables at a glance, aiding in feature selection and understanding 
# data interactions.

# =============================
# CHALLENGE: CREATE SOMETHING ON YOUR OWN
# =============================

# Check out this awesome ggplot2 website: https://r-graph-gallery.com
# You can explore different visualizations and maybe find one that interests you.
# Drill down into and see the sample code.  Trying copying it into this file, updating it and runnning it.
# This dataset will not support all of these but you can focus on simpler ones first.  
