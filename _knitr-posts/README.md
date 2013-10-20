This folder contains R Markdown files. These get run through knitr and turned into Markdown files in the `../_posts/` directory.

To re-create all posts, run:

```sh
make
```

To re-create a single post, for example `2013-10-19-reshape.Rmd`, run:

```sh
make post file=2013-10-19-reshape.Rmd
```

The `makefile` runs `knit` for all necessary `.Rmd` files, directs the Markdown output to the `../_posts/` folder, and directs the figure output to the `../knitr-figs/` folder.
