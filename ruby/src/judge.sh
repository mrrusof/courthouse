#!/bin/bash

INP=/run/judge/in
EXP=/run/judge/out
ACT=/tmp/act
ERR=/tmp/err

TIME=/tmp/time
DIFF=/tmp/diff

TIMEOUT=${1:-30}
SIGNAL=9
TIMEOUT_EXIT_CODE=137

if /usr/bin/time --verbose timeout --signal=$SIGNAL $TIMEOUT bash -c "ruby /run/judge/main.rb <$INP >$ACT 2>$ERR" 2>$TIME; then
    if diff $ACT $EXP >>$DIFF 2>&1; then
        cat $TIME
        echo ACCEPTED
    else
        cat $TIME
        cat $DIFF
        echo WRONG_ANSWER
    fi
else
    if [ "$?" = $TIMEOUT_EXIT_CODE ]; then
        cat $TIME
        echo TIMEOUT
    else
        cat $TIME
        cat $ERR
        echo RUNTIME_ERROR
    fi
fi

