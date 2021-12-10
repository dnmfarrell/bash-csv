Bash CSV Parser
---------------
This repo provides a bash library called `csv.bash` which parses lines of comma-delimited-values into an array.

Here's `example/parse-stdin.bash`:

    #!/bin/bash
    source csv.bash                   # load the library
    while IFS= read -r CSV_ROW;do     # read stdin line by line into CSV_ROW
      csv_row_to_cols                 # parse CSV_ROW into CSV_COLS
      printf "%s\n" "${CSV_COLS[@]}"  # do something with CSV_COLS!
    done

It reads a stream of csv input and prints each parsed column on a new line. `csv_row_to_cols` parses the global variable `CSV_ROW` and populates the results in `CSV_COLS` (returning values via globals is necessary in bash).

    echo 'foo,"bar,baz",,"boo\"",' | example/parse-stdin.bash
    foo
    "bar,baz"
    ""
    "boo\""
    ""

This example shows the default behavior, but that can be changed by setting these global variables:

    CSV_TER=""    # terminator for rows
    CSV_DEL=","   # delimiter for columns
    CSV_QUO='"'   # quote char - quoted delimiters are ignored
    CSV_ESC="\\"  # escape char for quote char
    CSV_CON=1     # consecutive delimiters declare empty columns
    CSV_EMP='""'  # empty column replacement value

For example you can set `CSV_DEL` to tab to parse tab-delimited data. Less obviously, you could use `csv.bash` to read command arguments from input and split them into words, instead of using `xargs`, which is slow.

    #/bin/bash
    source csv.bash
    CSV_DEL=" "
    CSV_ROW='foo "bar baz"' # bash will wordsplit like this (foo,"bar,baz")
    csv_row_to_cols         # CSV_COLS=(foo,"bar baz")
    ...

All global variables are prepended with `CSV_` to avoid name clashes with other code. And that's not all the global variables either! `CSV_COLC` is set to the number of columns parsed, which is handy to use as the length of `$CSV_COLS` which bash may not report correctly if it contains empty strings. `CSV_ROWC` is an incrementing row counter, which you may want to reset to 0 if your code is parsing different inputs in the same process.
