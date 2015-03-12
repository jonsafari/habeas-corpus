#!/usr/bin/env perl
## Rotates (pivots) text by 90 degrees
## By Jon Dehdari, 2012
## Usage: ./pivot.pl < input.txt > output.txt
## Example input:
## abcd
## efgh
## ijkl
#
## Output:
## aei
## bfj
## cgk
## dhl

use strict;
my @text;
my $max_length = 0;

while (<>) {
	chomp;
	my @line = split //;
	my $length_line = scalar(@line);
	$max_length = $length_line if $length_line > $max_length;
	push @text, [ @line ];
}

my $length_text = scalar(@text);

for my $i (0 .. $max_length-1) {
	for my $j (0 .. $length_text-1) {
		print $text[$j][$i];
	}
	print "\n";
}
