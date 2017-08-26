#!/usr/bin/env bash

source functions.sh

CONV="converted"
ORG="original"

function convertAll {
	count=`ls -1 *.$1 2>/dev/null | wc -l`
	if [ $count != 0 ]; then
		for file in *.$1
		do
			convert "${file}" "${CONV}/${file}.m4v"
			mv "${file}" "${ORG}/${file}"
		done
	fi
}

if [ ! -d "${CONV}" ]; then
	mkdir "${CONV}"
fi
if [ ! -d "${ORG}" ]; then
	mkdir "${ORG}"
fi


count=`ls -1 *.m4v 2>/dev/null | wc -l`
if [ $count != 0 ]; then
	for file in *.m4v
	do
		convert "${file}" "${CONV}/${file}"
		mv "${file}" "${ORG}/${file}"
	done
fi

convertAll "avi"
convertAll "mp4"
convertAll "mov"
convertAll "mkv"