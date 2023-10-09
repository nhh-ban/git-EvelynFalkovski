library(tidyverse)
library(ggplot2)

# PROBLEM 2 
# read this data to a tidy data frame in R, without changing the raw data file 
# and without hard coding line numbers

# Read the entire data file into memory using the readLines()-function. Use the
# URL direcly or read the data from the local file that is in the repository.
df <- readLines("suites_dw_Table1.txt")

# Identify the line number L of the separator line between the column names and
# the rest of the data table.
L <- 
  (substr(x = df, start = 1, stop = 3) == "---") %>% 
  which() 

# Save the variable descriptions (i.e. the information in lines 1:(L-2)) in a
# text-file for future reference using the cat()-function
cat(df[1:(L-2)], sep = "|", file = "variable_descriptions")

# Extract the variable names (i.e. line (L-1)), store the names in a vector.
variable_names <- 
  str_split(string = df[(L-2):(L-1)], pattern = "\\|") %>% 
  unlist() %>% 
  str_trim()

# Read the data. One way to do this is to rewrite the data to a new .csv-file
# with comma-separators for instance using cat() again, with the variable names
# from the step above on the first line (see for instance paste() for collapsing
# that vector to a single string with commas as separators).
table <- read.table("suites_dw_Table1.txt", header = FALSE, sep = "|", quote = "", 
           dec = ".", skip = L,)
colnames(table) <- variable_names[2:13]

# I have found another way here as I did not unerstoo how to do it 
# according to the description


# PROBLEM 3
# The authors of the papers referenced above claim that their galaxy catalog 
# is approximately complete because it is a representative sample of a 
# particular volume in space (the ball of radius 11 megaparsecs centered on 
# you and me). There are, however, some signs that the smaller objects are 
# under-represented in the sample. Can you make a plot that reveals this 
# tendency and a likely explanation?

# making a histogram of liner diameter
hist(table$a_26)

# making a scatterplot of linear diameter & logarithm of the hydrogen mass
table %>% 
  ggplot(aes(x=a_26, y=log_mhi)) + geom_point()

# It seems like small objects are underrepresented. This can be seen in the 
# scatterplot of the diameter (a_26) and logarithm of the hydrogen mass (log_mhi).
# The plot shows a big empty spot for small diameter objects and medium
# logarithm of the hydrogen mass. Potentially these objects are difficult to observe.

