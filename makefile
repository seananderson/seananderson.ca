all:	server-auto

cv:
	tail +8 cv.md > cv-body.md
	pandoc -S cv-body.md -o cv-body.tex
	perl -p -i -e "s/~/\\\ /g" cv-body.tex
	perl -p -i -e "s/M.Sc./M.Sc.\\\/g" cv-body.tex 
	perl -p -i -e "s/B.Sc./B.Sc.\\\/g" cv-body.tex
	latexmk AndersonCV.tex
	cat cv-header.txt cv.md > AndersonCV-temp.txt
	sed '/<br \/>/d' AndersonCV-temp.txt > AndersonCV.txt # remove HTML line breaks
	rm AndersonCV-temp.txt # cleanup
	rm cv-body.md # cleanup
	rm cv-body.tex # cleanup
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

