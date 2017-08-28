#!/bin/bash

JUDGE=ruby
TIMEOUT=${SANDBOX_TIMEOUT:-10}
NAME=${SANDBOX_NAME:-$JUDGE-sandbox}

timeout --preserve-status \
        --kill-after=0 \
        --signal=9 \
        $TIMEOUT \
docker run \
        --interactive \
        --memory=100m \
        --oom-kill-disable \
        --cpus=0.75 \
        --network=none \
        --name $NAME \
        $JUDGE-sandbox
