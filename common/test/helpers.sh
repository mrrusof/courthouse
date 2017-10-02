function verbatim-file-into-var {
  # read returns exit code 1 when it hits \0, thus the disjunction
  IFS= read -rd '' $2 < <(cat $1) || true;
}
