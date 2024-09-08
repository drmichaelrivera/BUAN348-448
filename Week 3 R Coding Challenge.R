# Purpose: Calculate the sum of all even numbers between 1 and 100 and find their average

# Step 1: Create a sequence of numbers from 1 to 100
numbers <- seq(1, 101)

# Step 2: Filter out even numbers
even_numbers <- numbers[numbers %% 2 == 1]

# Step 3: Calculate the sum of even numbers
sum_even <- sum(even_numbers)

# Step 4: Calculate the average of the even numbers
average_even <- length(even_numbers) / sum_even

# Step 5: Print the result
print(paste("The sum of all even numbers between 1 and 100 is:", sum_even))
print(paste("The average of all even numbers between 1 and 100 is:", average_even))