# Habeas Corpus
This is a collection of **command-line corpus tools**.
Many of these scripts have a command-line argument <tt> --help </tt> for usage information, so often you can type the following for more specific help: <pre>./myscript.sh --help</pre>
Most of these scripts take their input from [stdin][], and output text to [stdout][], so the Unix command-line usage for many of these scripts is: <pre>./myscript.sh < input.txt > output.txt</pre>
Or you can [pipe][] these commands with other commands.

* <a href="allcat">allcat</a> - Works like <a href="https://en.wikipedia.org/wiki/Cat_(Unix)"><tt>cat</tt></a> regardless of whether the file is plaintext, <a href="https://en.wikipedia.org/wiki/Gzip">.gz</a>, <a href="https://en.wikipedia.org/wiki/Bzip2">.bz2</a>, <a href="https://en.wikipedia.org/wiki/Lzma">.lzma</a>, or <a href="https://en.wikipedia.org/wiki/Xz">.xz</a> (best)
* <a href="buckwalter2unicode.pl">buckwalter2unicode.pl</a> - Converts from <a href="https://en.wikipedia.org/wiki/Buckwalter_transliteration">Buckwalter transliteration</a> to UTF-8 native Arabic script
* <a href="char_freq.sh">char_freq.sh</a> - Tabulates the frequency of characters in a text
* <a href="corpus_get.sh">corpus_get.sh</a> - Builds a corpus from a remote website, recursively downloading all webpages
* <a href="digit_conflate.pl">digit_conflate.pl</a> - Conflates all numerical digits to a single digit.  For example 48,250.75  -&gt; 55,555.55
* <a href="generate_language.sh">generate_language.sh</a> - Randomly generates text, given a language model and vocabulary
* <a href="generate_splits.pl">generate_splits.pl</a> - Generates train/dev/test splits from a whole corpus.  Every <i>n</i> lines goes to the training set, then one to the development set, then one to the test set
* <a href="get_vocab.sh">get_vocab.sh</a> - Lists the vocabulary (set of unique words) from a text corpus
* <a href="lowercase.pl">lowercase.pl</a> - Lowercases all texts.  Works on almost all <a href="https://en.wikipedia.org/wiki/Letter_case">bicameral</a> orthographies
* <a href="mediawiki2text.sh">mediawiki2text.sh</a> - Converts <a href="https://en.wikipedia.org/wiki/MediaWiki#Markup">MediaWiki</a> <a href="http://dumps.wikimedia.org/backup-index.html">dumps</a> to text corpus (imperfect)
* <a href="mediawiki_dict.sh">mediawiki_dict.sh</a> - Converts MediaWiki dumps to bilingual dictionary.  You should use the wikidump from the smaller language
* <a href="par_map.sh">par_map.sh</a> - Parallel Map a command for either a single file or multiple files (i.e. parallelize a command)
* <a href="penn2conll.sh">penn2conll.sh</a> - Converts <a href="ftp://ftp.cis.upenn.edu/pub/treebank/doc/arpa94.ps.gz">Penn treebank format</a> to POS-tagged <a href="http://ilk.uvt.nl/conll/index.html#dataformat">CoNLL-X format</a>
* <a href="penn2plain.pl">penn2plain.pl</a> - Converts Penn treebank format to plaintext
* <a href="penn2qtree.sh">penn2qtree.sh</a> - Converts Penn treebank format to <a href="http://www.ling.upenn.edu/advice/latex/qtree/">Qtree</a> format for use in LaTeX documents
* <a href="pivot.pl">pivot.pl</a> - Rotates text by 90 degrees
* <a href="playfair_digraph_freq.sh">playfair_digraph_freq.sh</a> - Tabulates <a href="https://en.wikipedia.org/wiki/Playfair_cipher">Playfair</a>-style digraph character frequencies
* <a href="rev_words.pl">rev_words.pl</a> - Reverses word order in each line.  For example "how are you?" becomes "you? are how"
* <a href="subcorpora.pl">subcorpora.pl</a> - Builds subcorpora from a whole corpus, increasing in size exponentially
* <a href="https://github.com/jonsafari/tok-tok">Tok-tok</a> - General tokenizer, suitable for many languages
* <a href="uppercase.pl">uppercase.pl</a> - Uppercases all texts.  Works on almost all <a href="https://en.wikipedia.org/wiki/Letter_case">bicameral</a> orthographies
* <a href="win1256_2_roman.tcl">win1256_2_roman.tcl</a> - Convert Persian Win-1256 text to transliteration.  Superseded by <a href="http://sourceforge.net/projects/perstem/">Perstem</a> with the arguments <tt> --form untouched -i cp1256 -o translit</tt>

## Other Useful Commands
* <a href="https://en.wikipedia.org/wiki/Grep">grep</a> - Search for a pattern in text.  Learn <a href="https://www.gnu.org/software/grep/manual/grep.html#Command_002dline-Options">all</a> of the command-line arguments, especially -r, -i, -c, -e, -v, -o, -w
* <a href="https://en.wikipedia.org/wiki/Shuf">shuf</a> - Randomizes the lines of the input.  For reproducible pseudo-randomization, try <tt>--random-source=input.txt</tt>
* <a href="https://en.wikipedia.org/wiki/Sort_(Unix)">sort</a> - Sorts the lines of the input.  For large corpora, use <tt>LANG=C sort --buffer-size=4000M --temporary-directory=./</tt>
* <a href="https://en.wikipedia.org/wiki/Tac_(Unix)">tac</a> - Reverses line-order of the input
* <a href="https://en.wikipedia.org/wiki/Wc_(Unix)">wc</a> - Counts number of lines, words (tokens), and characters.  The argument <tt>--max-line-length</tt> is also useful.

## Other Useful Corpus Tools
* [Corpus.tools](http://corpus.tools)
* [Preprocess](https://github.com/kpu/preprocess)


[pipe]: https://en.wikipedia.org/wiki/Pipeline_(Unix)
[stdin]: https://en.wikipedia.org/wiki/Standard_streams#Standard_input_.28stdin.29
[stdout]: https://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29
