all: ggplot2-exercises-answers.html \
	index.html

index.html: index.Rmd
	Rscript -e "rmarkdown::render('index.Rmd')"

ggplot2-notes.pdf: ggplot2-notes.Rnw
	Rscript -e "rmarkdown::render('ggplot2-notes.Rnw')"

ggplot2-exercises-answers.html: ggplot2-exercises-answers.Rmd
	Rscript -e "rmarkdown::render('ggplot2-exercises-answers.Rmd', 'knitrBootstrap::bootstrap_document')"

