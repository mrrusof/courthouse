#!/bin/bash

# Get rid of that 'sudo: unable to resolve host XXXX' bullshit
echo "127.0.0.1 `cat /etc/hostname`" >/etc/hosts

function unescape-json-string {
    jshon -0 -e $1 -u | tr -d '\0'
}

if [ -z "$INTERPRETER" -a -z "$COMPILE" ]; then
  INTERPRETER='echo Neither interpreter nor compiler set for sandbox.'
fi
RAW=/tmp/input.json
SRC=/tmp/program
INP=/tmp/input
ACT=/tmp/act
TIM=/tmp/time

cat >$RAW

unescape-json-string program <$RAW >$SRC
unescape-json-string input <$RAW >$INP

cd /tmp # Move to workspace

if [ -n "$INTERPRETER" ]; then

    sudo --host=127.0.0.1 --user=sandbox \
        /usr/bin/time --verbose -o $TIM $INTERPRETER $SRC <$INP >$ACT 2>&1
    EC=$?

else

    sudo --host=127.0.0.1 --user=sandbox \
        /usr/bin/time --verbose -o $TIM bash -c "export SRC=$SRC; $COMPILE" >$ACT 2>&1 \
    && \
    sudo --host=127.0.0.1 --user=sandbox \
        /usr/bin/time --verbose -o $TIM $MAIN <$INP >$ACT 2>&1
    EC=$?

fi

# Do the following backflip to preserve trailing newlines
IFS= read -rd '' ACT < <(cat $ACT)

<<<'{}' \
jshon -n "$EC" -i exitCode \
      -s "`grep 'wall clock' $TIM | sed 's/.*: //'`" -i wallTime \
      -s "$ACT" -i actualOutput
