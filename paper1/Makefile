name = paper1
blddir = _build

all: $(name).pdf

%.pdf: %.tex | $(blddir)
	@latexmk -halt-on-error -pdf -jobname=$(blddir)/$* $<
	@mv $(blddir)/$@ .

$(blddir):
	@mkdir $(blddir)

clean:
	rm -r $(blddir)

view:
	open -a Skim $(name).pdf
