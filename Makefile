LATEX=latexmk -norc -pdf -auxdir=build -outdir=build
FIGS=build/hilitefig.pdf build/pausefig.pdf

doc/pseudo.pdf: build/pseudo.pdf
	cp $< $@

build/pseudo.pdf: doc/pseudo.tex build/pseudo.bib $(FIGS)
	$(LATEX) $<

build/pseudo.bib: doc/pseudo.bib
	cp $< $@

build/hilitefig.pdf: doc/fig/hilitefig.tex pseudo.sty
	$(LATEX) $<

build/pausefig.pdf: doc/fig/pausefig.tex pseudo.sty
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
