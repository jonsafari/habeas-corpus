#!/usr/bin/perl
### by Jon Dehdari, 2009
### License: GPL v. 3

use strict;
use encoding "utf8";
use Getopt::Long;

my $version = '1.0';
my $rev;

my $usage       = <<"END_OF_USAGE";
Buckwalter2unicode: convert from Buckwalter to UTF-8, or vice versa.  v. $version

Usage:   perl $0 [-r|--reverse] < infile > outfile

Options:
  -h, --help       Print this usage
  -r, --reverse    Convert from UTF-8 to Buckwalter
  -v, --version    Print version ($version)

END_OF_USAGE

GetOptions(
    'h|help|?'      => sub { print $usage; exit; },
    'r|reverse'     => \$rev,
    'v|version'     => sub { print "$version\n"; exit; },
) or die $usage;


while (<>) {

  if ($rev) { # utf8 to buck
      tr/پچژگ،؛؟ءآأؤإئابةتثجحخدذرزسشصضطظعغـفقكلمنهوىيًٌٍَُِّْ/PJRG,;?'|>&<}AbptvjHxd*rzs\$SDTZEg_fqklmnhwYyFNKaui~o/d;
   }

   else { # buck to utf8
       tr/PJRG,;?'|>&<}AbptvjHxd*rzs\$SDTZEg_fqklmnhwYyFNKaui~o/پچژگ،؛؟ءآأؤإئابةتثجحخدذرزسشصضطظعغـفقكلمنهوىيًٌٍَُِّْ/d;
  }

  print;

}
