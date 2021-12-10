#!/bin/bash
source csv.bash
while IFS= read -r CSV_ROW;do
  csv_row_to_cols
  printf "%s\n" "${CSV_COLS[@]}"
done
