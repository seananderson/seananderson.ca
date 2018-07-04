## An introduction to ggplot2

This repository has notes and exercises to help you teach yourself how to rapidly explore data with the ggplot2 R package.

It was written as a self-study component for the FISH554 class at the University of Washington.

### Instructions

1. Download this whole repository as [a ZIP file](<https://github.com/seananderson/ggplot2-FISH554/archive/master.zip>) and extract the ZIP file.

2. Find the notes document `ggplot2-notes.pdf` in the folder you just downloaded. You can also download it directly from [this link](https://github.com/seananderson/ggplot2-FISH554/raw/master/ggplot2-notes.pdf).

3. Install the knitr R package: `install.packages("knitr")`

4. Open the file `ggplot2-exercises.Rmd` in RStudio. This is an R Markdown document. See the notes below if you're unfamiliar with R Markdown. The data file `Morph_for_Sato.csv` is in the same folder.

5. Work your way through that file while you read the PDF notes document. When you want to check your work, or if you get really stuck, jump over to [this version](https://github.com/seananderson/ggplot2-FISH554/blob/master/ggplot2-exercises-answers.md) that has the answers.

### Working with R Markdown

You can read more about R Markdown on the RStudio website [here](https://www.rstudio.com/ide/docs/r_markdown) and [here](http://www.rstudio.com/ide/docs/authoring/using_markdown).

The basic idea is to add R code within the code chunks:

    ```{r}
    # Add your code here
    ```

You can then run those code chunks, jump to chunks via the pop up menu in the bottom left of the code window, and "knit" the whole document via the "Knit HTML" button at the top of your code window.

The notes document was [also written with knitr](https://github.com/seananderson/ggplot2-FISH554/blob/master/ggplot2-notes.Rnw), but the LaTeX version.

### Contact

If you have any questions on the notes or exercises, or want to provide feedback, feel free to email me at sean "at" seananderson.ca.

<a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-nc/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc/4.0/deed.en_US">Creative Commons Attribution-NonCommercial 4.0 International License</a>.
