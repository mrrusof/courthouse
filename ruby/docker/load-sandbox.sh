#!/bin/bash

openrc

touch /run/openrc/softlevel

rc-service docker stop
rc-service docker start

echo
echo "Loading sandbox image"
(( tries = 0 ))
while ! docker load --input /sandbox/sandbox.tar && (( tries++ < 10 )); do
    echo -n .
    sleep 1
done

rc-service docker stop

echo
echo "Stopping docker"
(( tries = 0 ))
while docker ps && (( tries ++ < 10 )); do
    echo -n .
    sleep 1
done
