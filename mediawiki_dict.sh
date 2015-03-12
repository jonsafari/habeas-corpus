#!/bin/sh
### Converts mediawiki dumps to bilingual dictionary
### By Jon Dehdari, 2012, GPLv3 license
### Usage: bzcat xxwiki-20121230-pages-articles.xml.bz2 | ./mediawiki_dict.sh <lang_id>
### You should probably use the wikidump from the smaller language, then use the <lang_id> for the larger language

lang=$1

perl -p -e '
    s/\n/__NL__/g;
    s/<\/text>/<\/text>\n/g;
    s/<title>/\n<title>/g;
    s/<\/title>/<\/title>/g;
' |
egrep '<title>' |
egrep -v '<title>[^<]+:' |	# rm Meta pages
fgrep -iv '#redirect' |		# rm redirects
pcregrep --buffer-size 500000 -o "(?:<title>.+?<\/title>)|(?:\[\[$lang:.+?\]\])" | # the actual words/phrases
fgrep -v ':]]' |			# rm empty translations (yes, they exist)
perl -p -e 's/\n//; s/\]\]/\]\]\n/' |
sed 's/<title>.*<title>/<title>/' |
grep '^<title>' | # rm articles containing multiple links to the same language
sed "s/^<title>//; s/\]\]$//g; s/<\/title>\[\[$lang:/\t/"
