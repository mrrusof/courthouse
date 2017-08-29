function setup {
    source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
    source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "three-part-output: Output is JSON object with 3 pairs." {
    r=$(echo $OUT | jshon -l)
    [ "$r" = 3 ]
}

@test "three-part-output: Exit code is 0." {
    r=$(echo $OUT | jshon -e exitCode)
    [ "$r" = 0 ]
}

@test "three-part-output: Wall time has right format." {
    r=$(echo $OUT | jshon -e wallTime -u)
    grep '^[0-9]:[0-9][0-9]\.[0-9][0-9]$' <<<"$r"
}

@test "three-part-output: Actual output is expected output." {
    r="$(echo "$OUT" | jshon -e actualOutput)"
    e="\"this is line 1\nthis is line 2\n\""
    [ "$r" = "$e" ]
}

@test "three-part-output: Sandbox is not running after run-sandbox.sh exits." {
  ! docker ps | grep $CID
}
