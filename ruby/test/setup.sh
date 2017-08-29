PWD=$BATS_TEST_DIRNAME
source $PWD/../../../test/helpers.sh
SCRIPT_DIR=$PWD/../../script
export JUDGE_TIMEOUT=2

verbatim-file-into-var $PWD/in tc_in
verbatim-file-into-var $PWD/out tc_out
verbatim-file-into-var $PWD/program.rb program

OUT=$(
  <<<'{}' \
  jshon -s "$program" -i program \
        -s "$tc_in" -i input \
        -s "$tc_out" -i output | \
  $SCRIPT_DIR/ruby-judge.sh
)
