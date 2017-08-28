function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "stack-overflow: Output is JSON object with 3 pairs." {
  r=$(echo $OUT | jshon -l)
  [ "$r" -ge 3 ]
}

@test "stack-overflow: Exit code is 1." {
  r=$(echo $OUT | jshon -e exitCode)
  [ "$r" = 1 ]
}

@test "stack-overflow: Wall time has right format." {
  r=$(echo $OUT | jshon -e wallTime -u)
  grep '^[0-9]:[0-9][0-9]\.[0-9][0-9]$' <<<"$r"
}

@test "stack-overflow: Actual output is expected output." {
  r=$(echo $OUT | jshon -e actualOutput -u | head -n 1)
  e="/tmp/program.rb:2:in \`this_wont_end_well': stack level too deep (SystemStackError)"
  [ "$r" = "$e" ]
}

@test "stack-overflow: Sandbox is not running after run-sandbox.sh exits." {
  ! docker ps | grep $CID
}
