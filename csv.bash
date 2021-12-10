#!/bin/bash
CSV_TER=""    # terminator for rows
CSV_DEL=","   # delimiter for columns
CSV_QUO='"'   # quote char - quoted delimiters are ignored
CSV_ESC="\\"  # escape char for quote char
CSV_CON=1     # consecutive delimiters declare empty columns
CSV_EMP='""'  # empty column replacement value

csv_row_to_cols () {
  local len="${#CSV_ROW}" idx=0 cnt=0 word= c=
  (( CSV_ROWC++ ))
  CSV_COLS=()
  CSV_COLC=0
  while (( idx <= len ));do
    c="${CSV_ROW:$idx:1}"
    (( idx++ ))
    if [ $cnt -eq 0 ];then
      if [ "$c" = "$CSV_DEL" ]||[ "$c" = "$CSV_TER" ];then
        if [ -n "$word" ];then
          CSV_COLS+=("$word")
          word=
        elif [ $CSV_CON ];then
          CSV_COLS+=("$CSV_EMP")
        fi
        (( CSV_COLC++ ))
        [ "$c" = "$CSV_TER" ] && break
        continue
      elif [ "$c" = "$CSV_QUO" ];then
        (( cnt++ ))
      fi
    elif [ -z "$c" ];then
      echo "found unterminated string at row $CSV_ROWC, col $idx: '$CSV_ROW'"
      exit 1
    elif [ "$c" = "$CSV_QUO" ];then
      [ "${word: -1}" != "$CSV_ESC" ] && (( cnt-- ))
    fi
    word+="$c"
  done
}
