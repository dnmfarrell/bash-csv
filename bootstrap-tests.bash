#!/bin/bash
source csv.bash
TEST_COUNT=0
TEST_FAIL_COUNT=0

function ok {
  (( TEST_COUNT++ ))
  if [[ "$1" != 1 ]];then
    (( TEST_FAIL_COUNT++ ))
    echo -n "not "
  fi
  echo "ok $TEST_COUNT $2"
}

function pass {
  (( TEST_COUNT++ ))
  echo "ok $TEST_COUNT $1"
}

function fail {
  (( TEST_COUNT++ ))
  (( TEST_FAIL_COUNT++ ))
  echo "not ok $TEST_COUNT $1"
}

function skip {
  pass "# SKIP $1"
}

function todo {
  (( TEST_COUNT++ ))
  echo "not ok $TEST_COUNT # TODO $1"
}

function end {
  echo "1..$TEST_COUNT"
  exit "$TEST_FAIL_COUNT"
}
