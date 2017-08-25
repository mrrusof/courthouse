#!/bin/bash

# Environment
JUDGE_TIMEOUT=${JUDGE_TIMEOUT:-10}

# Functions

function jsonify {
    python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'
}

function nth-line {
    head -n $1 | tail -n 1
}

function dl {
    docker logs $1
}

# Constants
JUDGE=ruby
ACT=`mktemp`
EXP=/input/out
DIFF=/tmp/$JUDGE-judge.diff

CID=`/judge/run-sandbox.sh $JUDGE $SANDBOX_INPUT_DIR` 2>/dev/null

if ! /judge/wait-w-timeout.sh $CID $JUDGE_TIMEOUT >/dev/null 2>&1; then
    echo '{ "ruling":"TIMEOUT", "time":"'$JUDGE_TIMEOUT'" }'
else
    exit_code=`dl $CID | nth-line 1`
    time=`dl $CID | nth-line 2`
    dl $CID | tail -n +3 >$ACT
    actual=`cat $ACT | jsonify`
    if [ "$exit_code" = 0 ]; then
        if diff $ACT $EXP >$DIFF 2>&1; then
            echo -n '{ "ruling":"ACCEPTED", "time":"'
        else
            diff=`cat $DIFF | jsonify`
            echo -n '{ "ruling":"WRONG_ANSWER", "diff":'$diff', "time":"'
        fi
    else
        echo -n '{ "ruling":"RUNTIME_ERROR", "exitCode":"'$exit_code'", "time":"'
    fi
    echo $time'", "actual":'$actual' }'
fi

docker rm --force --volumes $CID >/dev/null
