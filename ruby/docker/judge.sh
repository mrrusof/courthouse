#!/bin/bash

# Environment
export SANDBOX_TIMEOUT=${JUDGE_TIMEOUT:-10}

# Functions

function unescape-json-string {
    jshon -0 -e $1 -u | tr -d '\0';
}

# Constants
JUDGE=ruby
RAW=/tmp/input.json
SAN=/tmp/sandbox.json
ACT=/tmp/act
EXP=/tmp/exp
DIFF=/tmp/act-exp.diff
TMP=`mktemp --dry-run`
export SANDBOX_NAME=$JUDGE-sandbox-`basename $TMP`

cat >$RAW
unescape-json-string output <$RAW >$EXP

/judge/run-sandbox.sh <$RAW >$SAN 2>/dev/null

if [ "$?" = 137 ]; then
    echo '{ "ruling":"TIMEOUT", "time":"'$SANDBOX_TIMEOUT'" }'
else
    exit_code=`jshon -e exitCode <$SAN`
    if [ "$exit_code" = 0 ]; then
        unescape-json-string actualOutput <$SAN >$ACT
        if diff $ACT $EXP >$DIFF 2>&1; then
            echo -n '{ "ruling":"ACCEPTED"'
        else
            diff=`jshon -s "$(cat $DIFF)" <<<'{}'`
            echo -n '{ "ruling":"WRONG_ANSWER", "diff":'$diff
        fi
    else
        echo -n '{ "ruling":"RUNTIME_ERROR", "exitCode":'$exit_code
    fi
    wall_time=`jshon -e wallTime <$SAN`
    actual=`jshon -e actualOutput <$SAN`
    echo ', "wallTime":'$wall_time', "actual":'$actual' }'
fi

/judge/remove-sandbox.sh >/dev/null
