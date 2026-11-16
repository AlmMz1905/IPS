#!/bin/sh
set -eu

if [ "$#" -gt 1 ]; then
    printf 'Uso: %s [PAGINA_INICIAL_RESOLUCION]\n' "$0" >&2
    exit 2
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
assignment_pdf="$script_dir/../Material/PU1.pdf"
prompt_pdf="$script_dir/consigna_con_cabecera.pdf"
solution_pdf="$script_dir/Ejercicio2_resolucion.pdf"
output_pdf="$script_dir/Ejercicio2.pdf"
start_page=${1:-20}
prompt_printed_page=$((start_page - 1))

case "$start_page" in
    ''|*[!0-9]*)
        printf 'La página inicial debe ser un entero positivo.\n' >&2
        exit 2
        ;;
esac

prompt_page_number=$(pdfinfo "$assignment_pdf" | awk '$1 == "Pages:" { print $2; exit }')
case "$prompt_page_number" in
    ''|*[!0-9]*)
        printf 'No se pudo determinar la cantidad de páginas de las consignas.\n' >&2
        exit 2
        ;;
esac

(
    cd "$script_dir"
    pdflatex -interaction=nonstopmode -halt-on-error -jobname=consigna_con_cabecera \
        "\\def\\PromptPage{$prompt_page_number}\\def\\PromptPrintedPage{$prompt_printed_page}\\input{consigna_con_cabecera.tex}"
    pdflatex -interaction=nonstopmode -halt-on-error -jobname=Ejercicio2_resolucion \
        "\\def\\ReportStartingPage{$start_page}\\input{Ejercicio2.ltx}"
    pdflatex -interaction=nonstopmode -halt-on-error -jobname=Ejercicio2_resolucion \
        "\\def\\ReportStartingPage{$start_page}\\input{Ejercicio2.ltx}"
)

pdfunite "$prompt_pdf" "$solution_pdf" "$output_pdf"
printf 'Informe individual preparado: %s\n' "$output_pdf"
printf 'La resolución comienza en la página impresa %s y las figuras desde la 14.\n' "$start_page"
