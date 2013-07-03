all:	server-auto

cv:
	tail +12 cv.md > cv-body.md
	pandoc -S cv-body.md -o cv-body.tex
	perl -p -i -e "s/~/\\\ /g" cv-body.tex
	perl -p -i -e "s/M.Sc./M.Sc.\\\/g" cv-body.tex 
	perl -p -i -e "s/B.Sc./B.Sc.\\\/g" cv-body.tex
	latexmk AndersonCV.tex
	pandoc cv-body.md -o cv-body-clean.md
	cat cv-header.txt cv-body-clean.md > AndersonCV.txt
	rm cv-body.md # cleanup
	rm cv-body.tex # cleanup
	rm cv-body-clean.md # cleanup
	rm *.log *.out *.aux *.fdb_latexmk *.fls # cleanup TeX

server:
	jekyll --server

server-auto:
	jekyll --server --auto

local:
	jekyll

remote:
	jekyll
	./syncjekyll

