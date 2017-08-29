#!/bin/bash

# Get rid of that 'sudo: unable to resolve host XXXX' bullshit
echo "127.0.0.1 `cat /etc/hostname`" >/etc/hosts

function unescape-json-string {
    jshon -0 -e $1 -u | tr -d '\0'
}

RAW=/tmp/input.json
SRC=/tmp/program.rb
INP=/tmp/input
ACT=/tmp/act
TIM=/tmp/time

cat >$RAW

unescape-json-string program <$RAW >$SRC
unescape-json-string input <$RAW >$INP

sudo --host=127.0.0.1 --user=sandbox \
    /usr/bin/time --verbose -o $TIM ruby $SRC <$INP >$ACT 2>&1
EC=$?

# Do the following backflip to preserve trailing newlines
IFS= read -rd '' ACT < <(cat $ACT)

<<<'{}' \
jshon -n "$EC" -i exitCode \
      -s "`grep 'wall clock' $TIM | sed 's/.*: //'`" -i wallTime \
      -s "$ACT" -i actualOutput
