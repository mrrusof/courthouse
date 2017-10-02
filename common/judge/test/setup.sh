PWD=$BATS_TEST_DIRNAME
source $PWD/../../../../common/test/helpers.sh
SCRIPT_DIR=$PWD/../../../../judge/script
JUDGE_TIMEOUT=2

verbatim-file-into-var $PWD/in tc_in
verbatim-file-into-var $PWD/out tc_out
verbatim-file-into-var $PWD/program program

OUT=$(
  <<<'{}' \
  jshon -s "$program" -i program \
        -s "$tc_in" -i input \
        -s "$tc_out" -i output | \
  JUDGE=$JUDGE \
  JUDGE_TIMEOUT=$JUDGE_TIMEOUT \
  $SCRIPT_DIR/run-judge.sh
)
