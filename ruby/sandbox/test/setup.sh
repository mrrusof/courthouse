PWD=$BATS_TEST_DIRNAME
SCRIPT_DIR=$PWD/../../script
export SANDBOX_TIMEOUT=3
TMP=`mktemp --dry-run`
export SANDBOX_NAME=ruby-sandbox-`basename $TMP`
CID=$SANDBOX_NAME
EC=0

OUT=$(
  <<<'{}' \
  jshon -s "`cat $PWD/program.rb`" -i program \
        -s "`cat $PWD/in`" -i input | \
  $SCRIPT_DIR/run-sandbox.sh
) || EC=$?
