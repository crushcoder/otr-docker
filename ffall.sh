#!/usr/bin/env bash

source functions.sh

count=`ls -1 *.m4v 2>/dev/null | wc -l`
if [ $count != 0 ]; then
	for file in *.m4v
	do
		convert "${file}" "${file}.small.m4v"
	done
fi

count=`ls -1 *.avi 2>/dev/null | wc -l`
if [ $count != 0 ]; then
	for file in *.avi
	do
		convert "${file}" "${file}.m4v"
	done
fi
