# Monorepo LaTeX — Ejemplo

Estructura base para un diplomado con **libro LaTeX** por módulo y **apuntes en formato Cornell**.
Incluye:

- `modules/modulo01/book/`: libro de ejemplo (`main.tex`) con figuras locales.
- `modules/modulo01/cornell/`: plantilla simple de Cornell (`cornell.tex` + `cornell.sty`).
- `common/preamble.tex`: paquetes y configuración compartida.
- `Makefile`: comandos para compilar todos los documentos.
- `latexmkrc` local en cada carpeta para sacar artefactos a `latex.out/`.
- `.gitignore` y `.gitattributes` (Git LFS para originales si lo habilitas).
- CI de GitHub Actions para compilar con TeX Live (opcional).

## Cómo usar

```bash
# Compilar todo
make build

# Limpiar artefactos generados
make clean
```

> Sugerencia: usa `git lfs install` si vas a guardar originales pesados en `assets_originals/`.