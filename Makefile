TARGETS=doc/pseudo.pdf doc/fig/readmefig.svg

LATEX=latexmk -norc -pdf -auxdir=build -outdir=build
FIGS=build/hilitefig.pdf build/pausefig.pdf build/kwfig.pdf

all: $(TARGETS)

doc/pseudo.pdf: build/pseudo.pdf
	cp $< $@

build/pseudo.pdf: doc/pseudo.tex build/pseudo.bib $(FIGS) README.md pseudo.sty
	$(LATEX) $<

build/pseudo.bib: doc/pseudo.bib
	cp $< $@

build/hilitefig.pdf: doc/fig/hilitefig.tex pseudo.sty
	$(LATEX) $<

build/pausefig.pdf: doc/fig/pausefig.tex pseudo.sty
	$(LATEX) $<

build/kwfig.pdf: doc/fig/kwfig.tex pseudo.sty
	$(LATEX) $<

pseudo.sty:	VERSION LICENSE doc/pseudo.tex
	cat LICENSE | sed -e "s/^/% /" | sed -e "s/^% \$$/%/" > pseudo.sty
	echo "%" >> pseudo.sty
	cat doc/pseudo.tex | sed -n \
		-e "/\begin{source}/,/\end{source}/{" \
		-e "/\\begin{source}/b" \
		-e "/\\end{source}/b" \
		-e "s/_@@/__pseudo/g" \
		-e "s/@@/__pseudo/g" \
		-e "s/VERSION/$$(cat VERSION)/g" \
		-e "s/DATE/$$(date +"%Y-%m-%d")/g" \
		-e "s/[ ]*%.*\$$//" \
		-e "/^\$$/d" \
		-e "p" \
		-e "}" >> pseudo.sty

build/readmecode.tex: doc/fig/readmecode.tex
	cp $< $@

build/readmefig.pdf: doc/fig/readmefig.tex build/readmecode.tex
	$(LATEX) $<

doc/fig/readmefig.svg: build/readmefig.pdf
	pdf2svg $< $@

doc/fig/readmecode.tex: README.md
	cat $< | sed -n -e "/\\begin{pseudo}\\*$$/,/\\end{pseudo}/p" > $@
