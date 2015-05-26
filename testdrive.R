# this loads a library
require(graphics)

# this command will bring up the documentation for each package 
# useful when no/little internet connection
library(help = "datasets")

# we'll take a look at some scientific times-series data (fun!)

# this loads a built-in data set
data(LakeHuron)

# this returns the type of data
# what is the difference? 
class(LakeHuron)
typeof(LakeHuron)

# this returns the first part of the data set
head(LakeHuron)

# this returns the variables available in the data set
names(LakeHuron)

# this show the first 1000 rows of the data
View(LakeHuron)

# this returns some basic summary statistics of the data set
summary(LakeHuron)

# this creates a basic plot for a timeseries
plot(LakeHuron)

# get rid of things you aren't using - helps when you have limited memory 
# or working with big data sets
rm(LakeHuron)