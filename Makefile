# ====== Variables útiles ======
# Indica qué módulo quieres compilar con referencias in-place:
# Uso: make refs MODULE=modulo01
MODULE ?= modulo01
BOOK_DIR := modules/$(MODULE)/book
REPO_ROOT := $(CURDIR)

# ====== Compila libros y Cornell como ya lo tenías ======
build:
	@find modules -type f -name "main.tex" -path "*/book/*" -exec latexmk -pdf -interaction=nonstopmode -halt-on-error -cd {} \;
	@find modules -type f -name "cornell.tex" -path "*/cornell/*" -exec latexmk -pdf -interaction=nonstopmode -halt-on-error -cd {} \;

# ====== Compilar referencias (in-place) ======
# Deja main.pdf en $(BOOK_DIR) SIN crear latex.out
refs:
	@echo ">> Compilando in-place en $(BOOK_DIR) con Biber"
	@cd "$(BOOK_DIR)" && \
	BIBINPUTS="$(REPO_ROOT)/common:" \
	latexmk -pdf -interaction=nonstopmode -halt-on-error \
		-e '$$bibtex_use=2;' \
		-e '$$aux_dir="."; $$out_dir=".";' \
		-e '$$biber=q/biber --input-directory=. --output-directory=. %O %B/;' \
		main.tex

# ====== Limpieza ======
# Limpia artefactos de compilación estándar + latex.out
clean:
	@find modules -regex ".*\(aux\|bbl\|bcf\|blg\|fdb_latexmk\|fls\|log\|out\|run.xml\|synctex.gz\|toc\|lof\|lot\|lol\)" -delete
	@find modules -type d -name "latex.out" -exec rm -rf {} +

# Limpia también artefactos in-place del módulo (por si usaste 'make refs')
clean-refs:
	@echo ">> Limpiando auxiliares in-place en $(BOOK_DIR)"
	@cd "$(BOOK_DIR)" && rm -f \
		main.aux main.bbl main.bcf main.blg main.fdb_latexmk main.fls \
		main.log main.out main.run.xml main.synctex.gz main.toc main.lof main.lot

# ====== Limpieza de carpetas Cornell ======
clean-cornell:
	@echo ">> Limpiando artefactos en carpetas Cornell..."
	# Buscar todas las carpetas /cornell y eliminar todo excepto .tex, .pdf y .sty
	@find modules -type f -path "*/cornell/*" \
		! -name "*.tex" \
		! -name "*.pdf" \
		! -name "*.sty" \
		-delete