#!/usr/bin/env perl
## By Jon Dehdari 2013
## Outputs subcorpora, increasing in size exponentially
## Usage: perl subcorpora.pl -h

use strict;
use File::Copy qw(copy);
use Getopt::Long;

## Defaults
my $exponentiation_base = 10;
my $exponent_increment  = 1;
my $exponent_start      = 6;
my $exponent_end        = 9;
my $base_prefix         = "subcorpus_w-";
my $base_suffix         = ".txt";

my ($verbose, $keep_last);

my $usage     = <<"END_OF_USAGE";
subcorpora.pl    (c) 2013 Jon Dehdari - GPL v3

Usage:    perl $0 [options] --prefix subcorpus_  --suffix .txt < corpus.txt

Function: Outputs subcorpora, increasing in size exponentially

Options:
 -p, --prefix <s>        Basepath prefix of output files (default: $base_prefix)
 -s, --suffix <s>        Basepath suffix of output files (default: $base_suffix)
 -b, --exp-base <f>      Base used for exponentiation, such as 2 or 10 (default: $exponentiation_base)
 -i, --exp-increment <f> Increase the exponent by <f> for each iteration, such as 0.5 or 1 (default: $exponent_increment)
     --exp-start <f>     Start the exponent at <f> (default: $exponent_start)
     --exp-end <f>       End the exponent at <f> (default: $exponent_end)
     --keep-last         Keep last file, even though it's equivalent to input
 -h, --help              Print this usage
 -v, --verbose           Print additional info to stderr

END_OF_USAGE

GetOptions(
    'p|prefix=s'		=> \$base_prefix,
    's|suffix=s'		=> \$base_suffix,
    'b|exp-base=f'		=> \$exponentiation_base,
    'i|exp-increment=f'	=> \$exponent_increment,
    'exp-start=f'		=> \$exponent_start,
    'exp-end=f'			=> \$exponent_end,
    'keep-last'			=> \$keep_last,
    'h|help|?'			=> sub { print $usage; exit; },
    'v|verbose'			=> \$verbose,
) or die $usage;


### Outputs to the current size, then when that's done, copies that file to the next larger one, and outputs there.
### It deletes the last one (unless --keep-last is set), since that's equivalent to the original corpus.
my $exponent = $exponent_start;
my $next_exponent = $exponent + $exponent_increment;
my $wc = 0;
my $wc_threshold = int($exponentiation_base**$exponent);

my $out_file_name = "${base_prefix}${exponentiation_base}^${exponent}${base_suffix}";
$verbose and print "First out_file_name=$out_file_name\n";
open OUTFILE, ">", $out_file_name or die $!;

while (<>) {
	my @words = split;
	$wc += scalar(@words);
	$verbose and print "wc=$wc, exponent=$exponent, threshold=$wc_threshold\t";
	print OUTFILE join(' ', @words) . "\n";

	## Close current outfile, copy it to next larger one, and open that 
	if ($wc > $wc_threshold) {
		$verbose and print "Reached threshold, $wc > $wc_threshold\n";
		$exponent += $exponent_increment;
		$wc_threshold = int($exponentiation_base**$exponent);

		$exponent > $exponent_end  and exit;  # We don't need to do anything more, if we've reached the limit

		close OUTFILE;
		copy $out_file_name, "${base_prefix}${exponentiation_base}^${exponent}${base_suffix}";
		$out_file_name =     "${base_prefix}${exponentiation_base}^${exponent}${base_suffix}";
		open OUTFILE, ">>", $out_file_name or die $!;
		$verbose and print "Next out_file_name=$out_file_name\n";
	}
}

close OUTFILE;
unless ($keep_last) {
	unlink $out_file_name;
}
