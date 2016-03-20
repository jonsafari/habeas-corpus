#!/usr/bin/env python3
# By Jon Dehdari, 2016
# MIT License
# Converts words to integers, online
# Usage: python3 word2int.py < input.txt > output.txt

import sys
from array import array

words = {}
count = 1

for line in sys.stdin:
    ws = line.split()
    ws_len = len(ws)
    ints = array('L', [0] * ws_len)
    for w in range(ws_len):
        if ws[w] in words:
            ints[w] = words[ws[w]]
        else:
            ints[w]  = count
            words[ws[w]] = count
            count    += 1
    print(*ints, sep=' ')
