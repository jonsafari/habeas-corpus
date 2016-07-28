#!/bin/sh
## By Jon Dehdari, 2014
## Gets a vocabulary (set of unique words) from a text in STDIN
## Usage: ./vocab.sh < corpus.txt > vocab.txt

## Instead of using tr, you could use perl -p -e 's/\s+/\n/g'
tr ' ' '\n' |\
	tr '\t' '\n' |\
	LANG=C sort --buffer-size=4000M --temporary-directory=./  |\
	uniq |\
	sed '/^$/d' # We don't need an empty line
