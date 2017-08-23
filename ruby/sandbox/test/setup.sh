BIN_DIR=$BATS_TEST_DIRNAME/../../script/
TIMEOUT=3

CID=`$BIN_DIR/run-sandbox.sh ruby $BATS_TEST_DIRNAME`
$BIN_DIR/wait-w-timeout.sh $CID $TIMEOUT
