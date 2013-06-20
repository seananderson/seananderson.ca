all:	server

cv:
	tail +20 index.md > cv.md
	pandoc -S cv.md -o cv-body.tex
	perl -p -i -e "s/~/\\\ /g" cv-body.tex
	perl -p -i -e "s/M.Sc./M.Sc.\\\/g" cv-body.tex 
	perl -p -i -e "s/B.Sc./B.Sc.\\\/g" cv-body.tex
	latexmk AndersonCV.tex
	cat cv-header.txt cv.md > AndersonCV-temp.txt
	sed '/<br \/>/d' AndersonCV-temp.txt > AndersonCV.txt # remove HTML line breaks
	rm cv.md # cleanup
	rm AndersonCV-temp.txt # cleanup

server:
	jekyll --server

local:
	jekyll

remote:
	jekyll
	./syncjekyll

clean:
	rm -rf *.log *.bbl *.blg *.out *.toc *.aux *.fdb_latexmk *.fls

