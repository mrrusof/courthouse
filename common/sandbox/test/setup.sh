PWD=$BATS_TEST_DIRNAME
source $PWD/../../../../common/test/helpers.sh
SCRIPT_DIR=$PWD/../../../../judge/docker
SANDBOX_TIMEOUT=${SANDBOX_TIMEOUT:-2}
TMP=`mktemp --dry-run`
SANDBOX_NAME=$JUDGE-sandbox-`basename $TMP`
CID=$SANDBOX_NAME
EC=0

export SANDBOX_NAME # for teardown.sh

verbatim-file-into-var $PWD/program program
verbatim-file-into-var $PWD/in input

OUT=$(
  <<<'{}' \
  jshon -s "$program" -i program \
        -s "$input" -i input | \
  JUDGE=$JUDGE \
  SANDBOX_TIMEOUT=$SANDBOX_TIMEOUT \
  SANDBOX_NAME=$SANDBOX_NAME \
  $SCRIPT_DIR/run-sandbox.sh
) || EC=$?

echo -e "OUT: $OUT"
