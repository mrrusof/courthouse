PWD=$BATS_TEST_DIRNAME
source $PWD/../../../../test/helpers.sh
SCRIPT_DIR=$PWD/../../script
export SANDBOX_TIMEOUT=2
TMP=`mktemp --dry-run`
export SANDBOX_NAME=ruby-sandbox-`basename $TMP`
CID=$SANDBOX_NAME
EC=0

verbatim-file-into-var $PWD/program.rb program
verbatim-file-into-var $PWD/in input

OUT=$(
  <<<'{}' \
  jshon -s "$program" -i program \
        -s "$input" -i input | \
  $SCRIPT_DIR/run-sandbox.sh
) || EC=$?
