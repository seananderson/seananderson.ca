library(ggplot2)

# Introductory code from slides:
d <- data.frame(x = c(1:10, 1:10), 
                y = runif(20), 
                group1 = rep(gl(2, 5, labels = c("a", "b")), 2), 
                group2 = gl(2, 10))
head(d)
ggplot(d) + geom_point(aes(x = x, y = y, colour = group1)) + facet_grid(~group2)

# Exercises:
head(diamonds) # from the ggplot2 package
set.seed(1)
diamonds2 <- diamonds[sample(nrow(diamonds), 1000), ]

# Here's a basic plot with points to start with
ggplot(diamonds2, aes(x = carat, y = price)) + geom_point()

# Look up some geoms at http://docs.ggplot2.org/ and try at least 3
# with the diamonds2 dataset. geoms you might want to try: geom_line,
# geom_histogram, geom_bar, geom_violin, geom_point, geom_freqpoly ...


# By combining the aesthetics of geom_point: x, y, alpha, colour,
# shape, and size, see how many dimensions of the data you can display
# simultaneously with aesthetics.


# If you have time, try expressing the same data with different
# aesthetics.


# What happens when you specify a continuous vs. a factor variable for
# an aesthetic like colour?


# Try replacing one of the aesthetics with a facet_wrap.


# Now use facet_grid with the diamonds dataset.

