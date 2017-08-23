#!/bin/bash

CID="$1"
TIMEOUT="$2"

# You would think that a better alternative to `docker stop --time $TIMEOUT` is
# `docker run --stop-timeout $TIMEOUT`, but in our experience option
# `--stop-timeout` does not work.
docker stop --time $TIMEOUT $CID

# Exit code 137 means that a given process was killed.
# See http://www.tldp.org/LDP/abs/html/exitcodes.html.
#
# We asume that when the process of our container reports 137, the reason is
# that we killed it upon timeout.  For this reason we return exit code 1
# when container reports exit code 137.
! docker inspect $CID | grep '"ExitCode": 137' >/dev/null 2>&1
