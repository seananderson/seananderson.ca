all:	cv

cv:
	tail +7 cv-pandoc.md > cv-body.md
	pandoc cv-body.md -o cv-body.tex
	perl -p -i -e "s/~/\\\ /g" cv-body.tex
	perl -p -i -e "s/M.Sc./M.Sc.\\\/g" cv-body.tex
	perl -p -i -e "s/B.Sc./B.Sc.\\\/g" cv-body.tex
	# perl -p -i -e "s/itemsep1pt/itemsep3pt/g" cv-body.tex
	# Rscript -e "tinytex::latexmk('AndersonCV.tex')"
	latexmk -pdf AndersonCV.tex
	# Rscript -e "tinytex::latexmk('AndersonCV.tex')"
	pandoc cv-body.md -o cv-body-clean.md
	cat cv-header.txt cv-body-clean.md > AndersonCV.txt
	perl -p -i -e "s/–/--/g" AndersonCV.txt
	rm cv-body.md
	# rm cv-body.tex
	rm cv-body-clean.md
	rm *.log *.out *.aux *.fdb_latexmk *.fls
	# and pre-process the HTML with pandoc
	# because redcarpet markdown doesn't do definition lists
	pandoc cv-pandoc.md -o cv-temp.html
	cat cv-pandoc-header.md cv-temp.html > cv.html
	rm cv-temp.html
	cp AndersonCV.pdf ~/Dropbox/CV/anderson-cv.pdf
	cp AndersonCV.txt ../content/anderson-cv.txt
	cp cv.html ../content/cv.html

cleanbib:
	bibtool refs.bib -s > refs2.bib
	mv refs2.bib refs.bib
