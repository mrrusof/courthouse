#!/bin/bash

DIR=$1
CMD=$2
BAS=$(basename $DIR)
COD=${BAS:0:2}
OUT=/tmp/test.out
case "$COD" in
    ac) EXP=ACCEPTED;;
    wa) EXP=WRONG_ANSWER;;
    to) EXP=TIMEOUT;;
    re) EXP=RUNTIME_ERROR;;
esac

export JUDGE_TIMEOUT=2
export JUDGE_WORKDIR=$DIR

echo -n "$BAS ... "

if (source $CMD | grep $EXP) >$OUT 2>&1; then
    echo PASS
else
    echo FAIL
    cat $OUT
    exit 1
fi
