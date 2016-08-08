#!/usr/bin/env bash

source functions.sh

# cut
count=`ls -1 *.avi 2>/dev/null | wc -l`
if [ $count != 0 ]; then
	for file in *.avi
	do
		mc $file
	done
fi