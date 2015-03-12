#!/usr/bin/env perl
### Penn2plain: strips out all treebank annotation
### By Jon Dehdari, 2010
### This file is in the public domain

# For example:
#            (S (NP (N dogs)) (VP (V bark)) (PUNC .))
# Becomes
#            dogs bark .

while (<>) {
  s/\(-NONE- \*\)//g;
  s/\(\S+//g;
  s/[()]//g;
  s/(^| )\*\S+\*(?=$| )/$1/g;
  s/ {2,}/ /g;
  s/^ //g;
  s/ $//g;

  print;
}
