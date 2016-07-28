#!/bin/sh
# By Jon Dehdari, 2016
# Gets a top-n frequency-sorted vocabulary from a text in STDIN
# Usage: ./vocab_top.sh [n] < corpus.txt > vocab.txt

# Set default to 100k if user doesn't specify as a command-line argument
n=${1:-100000}

# Instead of using tr, you could use perl -p -e 's/\s+/\n/g'
tr ' ' '\n' |\
	tr '\t' '\n' |\
	sed '/^$/d' |\
	LANG=C sort --buffer-size=4000M --temporary-directory=./  |\
	uniq -c |\
	sort -rn |\
	awk '{print NR " " $2 " " $1}' |\
	head -n $n
