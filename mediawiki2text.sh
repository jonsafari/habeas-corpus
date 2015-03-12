#!/bin/sh
### Converts mediawiki dumps to text corpus
### Usage: bzcat mediawikidump.xml.bz2 | ./mediawiki2text.sh
### By Jon Dehdari, 2010

perl -p -e '
    s/\n/__NL__/g;
    #s/<text ([^>]+>)/\n<text $1/g;
    s/<\/text>/<\/text>\n/g;
    s/<title>/\n<title>/g;
    s/<\/title>/<\/title>/g;
' |
egrep '<title>' |
egrep -v '<title>[^<]+:' |	# rm Meta pages
fgrep -iv '#redirect' |		# rm redirects
perl -p -e '			# multi-line-spanning deletions
    s/<\/title>.+?<text/<\/title>__NL__<text/g;	# rm other header info
    s/{\|.+?\|}//g;		# rm tables
    s/{{[^{]+?}}//g;		# rm templates
    s/{{[^{]+?}}//g;		# rm templates
    s/&lt;div&gt;.+?&lt;\/div&gt;//g;	# rm line-spanning HTML thing
    s/&lt;ref&gt;.+?&lt;\/ref&gt;//g;	# rm line-spanning HTML thing
    s/&lt;inputbox&gt;.+?&lt;\/inputbox&gt;//g;	# rm line-spanning HTML thing
    s/&lt;center&gt;.+?&lt;\/center&gt;//g;	# rm line-spanning HTML thing
    s/&lt;.+?&gt;//g;		# rm HTML tags
    s/__NL__/\n/g;
' |
perl -p -e '			# most deletions go here
    s{<title>(.+)</title>}{\n# Title: $1}g;
    s/<text [^>]+>//g;
    s/<\/text>//g;
    s/^[*#].*//g;		# rm list items
    s/^==.+//g;			# rm section headers
    s/\[http:\S+ (.+?)\]/$1/g;	# rm ext links
    s/\[\[[^:]+?\|(.+?)\]\]/$1/g;	# rm wikilinks with alternate text
    s/\[\[([^:]+?)\]\]/$1/g;		# rm plain wikilinks
    s/\[\[.+?:[^[]*?\]\]//g;	# rm meta links (images, interwiki, categories, etc)
    s/\[\[ *\]\](:?\S+| ?)//g;		# rm empty wikilinks left over by previous deletions
    s/\( *\) ?//g;		# rm empty parentheses left over by previous deletions
    s/&quot;/"/g;		# unHTMLize double-quotes
' |
perl -00 -p -e "		# cleanup
    s/'''//g;			# rm italics & bold markers
    s/\n{3,}/\n\n/g;		# rm multiple newlines
"
