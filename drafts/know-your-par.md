---
layout: post
title: Know Your Par [Introduction]
---

If you want to work efficiently with base graphics in R and build high-customized beautiful graphics that clearly tell a story then you need to know `par` like the back of your hand. In a series of posts I will highlight key arguments in `par`. I will start by describing what `par` is.

What is `par`?
==============

`par` is a function that sets graphical parameters for base graphics in R. In plain English, `par` changes how plots will look. While you can set many graphical options within plotting functions themselves, `par` affects how the output from all plotting functions will look.  

`par` has an additional function --- it can return currently set graphical parameters. I will focus on that functionality in a later post.

How to use `par`
===============

You use `par` by calling it *before* you make a plot or call some graphical function. For example, you might call `par` to make all future plots a bit smaller and then make a plot:

```r
par(cex = 0.8)
plot(1)
```

Changing the rotation of axis labels with `las`
===============================================

Let's start with `las`. It seems that everyone asks at some point "How do I get my y-axis labels to be horizontal?" The idea is that labels are easier to read if they are horizontal. Some journals require labels to be horizontal. One way to achieve this is by setting `las` in a `par` call. `las` accepts values of `0`, `1`, `2`, or `3`. The default is `0` --- make all labels perpendicular to the axes. To set all axis labels as horizontal set `las` to `1`:

```r
par(las = 1)
```

Be aware that if you subsequently use a command like `mtext()` then you will have to explicitly set `las = 0` if you want any text vertical. For example:

```r
par(las = 1)
plot(1)
mtext("Some vertical text", side = 2, las = 1)
```

Suppressing the axis labels with `ann`
============================================

One strategy to develop highly-customized figures in R is to start with a basic plot with minimal annotations and build the figure piece by piece. A good starting point is to turn off default annotations. You can do this with the `ann` argument. 

`ann` turns off annotations for high-level plotting functions. For example, in `plot.default`, if `ann` was set to `FALSE` then x and y axis labels aren't plotted. This is a shortcut to setting the x and y axis labels to empty strings. For example, use this:

```r
plot(1, ann = FALSE)
```

Instead of this:

```r
plot(1, xlab = "", ylab = "")
```

You might later add axis labels with `mtext`:

```r
plot(1, ann = FALSE)
mtext("My x-axis label", side = 1)
```

