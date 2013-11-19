---
layout: post
title: C++ with R on OS X Mavericks
subtitle: Steps to get C++ and Rcpp working on Mavericks
published: true
---

Incorporating bits of C++ into your `R` coding through the `Rcpp` package is a great way to remove bottlenecks in your code and dramatically improve speed — particularly for operations that requires lots of loops with relatively simple data manipulation.

To work with `Rcpp` you need a working C++ setup for `R`. This is mildly non-trivial on OS X Mavericks, and so instead of explaining this repeatedly, I am writing this as a blog post to refer people to. I gleaned these steps from a combination of [RStudio's documentation](http://www.rstudio.com/ide/docs/packages/prerequisites), posts by Dirk Eddelbuettel and Romain Francois (developers of `Rcpp`) on Stack Overflow, and a resolved issue on the `dplyr` GitHub issues tracker that I can no longer find.

First, you need a C++ compiler. For that, you can download XCode and install the Command Line Tools from the preferences. But, XCode.app is a huge application that you don't need unless you're developing OS X or iOS applications. Instead you can download just the slimmer Command Line Tools on their own by [registering as an Apple Developer](https://developer.apple.com/programs/register/), and then [downloading](https://developer.apple.com/downloads/) the version of the Command Line Tools that is appropriate for your operating system (i.e. Mavericks if that's why you're reading this).

Second, you need to tell `R` which compilers to use. To do that, we need to create a file `~/.R/Makevars`. If you are handy on the command line and have your own favourite text editor, by all means have at it. Otherwise, you can do this with the following commands in Terminal:

```sh
cd ~/.R
nano Makevars
```

Now add the following text:

```sh
CC=clang
CXX=clang++
```

And follow the directions at the bottom of the screen to "write out" and close the file. (Control-O Enter and Control-X.)

OK. Now we need to install `Rcpp` from source so it's built with the same C++ compiler we are using. In `R`:

```r
install.packages("Rcpp", type = "source")
```

A good test that everything is set up correctly is to use the `devtools` package. In `R`:

```r
install.packages("devtools")
devtools::has_devel()
```

If that returns `TRUE`, you're (probably) good to go. If it returns an error, you have a problem. Revisit the above steps and remember that Google is your friend.

As a little test of `Rcpp`, try running this trivial example from Hadley Wickham's awesome [Advanced R programming](http://adv-r.had.co.nz/Rcpp.html) book:

```r
library(Rcpp)
cppFunction('
  int one() {
    return 1;
  }
')
one()
```

You should also now be able to install from source `R` packages that use C++, such as [dplyr](https://github.com/hadley/dplyr), also known as `plyr` 2.0.

```r
devtools::install_github("dplyr")
```

`dplyr` is a great example of what's possible with a little C++. I finally got to play with `dplyr` last week. `dplyr` sliced, diced, and manipulated 16 million rows of data in about 4 seconds. `plyr` took approximately... far longer than I was willing to wait around and see. `dplyr` makes me excited about the future of data manipulation in `R`.
