function setup {
    source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "three-part-output: There are 3 lines of output." {
    r=$(docker logs $CID | wc -l)
    [ "$r" = 3 ]
}

@test "three-part-output: First line of output is exit code 0." {
    r=$(docker logs $CID | head -n 1)
    [ "$r" = 0 ]
}

@test "three-part-output: Second line of output is time." {
    r=$(docker logs $CID | head -n 2 | tail -n 1)
    grep '^[0-9]:[0-9][0-9]\.[0-9][0-9]$' <<<"$r"
}

@test "three-part-output: Third line of output is output of input program." {
    r=$(docker logs $CID | tail -n 1)
    [ "$r" = 'this is the output' ]
}
