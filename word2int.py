#!/usr/bin/env python3
# By Jon Dehdari, 2016
# MIT License
# Converts words to integers
# Usage: python3 word2int.py < input.txt > output.txt


import sys

words = {}
i     = 1

for line in sys.stdin:
    for w in line.split():
        if w in words:
            print(words[w], end=' ')
        else:
            words[w] = i
            print(i, end=' ')
            i += 1
    print('')
