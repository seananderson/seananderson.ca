---
layout: post
title: Inset Panels for Multipanel Plotting in R
published: false
---

Inset panels in a plot can be a powerful way of increasing the data-density of a figure.

I usually add inset panels with the `fig` option of the `par` function. You set the `fig` coordinates for the inset and then confusingly add `par(new = TRUE)` to tell R that you *don't* want a new plot, instead you want to plot on top of the existing plot.

However, if you're plotting multiple panels using `mfrow`, `layout`, or `split.screen`, then when you set the `fig` option, R progresses to the next panel.

So, how can you get around this? Perhaps there are other options, but I used the `plt` option in `par`. This specifies the region of the plot window to use. It works nicely with any of the base graphics multipanel techniques.


