########################################
## A brief introduction to R
## Sean Anderson, sean_anderson@sfu.ca
## September 2011
########################################

## This file is meant to accompany the handout RIntro.pdf. I've left
## space between comments for you to write code. A lot of programming
## is about figuring out how to do it once (i.e. suffering) and then
## looking back at what you did when you need to do it again.
## Hopefully this file will serve as a reference for many of the
## common tasks you will run into.

## I'll have you read sections of the handout. Then we'll talk about
## that section briefly and I'll have you try and work out the
## relevant code in this worksheet.  Then we'll go over the code as a
## group and discuss any questions you have.
  
## First, read sections 1, 2, and 3 in the handout and open up RStudio
## or your preferred R script editor and console. Poke around the
## menus and options a bit if you aren't familiar with it. We'll
## discuss how the software is set up briefly.

###################################
## A quick introduction to objects
###################################
## Read sections 4, 5, 6 and have a go at the following:

# Make a vector of character that's 3 elements long. I'll start:
character.vector <- c("a", "b", "c")
# Now print it out in the console:
character.vector
# Make a vector of numeric that's 3 elements long:
numeric.vector <-
# Multiply your numeric.vector by 2:
numeric.vector <- 
# Make a logical vector (TRUE and FALSE) that's 3 elements long:
logical.vector <-
# Combine your 3 objects into a data frame with a new object name.
# You'll need to pick names for your columns.
my.data.frame <- 
# Make that data frame the first element of a list with a new object name:
my.list <- list()
my.list[[1] <- 
# Think about when you would want to use these various object types.

# Remove one of the objects:

# Remove all objects in your workspace:

# Now re-run the above code to get your objects back in your
# workspace. You'll need them for the next steps. Get in the habit
# of sending over code using the keyboard shortcuts instead of
# cutting and pasting or clicking on the buttons. In RStudio, you
# can select the relevant code and hit command-return on a Mac or
# control-return on a PC. 
# See Edit -> Run Code for all your options.

#################################################
## Looking at, manipulating, and subsetting data
#################################################
## Read the sections 7, 8, 9 and try the following:

# Let's start with some basic indexing and subsetting of the objects
# you created above.
# How could you extract the second value from your numeric vector?

# What are 3 ways to extract the 2nd column from your data frame?



# How can you extract the 2nd row of your data frame?

# How can you extract the rows in which the column logical.vector is
# "TRUE"?

# How could you select the first element of your list object?

# Putting it all together, can you print out the 2nd character
# value from within your data frame which is embedded in a list
# object? You're indexing from 3 main object classes here...
# that's about as complicated as it gets! 

# Notice the default options have converted your character values to
# factors. Converting object types is common and useful. Try using the
# as.character() function to convert your  "a", "b", "c" column of
# your data frame back into a character class.

# Now let's look at some more interesting data.
# Load the file "imdb.RData" that I sent you (File -> Open File)
# For future reference, once you've set your working directory, which
# we'll do later, you can use:
# load("imdb.RData")
# I created this file with save(imdb, file = "imdb.RData")

# You've now loaded a data frame object named imdb. It's a subset of
# the movies from the Internet Movie Database. Hadley Wickham wrote
# some code to make it easy to pull together. See
# https://github.com/hadley/data-movies 
# A version is also available in his ggplot2 package.  I've removed
# old movies, movies without many rankings, some of the data
# columns, and this dataset is missing movies since 2005. I wanted
# to keep this dataset reasonably small to make it easier to work
# with.

# Let's look at the data frame imdb in various useful ways:
# Try the following: names(), head(), tail(), summary(), str()







# What are the different (i.e. "unique") MPAA ratings included?

# How many movies are there in the dataset? You'll need to either look
# at the length of a column or the number of rows in the data frame.

# How many unique titles are there?

# Incidentally, here's how we can see which titles are
# duplicated:
imdb$title[duplicated(imdb$title)]

# What's the largest movie budget of all time? You will need to deal
# with the NA values. There is an option when you call the function
# max() to ignore them. Take a look at the help file first.
?max

# Which movie has that budget? You'll need to subset the data frame
# and use the "==" symbol combined with the line of code you just
# wrote in the last step.

# What are 2 ways to select all the movies with NC-17 ratings?




# Say you were in the mood for a PG drama or romance movie (isn't
# everybody?) but not a comedy. What movies fit those
# criteria?

# Say you wanted to model the number of votes against another
# variable. You discover that you need to log transform the votes to
# achieve normality of the residuals. First let's look at the
# distribution of votes:
hist(imdb$votes)

# Now create a new column named "log.votes" that is the log of the column
# "votes". Use the "$" sign notation this time:

# Now do the same thing with the transform() function:

# Now look at your transformed variable:
hist(imdb$log.votes)

# What's the mean movie length?

# Now let's write a basic loop. Remember, this is the syntax:
# for(i in 1:3) {
#   do something
# }
# Write a loop that prints out the mean movie length from 1990 to
# 2000. You'll need to subset the data.frame each time to pick the
# current year and use the print() statement to see the result.

# (There are better ways of doing this and storing the results, but
# that's beyond what we'll be covering in this workshop. See the apply
# functions and especially the plyr package.)


############################
## Reading and writing data
############################
## Read sections 10, 11, and 12 and try the following:

# Check what your current working directory is:
getwd()

# Set your working directory to wherever you downloaded the .csv file:

# read in the .csv file:
imdb <- read.csv("imdb.csv", stringsAsFactors = FALSE)
# The stringsAsFactors option tells R to keep the character values as
# character and not as factors. This will be simpler to work with in
# this case.

# Take a look at the data with the head() function to make sure it
# looks right. This is a good habit to get used to.

# Write out a .csv file of all comedy films called "imdb_comedy.csv":


#############################
## Packages and getting help
#############################
## Read sections 13 and 14 and try the following:

# Try installing the R package beanplot. You can do this from the
# command line or from the menu.

# Try bringing up the help and running one of the examples:

# Try loading the vignette for beanplot.

# Try using RSiteSearch() to search the R-help mailing list for
# something:

# Install the sos package and search for a package to do something.
# Try "multimodel averaging" or anything else you can think of.

# Don't forget about these great resources:  
# http://rseek.org/ 
# http://stackoverflow.com/
# http://stats.stackexchange.com/
# and of course: http://google.com/

############
## Plotting 
############
## Section 15 in the handout introduces plotting. Basic scatterplot
## plotting should be fairly straight forward and similar to that
## example. This is only scratching the surface of what's possible,
## but there should be lots of interesting patterns in the IMDb data
## nonetheless.

# (If we have time...)
# In groups of 3-4, come up with something interesting to plot from
# the IMDb data. We'll share at the end.

# Try customizing your plot. Some suggestions:
# - look at the help for ?plot.default and ?par
# - try changing the plot "type" in your call to plot()
# - change the axis labels
# - try shrinking the upper and right margins
# - try making the box and axes grey
# - try log transforming an axis directly in your call to plot()
# - try plotting 2 plots in the same figure (hint: look for mfrow or
#   mfcol in ?par)

