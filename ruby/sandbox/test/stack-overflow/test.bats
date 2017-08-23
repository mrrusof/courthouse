function setup {
  source $BATS_TEST_DIRNAME/../setup.sh
}

function teardown {
  source $BATS_TEST_DIRNAME/../teardown.sh
}

@test "stack-overflow: There are 3 or more lines of output." {
  r=$(docker logs $CID | wc -l)
  [ "$r" -ge 3 ]
}

@test "stack-overflow: First line of output is exit code 1." {
  r=$(docker logs $CID | head -n 1)
  [ "$r" = 1 ]
}

@test "stack-overflow: Second line of output is time." {
  r=$(docker logs $CID | head -n 2 | tail -n 1)
  grep '^[0-9]:[0-9][0-9]\.[0-9][0-9]$' <<<"$r"
}

@test "stack-overflow: Third line of output is stack overflow error." {
  r=$(docker logs $CID | head -n 3 | tail -n 1)
  e="/input/main.rb:2:in \`this_wont_end_well': stack level too deep (SystemStackError)"
  [ "$r" = "$e" ]
}
