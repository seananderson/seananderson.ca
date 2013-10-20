---
layout: post
title: Cross-Referencing Line Numbers in LaTeX
subtitle: How to make writing reviewer response documents easier.
published: true
---

One of the more tedious elements of the scientific publishing process is cross-referencing all your revisions in a reply letter to the editor. Typically you make changes in your manuscript and then refer to those changes in the reply letter by page and line number.

For example, you might make a change to your manuscript and then in your reply letter you refer to it:

    We have revised the text. Please see page 3, line 23.

There are many strategies for dealing with this, but most of them require finding all your changes at the end and adding the page numbers and line numbers in the reply letter. This is fine if you only have to do it once, but inevitably something gets changed in the manuscript and all the cross-references need to be redone. Even worse, in working with Word documents that have track changes enabled I've experienced the line numbers changing after all changes are accepted.

I've settled on a fairly simple solution in LaTeX which requires minimal markup and automatically cross-references my changes. While this example deals with the case where the line numbers restart on each page, the solution is even simpler if you have continuous line numbers.

This solution assumes that your reply document is being written at the end of your manuscript. This isn't the only option, but it makes cross-referencing the simplest. At the end, before submitting the manuscript and reply document, I split the PDF in two.

First of all, you'll need to set up page-wise line numbers. Add the `lineno` package to the preamble:

```tex
\usepackage[pagewise]{lineno}
```


And wherever you want to start the line numbers in your document add:

```tex
\linenumbers
```

Now we'll set up two new commands in the preamble. First, create a new command to label your changes:

```tex
\newcommand{\R}[1]{\label{#1}\linelabel{#1}}
```

Then, create a new command to cross-reference your changes:

```tex
\newcommand{\lr}[1]{page~\pageref{#1}, line~\lineref{#1}}
```

Now, say you wanted to revise a sentence to deal with Reviewer comment A1. You can just add something like this within the manuscript:

```tex
\R{A1} A sentenced we have revised...
```

In the reply document, you can reference this change like this::
 
```tex
We have revised the text. Please see \lr{A1}.
```

Now, when you compile your document, this will get converted to:

```tex
We have revised the text. Please see page 3, line 23.
```

And as you modify your manuscript, the page and line numbers will update.
