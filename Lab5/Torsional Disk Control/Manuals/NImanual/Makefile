FILENAME=LVmanual

TEX=${BIN}/latex
PDFTEX=pdflatex
BIBTEX=bibtex
VIEWER=xpdf
EMACS=xemacs -geometry 100x50

default: pdf

pdftex::  
	$(PDFTEX) $(FILENAME).tex

bib::
	  $(BIBTEX) $(FILENAME)

pdf::
	make pdftex
	make bib
	make pdftex
	make pdftex
	make pdftex

clean:
	rm -f *.aux *.bbl *.blg *.log *.out *.toc

view::
	$(VIEWER) $(FILENAME).pdf &

editsmall::
	$(EMACS)  -geometry 100x50 $(FILENAME).tex &
	$(VIEWER) $(FILENAME).pdf &

editbig::
	$(EMACS)  -geometry 100x120 $(FILENAME).tex &
	$(VIEWER) $(FILENAME).pdf &
