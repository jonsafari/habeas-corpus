#!/bin/sh
### Converts Penn treebank format to POS-tagged CoNLL-X format
### By Jon Dehdari, 2010
### This file is in the public domain
### You may want to delete empty nodes afterwards, piping the output to  grep -v 'NONE.$'

### From:
# (S (NP (N dogs))(VP (V run)))
### To:
# dogs N
# run  V

sed 's/$/_NL_/g' |
pcregrep -o '(?:\([^()]+\)|_NL_)' |
perl -p -e '
    s/_NL_//g;
    s/^\((\S+) (\S+)\)$/$2\t$1/g;
'
