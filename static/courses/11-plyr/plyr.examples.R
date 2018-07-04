library(plyr)
head(baseball) # see ?baseball

# plot the correlation between stolen bases and homeruns by year:
plot(ddply(baseball, "year", summarize, correlation = cor(sb, hr)), type = "b")

# capture the output from a linear model of stolen bases and homeruns
# for each year into a list:
out <- dlply(subset(baseball, year > 1950), "year", function(x) with(x, 
  lm(sb ~ hr)))
head(out)
summary(out[[1]]) # the first model output
summary(out[[2]]) # the second...

# browse through the data by year to build up a more complicated
# function (or debug an existing function)
# I've commented it out so you don't accidentally run it:
# out <- dlply(subset(baseball, year > 1950), "year", function(x) {
#  browser()
# })
# hit Return and look at the value of x each time
# type Q and hit the Return key to quit the browser

# get the slope and intercept from a linear model, fitting a separate
# linear model for each year:
out <- ddply(subset(baseball, year > 1950), "year", function(x) {
  lm.out <- as.numeric(coef(with(x, lm(hr ~ sb))))
  data.frame(slope = lm.out[2], intercept = lm.out[1])
})
head(out)

# create an additional column with the residuals from a linear model
# fit for each year:
out.residuals <- ddply(subset(baseball, year > 1950), "year", 
  transform, residuals = residuals(lm(hr ~ sb)))
head(out.residuals)

# get the mean stolen bases for each year and team combination:
out <- ddply(baseball, c("year", "team"), summarise, mean.sb = mean(sb, 
  na.rm = T))
head(out)

# Added bonus: plot it
# first exclude missing data and teams with less than 50 years of data 
# just for plotting:
out <- na.omit(out)
out <- subset(out, team %in% names(table(out$team))[table(out$team) >= 50])

# plot it:
library(ggplot2)
ggplot(out, aes(year, mean.sb)) + facet_wrap(~ team) + geom_line()
