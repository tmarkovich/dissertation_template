name = dissertation
blddir = _build

all: $(name).pdf

%.pdf: %.tex | $(blddir)
	@latexmk -halt-on-error -bibtex -pdf -jobname=$(blddir)/$* $<
	@mv $(blddir)/$@ .

$(blddir):
	@mkdir $(blddir)

clean:
	rm -r $(blddir)
	rm $(name).pdf

view:
	open -a Skim $(name).pdf
