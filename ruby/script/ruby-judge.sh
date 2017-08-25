#!/bin/bash

# Environment
JUDGE_INPUT_DIR=${JUDGE_INPUT_DIR:-`pwd`}
JUDGE_TIMEOUT=${JUDGE_TIMEOUT:-10}

CID=`docker run \
       -d \
       -v /var/run/docker.sock:/var/run/docker.sock \
       -v $JUDGE_INPUT_DIR:/input:ro \
       --env JUDGE_TIMEOUT=$JUDGE_TIMEOUT \
       --env SANDBOX_INPUT_DIR=$JUDGE_INPUT_DIR \
       ruby-judge`

docker logs --follow $CID
docker rm --force --volumes $CID >/dev/null
