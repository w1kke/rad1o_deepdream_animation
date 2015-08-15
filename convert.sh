#!/bin/bash

# do the conversion
for i in *.png ; do perl img2lcd.pl "$i" ; done

export delay=200
export frames=""
for i in `ls *.lcd | sort -V`; do export frames="$frames $i $delay" ; done
perl lcd2ani_custom.pl -v out.an1 $frames
rm *.lcd
