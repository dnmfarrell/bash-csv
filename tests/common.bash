#!/bin/bash
source "bootstrap-tests.bash"
test_name="common cases"

CSV_ROW='foo,,"bar,baz","ab\"c",,'
csv_row_to_cols
if [ $CSV_COLC -eq 6 ];then
 pass "$test_name count"
else
 fail "$test_name count got '$CSV_COLC'"
fi
col=0
if [ "${CSV_COLS[$col]}" = 'foo' ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${CSV_COLS[$col]}'"
fi
col=1
if [ "${CSV_COLS[$col]}" = "$CSV_EMP" ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${CSV_COLS[$col]}'"
fi
col=2
if [ "${CSV_COLS[$col]}" = '"bar,baz"' ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${CSV_COLS[$col]}'"
fi
col=3
if [ "${CSV_COLS[$col]}" = '"ab\"c"' ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${CSV_COLS[$col]}'"
fi
col=4
if [ "${CSV_COLS[$col]}" = "$CSV_EMP" ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${CSV_COLS[$col]}'"
fi

col=5
if [ "${CSV_COLS[$col]}" = "$CSV_EMP" ];then
  pass "$test_name col $col"
else
  fail "$test_name col $col got '${CSV_COLS[$col]}'"
fi

end
