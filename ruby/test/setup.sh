PWD=$BATS_TEST_DIRNAME
SCRIPT_DIR=$PWD/../../script
export JUDGE_TIMEOUT=2

OUT=$(
  <<<'{}' \
  jshon -s "`cat $PWD/program.rb`" -i program \
        -s "`cat $PWD/in`" -i input \
        -s "`cat $PWD/out`" -i output | \
  $SCRIPT_DIR/ruby-judge.sh
)
