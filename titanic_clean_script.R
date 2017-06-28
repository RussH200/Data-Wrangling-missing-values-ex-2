# Read in libraries needed - reading dplyr twice as it's been an compatibility warning in version 3.3.3

library(tidyverse)
library(dplyr)

# read in xcel .xls format using read_xls
test_df <- readxl::read_xls("titanic3.xls")
# write out CSV format
write.csv(test_df, "titanic_original.csv")

# Read in titanic CSV file - Header = True and sep = "," - create dataframe df : df
df <- read.csv("titanic_original.csv")

# Using the sub function find blank spaces and empty strings and replace with "S" inn embarked column
df$embarked <- sub("^$", "S", df$embarked)

# Calculate the mean of the age column - make sure empty (NA's) are not included in mean calculation: titanic_age_mean
titanic_age_mean <- mean(df$age, na.rm = TRUE)
# Use the results and assign it back to the age column for any rows that were NA's
df$age[is.na(df$age)] <- titanic_age_mean

# Subsitute NA for empty strings for passengers who did not make it to life boats
df$boat <- sub("^$", "NA", df$boat)

# Use mutate to create number 1 if there is cabin number otherwise 0 - create column has_cabin_number
df <- mutate(df, has_cabin_number = ifelse(cabin == "", 0, 1))

# write out results to a new CSV file titanic_clean.csv
write.csv(df, "titanic_clean.csv")
