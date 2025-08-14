# Compila libros y apuntes Cornell
build:
	@find modules -type f -name "main.tex" -path "*/book/*" -exec latexmk -pdf -interaction=nonstopmode -halt-on-error -cd {} \;
	@find modules -type f -name "cornell.tex" -path "*/cornell/*" -exec latexmk -pdf -interaction=nonstopmode -halt-on-error -cd {} \;

clean:
	@find modules -regex ".*\(aux\|bbl\|bcf\|blg\|fdb_latexmk\|fls\|log\|out\|run.xml\|synctex.gz\|toc\|lof\|lot\)" -delete
	@find modules -type d -name "latex.out" -exec rm -rf {} +
