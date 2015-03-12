#!/bin/sh
# Usage: ./corpus_get.sh  [more-wget-args]  www.example.com
#
# This recursively downloads webpages from a server, and puts them into
#    a new directory, named the argument you pass the script (which in
#    the above example is www.example.com)
time nice wget --recursive --level 15 --timestamping --wait 1 --no-remove-listing --backup-converted --convert-links --no-parent --no-verbose -R .ram,.ra,.RA,.rm,.mp3,.Mp3,.mp4,.jpg,.JPG,.jpeg,.jpe,.gif,.png,.bmp,.wmv,.swf,.js,.css,.pdf,.PDF -U "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)"  $*
# --limit-rate=35k
