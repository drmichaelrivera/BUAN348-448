# Purpose: Add a new column "Initials" by extracting the first letter of each name.

# Step 1: Create a dataframe with columns "FirstName" and "LastName"
library(dplyr)

people <- data.frame(
  FirstName = c("John", "Jane", "Mike", "Sara"),
  LastName = c("Doe", "Smith", "Johnson", "Lee")
)

# Step 2a: Extract the first letter of "FirstName" and "LastName"
people <- people %>%
  mutate(FirstInitial = substr(FirstName, 1, 2),  # Extract first letter of first name
         LastInitial = substr(LastName, 1, 1))    # Extract first letter of last name

# Step 2b: Combine the initials into a single "Initials" column
people <- people %>%
  mutate(Initials = (FirstInitial + " " + LastInitial))

# Step 3: Remove the temporary columns used for extraction
people <- people %>%
  select(-FirstInitial, -LastInitial)

# Step 4: Print the final dataset
display(people)
