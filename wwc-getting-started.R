##### Women Who Code Seattle - Getting Started in Data Analysis with RStudio
# https://github.com/morningc/intro-to-data-workshop
#

### Working through new data set
# set up your working dir to access all your project dirs
setwd("~/repos/wwc/intro-to-data-workshop")

# 1. Load
# sample of 150 observations from fatal accident, 1975 - 2013
# for full data set: http://www.nhtsa.gov/FARS
# data load from csv
accident <- read.csv("data/accident.csv", header = TRUE, sep = ",")

# initial checks
# what kind of data did we load?
attributes(accident)

# how can we check the variable names/column names?
#CODE GOES HERE

# how can we check the first 5 rows?
#CODE GOES HERE

# how do we see the dataframe?
#CODE GOES HERE

#### 2. Format/Shape
# R works quickest with vectors, arrays and matrices
# sometimes moving data from dataframes to other data shapes can make things faster
# nb: this also helps you avoid using loops!

# different ways of slicing or subsetting data
# we'll look at extracts into a column....
# pay attention to the different types that are extracted
# are all the data methods equal? what does this mean when you check for equality?

class(accident$YEAR)
acc.year  <- accident$year
identical(accident$year, acc.year)

class(accident$STATE)
acc.state <- accident[,3]
identical(accident$STATE, acc.state)

class(accident$MONTH)
# Q: what is the difference in .subset and subset?
acc.month <- .subset(accident,6)
identical(accident$MONTH, acc.month)

class(accident$DAY)
acc.day <- accident$DAY
identical(accident$DAY, acc.DAY)

# checks to see if two objects are EXACTLY equal
identical(acc.state, accident$STATE)

# or we can do this using the dplyr package
require(dplyr)

year   <- select(accident, YEAR)
# Q: what types of variable does dplyr return?
#CODE GOES HERE

# Q: is this the same as the first time we subsetted the year?
#CODE GOES HERE

# filtering data
# using subset
acc.00 <- subset(accident, YEAR >= 2000)
# using dplyr
year00 <- filter(accident, YEAR >= 2000)
# Q: are these the same? what happens?

#### 3. Clean?
# look for NA's, nulls and other strange things happening

# TODO: intro is.na

# how we apply this...
acc.na <- accident[is.na(accident)]

#### 4. Explore
# how do we see a stats summary?
#CODE GOES HERE

# let's do some visual exploration
require(ggplot2)
# intro to pairplot
# intro to histograms
# intro to scatter plot
# plots for accident
# Q: can we do a pair plot? would this be useful?
# save to the figs dir

#### 5. Save your work
# as a csv
write.csv(trans_acc, file = "output/trans_acc.csv", row.names = FALSE)

# as a RDS (r data serialization)
saveRDS(trans_acc, "output/trans_acc.rds")