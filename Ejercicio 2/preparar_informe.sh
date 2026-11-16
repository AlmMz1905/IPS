#!/bin/sh
set -eu

if [ "$#" -gt 1 ]; then
    printf 'Uso: %s [PAGINA_INICIAL_RESOLUCION]\n' "$0" >&2
    exit 2
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
assignment_pdf="$script_dir/../Material/PU1.pdf"
solution_pdf="$script_dir/Ejercicio2_resolucion.pdf"
output_pdf="$script_dir/Ejercicio2.pdf"
start_page=${1:-5}

case "$start_page" in
    ''|*[!0-9]*)
        printf 'La página inicial debe ser un entero positivo.\n' >&2
        exit 2
        ;;
esac

assignment_pages=$(pdfinfo "$assignment_pdf" | awk '$1 == "Pages:" { print $2; exit }')
case "$assignment_pages" in
    ''|*[!0-9]*)
        printf 'No se pudo determinar la cantidad de páginas de las consignas.\n' >&2
        exit 2
        ;;
esac

temp_dir=$(mktemp -d)
trap 'rm -rf "$temp_dir"' EXIT HUP INT TERM
pdfseparate -f "$assignment_pages" -l "$assignment_pages" \
    "$assignment_pdf" "$temp_dir/consigna-%d.pdf"
prompt_page="$temp_dir/consigna-$assignment_pages.pdf"

(
    cd "$script_dir"
    pdflatex -interaction=nonstopmode -halt-on-error -jobname=Ejercicio2_resolucion \
        "\\def\\ReportStartingPage{$start_page}\\input{Ejercicio2.ltx}"
    pdflatex -interaction=nonstopmode -halt-on-error -jobname=Ejercicio2_resolucion \
        "\\def\\ReportStartingPage{$start_page}\\input{Ejercicio2.ltx}"
)

pdfunite "$prompt_page" "$solution_pdf" "$output_pdf"
printf 'Informe individual preparado: %s\n' "$output_pdf"
printf 'La resolución comienza en la página impresa %s.\n' "$start_page"
