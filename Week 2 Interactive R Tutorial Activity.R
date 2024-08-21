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

# Task 1: Fix the indentation error
# for (i in 1:5) {
# print(i)
# }

## Writing basic print statements and comments
# Print statements are used to display output, and comments are used to explain code.

print("Hello, World!")  # This is a print statement
# This is a comment

# Task 2: Write a print statement and a comment
# print("Your message here")

## Recognizing and using different data types
# R supports various data types like integers, doubles, characters, and logicals.

a <- 10  # Integer
b <- 3.14  # Double
c <- "Hello"  # Character
d <- TRUE  # Logical

# Task 3: Declare variables of different types
# x <- 42
# y <- 2.718
# z <- "R"
# w <- FALSE

# Variables and Data Types

## Declaring and initializing variables
# Variables store data values and can be initialized with a value.

name <- "Alice"
age <- 25

# Task 4: Declare and initialize two variables
# city <- "New York"
# population <- 8419000

## Type casting and type checking
# Type casting is used to convert one data type to another. Type checking is used to check the type of a variable.

num <- "123"
num_int <- as.integer(num)  # Type casting
print(class(num_int))  # Type checking

# Task 5: Convert a double to an integer and check its type
# value <- 9.99
# value_int <- as.integer(value)
# print(class(value_int))

## Performing arithmetic and string operations
# R supports various arithmetic and string operations.

result <- 10 + 5
greeting <- paste("Hello", "World!")

# Task 6: Perform a subtraction and concatenate two strings
# result <- 20 - 7
# message <- paste("Good", "Morning")

## String manipulation and formatting
# R provides various methods to manipulate and format strings.

text <- "Hello"
upper_text <- toupper(text)  # Convert to uppercase
formatted_text <- sprintf("Welcome, %s!", name)  # sprintf formatting

# Task 7: Convert a string to lowercase and use sprintf formatting
# text <- "R"
# lower_text <- tolower(text)
# age <- 30
# formatted_text <- sprintf("I am %d years old", age)

## Understanding and using built-in functions
# R has many built-in functions for various tasks.

length_val <- length("Hello")  # Get the length of a string
maximum <- max(10, 20, 30)  # Get the maximum value

# Task 8: Use built-in functions to find the minimum value and the absolute value
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

# Task 9: Write an if-else if-else statement to check if a number is positive, negative, or zero
# num <- -5
# if (num > 0) {
#     print("Positive")
# } else if (num == 0) {
#     print("Zero")
# } else {
#     print("Negative")
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

# Task 10: Write a nested conditional statement
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

# Task 11: Write a for loop to iterate over a vector
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

# Task 12: Write a while loop with a break statement
# num <- 0
# while (num < 10) {
#     if (num == 5) {
#         break
#     }
#     print(num)
#     num <- num + 1
# }

# Functions

## Defining functions with parameters
# Functions are defined using the function keyword and can take parameters.

greet <- function(name) {
  print(paste("Hello,", name))
}

# Task 13: Write a function that takes two parameters and prints their sum
# add <- function(a, b) {
#     print(a + b)
# }

## Using return values and the return statement
# The return statement is used to return a value from a function.

square <- function(x) {
  return(x * x)
}

# Task 14: Write a function that returns the product of two numbers
# multiply <- function(a, b) {
#     return(a * b)
# }

# Sets

## Understanding set operations (union, intersection, difference)
# Sets support various operations like union, intersection, and difference.

set1 <- c(1, 2, 3)
set2 <- c(3, 4, 5)
union_set <- unique(c(set1, set2))
intersection_set <- intersect(set1, set2)

# Task 15: Perform union and difference operations on sets
# setA <- c(1, 2, 3)
# setB <- c(3, 4, 5)
# union_result <- unique(c(setA, setB))
# difference_result <- setdiff(setA, setB)

# Dictionaries

## Creating and accessing dictionaries
# Dictionaries (implemented as lists in R) are collections of key-value pairs.

my_dict <- list(name = "Alice", age = 25)
print(my_dict$name)

# Task 16: Create a dictionary and access a value
# person <- list(name = "Bob", city = "Paris")
# print(person$city)

## Dictionary methods and looping through dictionaries
# Dictionaries have methods like keys(), values(), and items() for iteration.

for (key in names(my_dict)) {
  print(paste(key, my_dict[[key]], sep = ": "))
}

# Task 17: Loop through a dictionary and print its keys and values
# data <- list(country = "USA", capital = "Washington")
# for (key in names(data)) {
#     print(paste(key, data[[key]], sep = ": "))
# }

# Importing Modules

## Understanding the structure of R packages
# Packages are collections of R functions, data, and compiled code.

library(ggplot2)
print(ls("package:ggplot2"))  # Lists all attributes and methods of the ggplot2 package

# Task 18: Import the utils package and list its attributes
# library(utils)
# print(ls("package:utils"))

# Standard Libraries

## Using math for mathematical operations
# The base package provides mathematical functions and constants.

print(pi)
print(factorial(5))

# Task 19: Use the base package to calculate the square root and sine of a number
# print(sqrt(25))
# print(sin(pi / 2))

## Exploring other useful libraries like lubridate and dplyr
# The lubridate package provides functions for date and time manipulation, and the dplyr package provides functions for data manipulation.

library(lubridate)
now <- now()
print(now)

library(dplyr)
current_dir <- getwd()
print(current_dir)

# Task 20: Use the lubridate package to get the current date and time, and the dplyr package to list files in the current directory
# today <- today()
# print(today)
# print(list.files("."))

# Reading and Writing Files

## Opening and closing files using different modes (r, w, a)
# Files can be opened in various modes like read (r), write (w), and append (a).

file <- file("example.txt", "w")
writeLines("Hello, world!", file)
close(file)

# Task 21: Open a file in read mode and print its content
# file <- file("example.txt", "r")
# content <- readLines(file)
# print(content)
# close(file)

## Reading from files using readLines
# Files can be read using the readLines function.

file <- file("example.txt", "r")
print(readLines(file))
close(file)

# Task 22: Read a file line by line using readLines
# file <- file("example.txt", "r")
# line <- readLines(file, n = 1)
# while (length(line) > 0) {
#     print(line)
#     line <- readLines(file, n = 1)
# }
# close(file)

# Handling Different File Formats

## Introduction to JSON file handling
# The jsonlite package provides functions to read and write JSON data.

library(jsonlite)
data <- list(name = "Alice", age = 25)
write_json(data, "example.json")

# Task 23: Read a JSON file and print its contents
# data <- fromJSON("example.json")
# print(data)

## Basics of working with Excel files using the readxl and writexl packages
# The readxl and writexl packages provide functions to read and write Excel files.

library(writexl)
data <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
write_xlsx(data, "example.xlsx")

# Task 24: Read an Excel file and print its contents
# library(readxl)
# data <- read_excel("example.xlsx")
# print(data)

# Data Input and Output

## Using readline for taking user input
# The readline function is used to take user input.

name <- readline(prompt = "Enter your name: ")
print(paste("Hello,", name))

# Task 25: Take user input for age and print a message
# age <- readline(prompt = "Enter your age: ")
# print(paste("You are", age, "years old"))

## Formatting output using print and sprintf
# Output can be formatted using the print function and sprintf.

value <- 10
print(sprintf("The value is %d", value))

# Task 26: Format and print a message with multiple variables
# city <- "New York"
# population <- 8419000
# print(sprintf("The population of %s is %d", city, population))
