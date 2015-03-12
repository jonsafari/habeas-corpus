#!/usr/bin/env perl
## By Jon Dehdari, 2012
## Public domain
## Compare with unix commands "tac" and "rev"
## Reverses words in each line
## For example,
## printf 'hi there\n  how are you?  \n' | ./rev_words.pl
## there hi
## you? are how

use strict;

while (<>) {
	print join ' ', reverse split;
	print "\n";
}
