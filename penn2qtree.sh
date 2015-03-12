perl -p -e '
    s/\(/ [./g;
    s/\)/ ] /g;
    s/\n/ /g;
  ' $*
