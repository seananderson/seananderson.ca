---
layout: post
title: Debugging R Functions
subtitle: Solving problems with R code quickly.
published: true
---

Knowing how to debug functions is a critical skill if you want to work
proficiently in R. In my experience, many graduate student R users aren't
aware of the debugging options. Maybe this stems from how many people learn
R. They attend an introductory course or work their way through a
introductory book. These courses or books typically touch on using functions
in R but don't go into detail (but see Hadley Wickham's upcoming book
[Advanced R programming][]). These R users then develop their own expertise.

However, one of the insidious elements of self-teaching a programming
language is that if a problem isn't obvious then it's hard to seek a
solution. In the context of debugging, I'd bet that many users, and in
particular those not familiar with other high-level programming languages,
don't know how much easier their R coding lives could be. 

Read on for an introduction to the basic R debugging strategies that every
user should be familiar with. To paraphrase Hadley from a talk he gave in
Vancouver: if you don't know these strategies, you're coding blind.

# Old-school strategies

These are the lowest-level options. Many users figure these out for
themselves or learn them from other lower-level programming languages that
don't have as advanced debugging options. They are useful strategies, but
only as part of a complete debugging toolbox.

## Trial and error

See an error. Guess the solution. Run the code again. A fast solution for
simple errors. But if the solution was obvious we wouldn't be
talking about debuggers, right?

## Make your function global

Turn the arguments of a function into global objects. Step through the code
and figure out the problem. For example, turn this:

```r
f <- function(x = 1) x * 2
```

into this:

```r
x <- 1
x * 2
 ```

This strategy breaks down for functions that receive many arguments. It also
creates many global objects that match function arguments names, which can
become confusing. This strategy is rarely the best solution given the options
I'll describe below.


## Add print statements

Add `print()` around key objects within your function and read the value of
the objects as the function runs. This is a robust strategy and one that users
familiar with lower-level languages (e.g. C, C++, or Fortran) often fall back
on. Keep this strategy handy, but realize that its key disadvantage is that it
isn't interactive. All you see are object values, but you can't interact with
them to deduce the cause of a problem.

# When things get complicated

The following set of functions and options can dramatically improve your
ability to solve complicated coding problems.

## traceback

When you encounter an error, your first course of action should be to run the
function `traceback()`. `traceback()` will list the chain of functions that
led to the error. This might be enough to figure out the solution and if not
you'll at least get a good idea of which function to debug.

## browser

Similar to Portlandia's "[Put a bird on it][]", my go-to solution when I'm
debugging a function is to "Put a `browser()` on it". 

To use `browser()` you add the line `browser()` somewhere in your function. For example:

```r
times_two <- function(x) {
  browser()
  x * 2
}
```

When you call the function you'll pop out in the function wherever you put
the `browser()` statement and have access to the local workspace:

```r
times_two(5)
```

    Called from: times_two()
    Browse[1]> 

We can now access the local value of `x`:

    Browse[1]> x
    [1] 5

You can either work through the function line by line by typing `n` and hit
enter in the R console, or you can send lines of code to the console line by
line. When you hit enter the function will continue running until it finishes
or reaches another `browser()` statement. Importantly, to get out, type the
letter `Q` and hit enter. Note that you can nest `browser()` statements if you
need to, just keep track of what function you're inside.

## Turn errors to debuggers

If you set the following option before calling your function:

```r
options(error = recover)
```

then the R console will pop out in debugging mode when it encounters an
error. This is equivalent to placing a `browser()` statement at precisely the
location where the error occurs.

If the problem is associated with a warning instead of an error, then you can
also set the following option so that the debugger will start on warnings:

```r
options(warn = 2)
```

## Debugging installed packages

What if the error stems from a function in an installed R package? There are
various ways to approach this problem.

A first approach might be to set `options(error = recover)` and then work
through the code line by line with `n`.

For complicated issues, it might help to have a copy of the function code in
front of you. For most R functions you can start by printing the name of the
function in the R console (without parentheses or arguments) and hitting
enter. If the code is written in R then this will print out function code.
You can then copy and paste this into a text editor. In many cases you can
edit this code directly as if it were your own code, load it into the global
workspace (`source()` it in R), and debug it.

This won't work in all cases because of namespace issues. If all else fails,
trying Googling for the package and downloading the source code. You are then
free to read, modify (e.g. `browser()` or `print()` statements), and install
it as needed. You might want to consider the `devtools` package and the
`load_all()` or `install()` functions to make this process more rapid.

# Error handling and recovery

What about the case where you don't want your code to fail on an error? Maybe
you're running a series of models but not all models converge. Or maybe some
iterations of a loop contain a missing value that creates an error during data
manipulation. These are cases where `try()` and `tryCatch()` can be useful.
`try()` is a simplified wrapper function for `tryCatch()` that prints the
error and continues. `tryCatch()` will let you handle the error cases yourself
and optionally let the function continue.

Let's start with a simple function that throws an error if the input value is
1 and prints the input value otherwise:

```r
f <- function(x) {
  if(x == 1) {
    stop("x cannot equal 1")
  } else {
    print(x)
  }
}
```

If we feed this function values of 1 and 2 then the function will stop with an error:

```r
y <- sapply(1:3, function(i) f(i))
```

    Error in f(i) : x cannot equal 1

We can use `try()` to capture the error message but continue running the function:

```r
y <- sapply(1:3, function(i) try(f(i)))
y
```

    [1] "Error in f(i) : x cannot equal 1\n" "2" "3"

Alternatively, we could use `tryCatch()` to do something when we get an error. Here, we'll return an NA value:

```r
y <- sapply(1:3, function(i) tryCatch(f(i), error = function(e) NA))
y
```

    [1] NA  2  3

You could run any simple function you'd like on an error to figure out what's
wrong. You could also dump the value of an object with `save()` or maybe even
dump the whole workspace into a file with `save.image()`.

# Summary

Hopefully you find these debugging strategies useful. With practice debugging
small R functions should become easier than debugging a large chunk of global
code. Many of the options serve a similar purpose. As a result, you may
choose to become familiar with one or two of them. Just keep the other
strategies in your debugging toolbox for when you're stuck. Often approaching the
same problem from multiple angles is just what you need to understand the
problem and find a solution.

[Put a bird on it]: http://www.youtube.com/watch?v=iHmLljk2t8M
[Advanced R programming]: http://adv-r.had.co.nz
