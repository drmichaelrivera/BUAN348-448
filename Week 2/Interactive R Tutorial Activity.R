# Interactive R Tutorial Activity
# Read through each section below. You'll find in each section an essential command presented and runnable snippet of code.
# Run the snippet and then carry out the task. For tasks, I do provide helper code. 
# You can uncomment and tweak this or write your own from scratch. 
# In some cases, you might want to use a print() command to output the value. Try this.
# You can work with a partner/collaborator, but you should each run the code independently.

# R Syntax and Structure

## Understanding the importance of indentation in R
# Indentation is not syntactically required in R but is important for readability.

for (i in 1:5) {
  print(i)  # This line is inside the loop
}
print("Loop ended")  # This line is outside the loop

# Task: Fix the indentation error
# for (i in 1:5) {
# print(i)
# }

## Writing basic print statements and comments
# Print statements are used to display output, and comments are used to explain code.

print("Hello, World!")  # This is a print statement
# This is a comment

# Task: Write a print statement and a comment
# print("Your message here")

## Recognizing and using different data types
# R supports various data types like integers, doubles, characters, and logicals.

a <- 10  # Integer
b <- 3.14  # Double
c <- "Hello"  # Character
d <- TRUE  # Logical

# Task: Declare variables of different types
# x <- 42
# y <- 2.718
# z <- "R"
# w <- FALSE

# Variables and Data Types

## Declaring and initializing variables
# Variables store data values and can be initialized with a value.

name <- "Alice"
age <- 25

# Task: Declare and initialize two variables
# city <- "New York"
# population <- 8419000

## Type casting and type checking
# Type casting is used to convert one data type to another. Type checking is used to check the type of a variable.

num <- "123"
num_int <- as.integer(num)  # Type casting
print(class(num_int))  # Type checking

# Task: Convert a double to an integer and check its type
# value <- 9.99
# value_int <- as.integer(value)
# print(class(value_int))

## Performing arithmetic and string operations
# R supports various arithmetic and string operations.

result <- 10 + 5
greeting <- paste("Hello", "World!")

# Task: Perform a subtraction and concatenate two strings
# result <- 20 - 7
# message <- paste("Good", "Morning")

# Basic Operations

## Using operators (arithmetic, comparison, logical)
# Operators are used to perform operations on variables and values.

sum <- 10 + 5  # Arithmetic
is_equal <- (10 == 10)  # Comparison
logical_and <- (10 > 5) & (5 < 10)  # Logical

# Task: Use multiplication, greater than, and logical OR operators
# product <- 4 * 5
# is_greater <- (15 > 10)
# logical_or <- (5 > 3) | (3 > 5)

## String manipulation and formatting
# R provides various methods to manipulate and format strings.

text <- "Hello"
upper_text <- toupper(text)  # Convert to uppercase
formatted_text <- sprintf("Welcome, %s!", name)  # sprintf formatting

# Task: Convert a string to lowercase and use sprintf formatting
# text <- "R"
# lower_text <- tolower(text)
# age <- 30
# formatted_text <- sprintf("I am %d years old", age)

## Understanding and using built-in functions
# R has many built-in functions for various tasks.

length_val <- length("Hello")  # Get the length of a string
maximum <- max(10, 20, 30)  # Get the maximum value

# Task: Use built-in functions to find the minimum value and the absolute value
# minimum <- min(3, 1, 4)
# absolute <- abs(-10)

# Conditional Statements

## Writing and using if, else if, and else statements
# Conditional statements are used to perform different actions based on different conditions.

x <- 10
if (x > 0) {
  print("Positive")
} else if (x == 0) {
  print("Zero")
} else {
  print("Negative")
}

# Task: Write an if-else if-else statement to check if a number is positive, negative, or zero
# num <- -5
# if (num > 0) {
#     print("Positive")
# } else if (num == 0) {
#     print("Zero")
# } else {
#     print("Negative")
# }

## Understanding and applying logical operators
# Logical operators (and, or, not) are used to combine conditional statements.

a <- TRUE
b <- FALSE
if (a & !b) {
  print("Condition met")
}

# Task: Use logical operators to combine two conditions
# x <- 5
# y <- 10
# if (x < 10 & y > 5) {
#     print("Both conditions are true")
# }

## Nesting conditional statements
# Conditional statements can be nested inside each other.

score <- 85
if (score >= 60) {
  if (score >= 90) {
    print("Excellent")
  } else {
    print("Good")
  }
} else {
  print("Fail")
}

# Task: Write a nested conditional statement
# age <- 25
# if (age >= 18) {
#     if (age >= 21) {
#         print("Adult")
#     } else {
#         print("Young Adult")
#     }
# } else {
#     print("Minor")
# }

# Looping Constructs

## Using for loops for iteration over sequences
# For loops are used to iterate over a sequence (list, vector, etc.).

for (i in 1:5) {
  print(i)
}

# Task: Write a for loop to iterate over a vector
# fruits <- c("apple", "banana", "cherry")
# for (fruit in fruits) {
#     print(fruit)
# }

## Implementing while loops and understanding loop control (break, next)
# While loops are used to execute a block of code as long as a condition is true.

count <- 0
while (count < 5) {
  print(count)
  count <- count + 1
}

# Task: Write a while loop with a break statement
# num <- 0
# while (num < 10) {
#     if (num == 5) {
#         break
#     }
#     print(num)
#     num <- num + 1
# }

## Nested loops and their applications
# Loops can be nested inside each other to perform complex tasks.

for (i in 1:3) {
  for (j in 1:2) {
    print(paste("i:", i, "j:", j))
  }
}

# Task: Write a nested loop to print a pattern
# for (i in 1:3) {
#     for (j in 1:i) {
#         cat("*")
#     }
#     cat("\n")
# }

# Functions

## Defining functions with parameters
# Functions are defined using the function keyword and can take parameters.

greet <- function(name) {
  print(paste("Hello,", name))
}

# Task: Write a function that takes two parameters and prints their sum
# add <- function(a, b) {
#     print(a + b)
# }

## Understanding scope and lifetime of variables
# Scope refers to the visibility of variables. Variables defined inside a function are local to that function.

my_function <- function() {
  local_var <- 10
  print(local_var)
}

# Task: Write a function and access a variable inside it
# show_message <- function() {
#     message <- "Hello"
#     print(message)
# }

## Using return values and the return statement
# The return statement is used to return a value from a function.

square <- function(x) {
  return(x * x)
}

# Task: Write a function that returns the product of two numbers
# multiply <- function(a, b) {
#     return(a * b)
# }

# Lists and Tuples

## Creating, accessing, and modifying lists and tuples
# Lists are mutable sequences, while tuples (implemented as vectors in R) are immutable.

my_list <- list(1, 2, 3)
my_tuple <- c(4, 5, 6)
my_list[[1]] <- 10

# Task: Create a list and a tuple, then modify the list
# fruits <- list("apple", "banana", "cherry")
# numbers <- c(1, 2, 3)
# fruits[[2]] <- "orange"

## List comprehensions and tuple unpacking
# List comprehensions provide a concise way to create lists. Tuple unpacking assigns values to multiple variables.

squares <- lapply(1:5, function(x) x * x)
a <- my_tuple[1]
b <- my_tuple[2]
c <- my_tuple[3]

# Task: Use a list comprehension to create a list of cubes
# cubes <- lapply(1:4, function(x) x^3)

## Common list methods and operations (append, pop, sort)
# Lists have various methods to perform operations like adding, removing, and sorting elements.

my_list <- list(3, 1, 4)
my_list <- append(my_list, 2)
my_list <- my_list[-2]
my_list <- sort(unlist(my_list))

# Task: Append an element to a list, remove an element, and sort the list
# numbers <- list(10, 5, 8)
# numbers <- append(numbers, 3)
# numbers <- numbers[-1]
# numbers <- sort(unlist(numbers))

# Sets

## Creating and using sets
# Sets are unordered collections of unique elements.

my_set <- unique(c(1, 2, 3, 4))
my_set <- unique(c(my_set, 5))

# Task: Create a set and add an element to it
# colors <- unique(c("red", "blue", "green"))
# colors <- unique(c(colors, "yellow"))

## Understanding set operations (union, intersection, difference)
# Sets support various operations like union, intersection, and difference.

set1 <- c(1, 2, 3)
set2 <- c(3, 4, 5)
union_set <- unique(c(set1, set2))
intersection_set <- intersect(set1, set2)

# Task: Perform union and difference operations on sets
# setA <- c(1, 2, 3)
# setB <- c(3, 4, 5)
# union_result <- unique(c(setA, setB))
# difference_result <- setdiff(setA, setB)

## Using sets for membership testing and eliminating duplicates
# Sets can be used to test membership and remove duplicates from a list.

numbers <- c(1, 2, 2, 3, 4, 4)
unique_numbers <- unique(numbers)

# Task: Remove duplicates from a list using a set
# items <- c("apple", "banana", "apple", "cherry")
# unique_items <- unique(items)

# Dictionaries

## Creating and accessing dictionaries
# Dictionaries (implemented as lists in R) are collections of key-value pairs.

my_dict <- list(name = "Alice", age = 25)
print(my_dict$name)

# Task: Create a dictionary and access a value
# person <- list(name = "Bob", city = "Paris")
# print(person$city)

## Adding, modifying, and deleting key-value pairs
# Dictionaries can be modified by adding, updating, or removing key-value pairs.

my_dict$age <- 26
my_dict$city <- "New York"
my_dict$name <- NULL

# Task: Add, modify, and delete key-value pairs in a dictionary
# info <- list(brand = "Toyota", model = "Corolla")
# info$year <- 2021
# info$model <- "Camry"
# info$brand <- NULL

## Dictionary methods and looping through dictionaries
# Dictionaries have methods like keys(), values(), and items() for iteration.

for (key in names(my_dict)) {
  print(paste(key, my_dict[[key]], sep = ": "))
}

# Task: Loop through a dictionary and print its keys and values
# data <- list(country = "USA", capital = "Washington")
# for (key in names(data)) {
#     print(paste(key, data[[key]], sep = ": "))
# }

# Importing Modules

## Importing standard libraries and using aliases (e.g., import math as m)
# Modules can be imported to use additional functionality.

library(ggplot2)
print(ggplot2::ggplot)

# Task: Import the stats library and use a function
# print(stats::rnorm(1))

## Understanding the structure of R packages
# Packages are collections of R functions, data, and compiled code.

library(ggplot2)
print(ls("package:ggplot2"))  # Lists all attributes and methods of the ggplot2 package

# Task: Import the utils package and list its attributes
# library(utils)
# print(ls("package:utils"))

# Standard Libraries

## Using math for mathematical operations
# The base package provides mathematical functions and constants.

print(pi)
print(factorial(5))

# Task: Use the base package to calculate the square root and sine of a number
# print(sqrt(25))
# print(sin(pi / 2))

## Using random for generating random numbers
# The base package provides functions for generating random numbers.

set.seed(123)
print(runif(1))
print(sample(1:10, 1))

# Task: Use the base package to generate a random float and a random choice from a list
# set.seed(123)
# print(runif(1, min = 1, max = 5))
# choices <- c("apple", "banana", "cherry")
# print(sample(choices, 1))

## Exploring other useful libraries like lubridate and dplyr
# The lubridate package provides functions for date and time manipulation, and the dplyr package provides functions for data manipulation.

library(lubridate)
now <- now()
print(now)

library(dplyr)
current_dir <- getwd()
print(current_dir)

# Task: Use the lubridate package to get the current date and time, and the dplyr package to list files in the current directory
# today <- today()
# print(today)
# print(list.files("."))

# Third-Party Libraries

## Introduction to NumPy for numerical operations
# NumPy is a library for numerical operations in Python. (Use base R functions for similar operations in R)

arr <- c(1, 2, 3, 4)
print(mean(arr))
print(sd(arr))

# Task: Use base R functions to create an array and calculate its sum and product
# arr <- c(5, 6, 7, 8)
# print(sum(arr))
# print(prod(arr))

## Using pandas for data manipulation and analysis
# Pandas is a library for data manipulation and analysis. (Use dplyr for similar operations in R)

library(dplyr)
data <- data.frame(name = c("Alice", "Bob"), age = c(25, 30))
print(data)

# Task: Use dplyr to create a data frame and display its summary statistics
# library(dplyr)
# data <- data.frame(city = c("New York", "Los Angeles"), population = c(8419000, 3980000))
# print(summary(data))

## Basics of data visualization with matplotlib
# Matplotlib is a library for creating static, animated, and interactive visualizations in Python. (Use ggplot2 in R)

library(ggplot2)
x <- 1:4
y <- c(10, 20, 25, 30)
df <- data.frame(x, y)
ggplot(df, aes(x, y)) + geom_line() + labs(x = "X-axis", y = "Y-axis", title = "Line Graph")

# Task: Use ggplot2 to create a bar chart
# library(ggplot2)
# categories <- c("A", "B", "C")
# values <- c(5, 7, 3)
# df <- data.frame(categories, values)
# ggplot(df, aes(x = categories, y = values)) + geom_bar(stat = "identity") + labs(x = "Category", y = "Values", title = "Bar Chart")

# Reading and Writing Files

## Opening and closing files using different modes (r, w, a)
# Files can be opened in various modes like read (r), write (w), and append (a).

file <- file("example.txt", "w")
writeLines("Hello, world!", file)
close(file)

# Task: Open a file in read mode and print its content
# file <- file("example.txt", "r")
# content <- readLines(file)
# print(content)
# close(file)

## Reading from files using readLines
# Files can be read using the readLines function.

file <- file("example.txt", "r")
print(readLines(file))
close(file)

# Task: Read a file line by line using readLines
# file <- file("example.txt", "r")
# line <- readLines(file, n = 1)
# while (length(line) > 0) {
#     print(line)
#     line <- readLines(file, n = 1)
# }
# close(file)

# Handling Different File Formats

## Reading and writing CSV files using the read.csv and write.csv functions
# The read.csv and write.csv functions provide functions to read and write CSV files.

write.csv(data.frame(Name = c("Alice", "Bob"), Age = c(25, 30)), "example.csv", row.names = FALSE)

# Task: Read a CSV file and print its contents
# data <- read.csv("example.csv")
# print(data)

## Introduction to JSON file handling
# The jsonlite package provides functions to read and write JSON data.

library(jsonlite)
data <- list(name = "Alice", age = 25)
write_json(data, "example.json")

# Task: Read a JSON file and print its contents
# data <- fromJSON("example.json")
# print(data)

## Basics of working with Excel files using the readxl and writexl packages
# The readxl and writexl packages provide functions to read and write Excel files.

library(writexl)
data <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
write_xlsx(data, "example.xlsx")

# Task: Read an Excel file and print its contents
# library(readxl)
# data <- read_excel("example.xlsx")
# print(data)

# Data Input and Output

## Using readline for taking user input
# The readline function is used to take user input.

name <- readline(prompt = "Enter your name: ")
print(paste("Hello,", name))

# Task: Take user input for age and print a message
# age <- readline(prompt = "Enter your age: ")
# print(paste("You are", age, "years old"))

## Formatting output using print and sprintf
# Output can be formatted using the print function and sprintf.

value <- 10
print(sprintf("The value is %d", value))

# Task: Format and print a message with multiple variables
# city <- "New York"
# population <- 8419000
# print(sprintf("The population of %s is %d", city, population))