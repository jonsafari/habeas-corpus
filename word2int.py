#!/usr/bin/env python3
# By Jon Dehdari, 2016
# MIT License
# Converts words to integers, online
# Usage: python3 word2int.py < input.txt > output.txt

import sys
import os.path
from array import array
import argparse
parser = argparse.ArgumentParser(description='Converts words to integers, online')

parser.add_argument('-i', '--in_map', help="Load pre-existing mapping file")
parser.add_argument('-o', '--out_map', help="Save final mapping to file")
args = parser.parse_args()

words = {}
count = 1

def import_mapping(in_file):
    count = 1
    for line in in_file:
        (word, id) = line.split()
        words[word] = int(id)
        count += 1
    return count

def export_mapping(out_file, words):
    for word, id in words.items():
        print(word, "\t", id, sep='', file=out_file) # Use Python 3 interpreter


# Open input and output mapping files
if args.in_map != None:
    in_file = open(args.in_map)  # open existing file as read-only
    count = import_mapping(in_file)
    in_file.close()
if args.out_map != None:
    out_file = open(args.out_map, mode='w')  # open new file as write


# Process stdin
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
    print(*ints, sep=' ') # Use Python 3 interpreter


# Save final word mapping to file
if args.out_map != None:
    export_mapping(out_file, words)
    out_file.close()
