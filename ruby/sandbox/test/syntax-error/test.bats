function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "syntax-error: Output is JSON object with 3 pairs." {
  r=$(echo $OUT | jshon -l)
  [ "$r" = 3 ]
}

@test "syntax-error: Exit code is 1." {
  r=$(echo $OUT | jshon -e exitCode)
  [ "$r" = 1 ]
}

@test "syntax-error: Wall time has right format." {
  r=$(echo $OUT | jshon -e wallTime -u)
  grep '^[0-9]:[0-9][0-9]\.[0-9][0-9]$' <<<"$r"
}

@test "syntax-error: Actual output is expected output." {
  r="$(echo $OUT | jshon -e actualOutput -u)"
  e="/tmp/program.rb:1:in \`<main>': undefined local variable or method \`bla' for main:Object (NameError)"
  [ "$r" = "$e" ]
}

@test "syntax-error: Sandbox is not running after run-sandbox.sh exits." {
  ! docker ps | grep $CID
}
