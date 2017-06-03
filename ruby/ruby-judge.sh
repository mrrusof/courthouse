#!/bin/bash

# Environment
JUDGE_WORKDIR=${JUDGE_WORKDIR:-`pwd`}
JUDGE_TIMEOUT=${JUDGE_TIMEOUT:-10}

# Constants
JUDGE=ruby
CID=/tmp/$JUDGE-judge.cid
COUT=/tmp/$JUDGE-judge.out
ACT=/tmp/$JUDGE-judge.act
EXP=$JUDGE_WORKDIR/out
DIFF=/tmp/$JUDGE-judge.diff

docker run \
       -d \
       --memory=100m \
       --cpus=0.5 \
       --network=none \
       -v $JUDGE_WORKDIR:/run/judge:ro \
       $JUDGE-judge \
       >$CID

wait=$(docker inspect `cat $CID` | grep --silent 'Running.*false'; echo $?)
(( stop = `date "+%s"` + JUDGE_TIMEOUT ))
while (( `date "+%s"` < stop && $wait )); do
    sleep 0.125
    wait=$(docker inspect `cat $CID` | grep --silent 'Running.*false'; echo $?)
done

if (( $wait )); then
    echo '{ "verdict":"TIMEOUT", "time":"'$JUDGE_TIMEOUT'" }'
else
    docker logs `cat $CID` >$COUT
    exit_code=`head -n 1 $COUT`
    time=`head -n 2 $COUT | tail -n 1`
    tail -n +3 $COUT >$ACT
    actual=`cat $ACT | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'`
    if [ "$exit_code" = 0 ]; then
        if diff $ACT $EXP >$DIFF 2>&1; then
            echo -n '{ "verdict":"ACCEPTED", "time":"'
        else
            diff=`cat $DIFF | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))'`
            echo -n '{ "verdict":"WRONG_ANSWER", "diff":'$diff', "time":"'
        fi
    else
        echo -n '{ "verdict":"RUNTIME_ERROR", "time":"'
    fi
    echo $time'", "actual":'$actual' }'
fi

docker rm --force `cat $CID` >/dev/null
