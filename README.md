# Habeas Corpus
This is a collection of **command-line corpus tools**.
For convenience it also includes submodules from Ken's [preprocess](https://github.com/kpu/preprocess) and Rico's [BPE](https://github.com/rsennrich/subword-nmt) repos. To include submodules when cloning, add the `--recursive` flag:

```bash
    git clone --recursive https://github.com/jonsafari/habeas-corpus
```

Many of the scripts have a command-line argument <tt> --help </tt> for usage information, so often you can type the following for more specific help: <pre>./myscript.sh --help</pre>
Most of these scripts take their input from [stdin][], and output text to [stdout][], so the Unix command-line usage for many of these scripts is: <pre>./myscript.sh < input.txt > output.txt</pre>
Or you can [pipe][] these commands with other commands.

* [allcat](allcat) - Works like [cat] regardless of whether the file is plaintext, [.gz], [.bz2], [.lzma], or [.xz] (best)
* [char_freq.sh](char_freq.sh) - Tabulates the frequency of characters in a text
* **[corpus_get.sh](corpus_get.sh)** - Builds a corpus from a remote website, recursively downloading all webpages
* [generate_language.sh](generate_language.sh) - Randomly generates text, given a language model and vocabulary
* [mediawiki_dict.sh](mediawiki_dict.sh) - Converts [MediaWiki] [dumps] to bilingual dictionary.  You should use the wikidump from the smaller language
* [par_map.sh](par_map.sh) - Parallel Map a command for either a single file or multiple files (i.e. parallelize a command)
* [rev_words.pl](rev_words.pl) - Reverses word order in each line.  For example "how are you?" becomes "you? are how"
* **Preprocessing**:
 * [digit_conflate.pl](digit_conflate.pl) - Conflates all numerical digits to a single digit.  For example 48,250.75  -&gt; 55,555.55
 * [lowercase.pl](lowercase.pl) - Lowercases all texts.  Works on almost all [bicameral] orthographies
 * **[Tok-tok](https://github.com/jonsafari/tok-tok)** - General tokenizer, suitable for many languages
 * [uppercase.pl](uppercase.pl) - Uppercases all texts.  Works on almost all [bicameral] orthographies
* **Vocabulary extraction**:
 * [vocab.sh](vocab.sh) - Lists the vocabulary (set of unique words) from a text corpus
 * [vocab_top.sh](vocab_top.sh) - Lists a frequency-sorted vocabulary (set of unique words) from a text corpus
 * [vocab_filter.py](vocab_filter.py) - Replaces infrequent tokens with `<unk>`
 * [word2int.py](word2int.py) - Converts words to integers, online
* **Experiment management**:
 * **[generate_splits.pl](generate_splits.pl)** - Generates train/dev/test splits from a whole corpus.  Every <i>n</i> lines goes to the training set, then one to the development set, then one to the test set
 * **[subcorpora.pl](subcorpora.pl)** - Builds subcorpora from a whole corpus, increasing in size exponentially
* **Penn Treebank formatting**:
 * [penn2conll.sh](penn2conll.sh) - Converts [Penn treebank format] to POS-tagged [CoNLL-X format]
 * [penn2plain.pl](penn2plain.pl) - Converts Penn treebank format to plaintext
 * [penn2qtree.sh](penn2qtree.sh) - Converts Penn treebank format to [Qtree] format for use in LaTeX documents
* **Character set encoding**:
 * [buckwalter2unicode.pl](buckwalter2unicode.pl) - Converts from [Buckwalter transliteration] to UTF-8 native Arabic script
* **Classical cryptanalysis**:
 * [pivot.pl](pivot.pl) - Rotates text by 90 degrees
 * [playfair_digraph_freq.sh](playfair_digraph_freq.sh) - Tabulates [Playfair]-style digraph character frequencies


## Other Useful Commands
* [grep] - Search for a pattern in text.  [All][grep-cmd-args] of the command-line arguments are useful, especially `-r`, `-i`, `-c`, `-e`, `-v`, `-o`, `-w` (spells *ricevow*)
* [shuf] - Randomizes the lines of the input.  For reproducible pseudo-randomization, try `--random-source=input.txt`
* [sort] - Sorts the lines of the input.  For large corpora, use `LANG=C sort --buffer-size=4000M --temporary-directory=./`
* [tac] - Reverses line-order of the input
* [wc] - Counts number of lines, words (tokens), and characters.  The argument `--max-line-length` is also useful.


## Other Useful Corpus Tools
* [Corpus.tools](http://corpus.tools)
* [Preprocess](https://github.com/kpu/preprocess)


[pipe]: https://en.wikipedia.org/wiki/Pipeline_(Unix)
[stdin]: https://en.wikipedia.org/wiki/Standard_streams#Standard_input_.28stdin.29
[stdout]: https://en.wikipedia.org/wiki/Standard_streams#Standard_output_.28stdout.29

[cat]: https://en.wikipedia.org/wiki/Cat_(Unix)
[.gz]: https://en.wikipedia.org/wiki/Gzip
[.bz2]: https://en.wikipedia.org/wiki/Bzip2
[.lzma]: https://en.wikipedia.org/wiki/Lzma
[.xz]: https://en.wikipedia.org/wiki/Xz
[Buckwalter transliteration]: https://en.wikipedia.org/wiki/Buckwalter_transliteration
[bicameral]: https://en.wikipedia.org/wiki/Letter_case
[MediaWiki]: https://en.wikipedia.org/wiki/MediaWiki#Markup
[dumps]: http://dumps.wikimedia.org/backup-index.html
[Penn treebank format]: ftp://ftp.cis.upenn.edu/pub/treebank/doc/arpa94.ps.gz
[CoNLL-X format]: http://ilk.uvt.nl/conll/index.html#dataformat
[Qtree]: http://www.ling.upenn.edu/advice/latex/qtree
[Playfair]: https://en.wikipedia.org/wiki/Playfair_cipher

[grep]: https://en.wikipedia.org/wiki/Grep
[grep-cmd-args]: https://www.gnu.org/software/grep/manual/grep.html#Command_002dline-Options
[shuf]: https://en.wikipedia.org/wiki/Shuf
[sort]: https://en.wikipedia.org/wiki/Sort_(Unix)
[tac]: https://en.wikipedia.org/wiki/Tac_(Unix)
[wc]: https://en.wikipedia.org/wiki/Wc_(Unix)
