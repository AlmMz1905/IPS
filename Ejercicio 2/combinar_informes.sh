#!/bin/sh
set -eu

if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    printf 'Uso: %s INFORME_PREVIO.pdf [INFORME_COMPLETO.pdf]\n' "$0" >&2
    exit 2
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
previous_pdf=$(realpath "$1")
output_pdf=$(realpath -m "${2:-"$script_dir/InformeCompleto.pdf"}")
exercise_pdf="$script_dir/Ejercicio2.pdf"

if [ "$output_pdf" = "$previous_pdf" ] || [ "$output_pdf" = "$exercise_pdf" ]; then
    printf 'La salida no puede sobrescribir uno de los PDF de entrada.\n' >&2
    exit 2
fi

previous_pages=$(pdfinfo "$previous_pdf" | awk '$1 == "Pages:" { print $2; exit }')
case "$previous_pages" in
    ''|*[!0-9]*)
        printf 'No se pudo determinar la cantidad de páginas del PDF previo.\n' >&2
        exit 2
        ;;
esac

start_page=$((previous_pages + 2))

"$script_dir/preparar_informe.sh" "$start_page"

mkdir -p "$(dirname -- "$output_pdf")"
pdfunite "$previous_pdf" "$exercise_pdf" "$output_pdf"
printf 'Informe combinado: %s\n' "$output_pdf"
printf 'La resolución comienza en la página %s.\n' "$start_page"