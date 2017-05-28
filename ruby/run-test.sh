#!/bin/bash

DIR=$1
CMD=$2
BAS=$(basename $DIR)
COD=${BAS:0:2}
case "$COD" in
    ac) EXP=ACCEPTED;;
    wa) EXP=WRONG_ANSWER;;
    to) EXP=TIMEOUT;;
    re) EXP=RUNTIME_ERROR;;
esac

cd $DIR

echo -n "$BAS ... "

if (source $CMD | grep $EXP) >/dev/null 2>&1; then
    echo PASS
else
    echo FAIL
fi
