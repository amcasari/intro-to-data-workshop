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
require(car) 

data(iris)
spm(~iris$Sepal.Length + iris$Sepal.Width + iris$Petal.Length
    + iris$Petal.Width | iris$Species)

# does this work so well with our data?
spm(~accident$MONTH + accident$DAY + accident$YEAR + accident$STATE + accident$COUNTY 
    + accident$WEATHER | accident$FATALS)
# Q: What is the difference in the data sets that might make iris pairplot easier to interpret?
# Q: How can we change our view into the accident data that might help?

# intro to histograms
ggplot(accident, aes(x = YEAR)) + geom_histogram(binwidth = 1)

# can save as a plot object to create a grid of histograms
p1 <- ggplot(accident, aes(x = YEAR)) + geom_histogram(binwidth = 1)
p2 <- ggplot(accident, aes(x = MONTH)) + geom_histogram(binwidth = 1)
p3 <- ggplot(accident, aes(x = DAY)) + geom_histogram(binwidth = 1)
p4 <- ggplot(accident, aes(x = STATE)) + geom_histogram(binwidth = 1)
p5 <- ggplot(accident, aes(x = COUNTY)) + geom_histogram(binwidth = 1)
p6 <- ggplot(accident, aes(x = FATALS)) + geom_histogram(binwidth = 1)
p7 <- ggplot(accident, aes(x = DRUNK_DR)) + geom_histogram(binwidth = 1)

require(gridExtra)
acc_hist <- grid.arrange(p1, p2, p3, p4, p5, p6, p7)

# intro to scatter plot
ggplot(accident, aes(x = FATALS, y = DRUNK_DR)) + geom_point()
# Q: Discuss how the plot reflects the data type...

# save to the figs dir
# can do this manually -> show this now!
pdf("accident_histogram_grid.pdf")
acc_hist <- grid.arrange(p1, p2, p3, p4, p5, p6, p7)
dev.off()

#### 5. Save your work
# as a csv
write.csv(accident, file = "output/trans_acc.csv", row.names = FALSE)

# as a RDS (r data serialization)
saveRDS(accident, "output/trans_acc.rds")