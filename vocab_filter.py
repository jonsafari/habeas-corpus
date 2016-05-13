#!/usr/bin/env python3
# By Jon Dehdari, 2015
# MIT License
# Replaces infrequent tokens with <unk>
# This little script is mostly for working with other people's code that doesn't handle vocab limits and/or frequency thresholds
# Usage: python3 vocab_filter.py corpus.txt{,.gz,.xz} > corpus_with_unks.txt   (or:  ... | xz -9 > corpus_with_unks.txt.xz )

import os, sys, argparse
import gzip, lzma
parser = argparse.ArgumentParser(description='Replaces infrequent tokens with <unk>')

parser.add_argument('-t', '--threshold', help='Frequency threshold (default: %(default)s)', type=int, default=3)
parser.add_argument('-f', '--file', help='Corpus file.  Can be compressed by gzip or xz')
parser.add_argument('-u', '--unk', help='Default unknown symbol (default: %(default)s)', type=str, default='<unk>')
#parser.add_argument('-v', '--vocab_size', help='Maximum vocabulary size', type=int, default=0)
args = parser.parse_args()


filename = args.file
fileprefix, filesuffix = os.path.splitext(filename)

if filesuffix == '.gz':
    file = gzip.open(filename, mode='rt', encoding='utf-8')
elif filesuffix == '.xz':
    file = lzma.open(filename, mode='rt', encoding='utf-8')
else:
    file = open(filename)


wordcount = {}

while True:
    line = file.readline()
    if not line:
        break

    splitline = line.split()
    for w in splitline:
        if w in wordcount:
            wordcount[w] += 1
        else:
            wordcount[w] = 1

file.close()


if filesuffix == '.gz':
    file = gzip.open(filename, mode='rt', encoding='utf-8')
elif filesuffix == '.xz':
    file = lzma.open(filename, mode='rt', encoding='utf-8')
else:
    file = open(filename)


while True:
    line = file.readline()
    if not line:
        break

    splitline = line.split()
    for w in splitline:
        if wordcount[w] >= args.threshold:
            print(w, end=' ')
        else:
            print(args.unk, end=' ')
    print('')

file.close()
