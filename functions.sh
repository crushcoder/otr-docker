#!/usr/bin/env bash

function convert {
	ffmpeg -i "$1" -c:v libx264 -crf 20 -preset fast -map 0:0 -map 0:1 -c:a aac -movflags +faststart "$2"
}

function mc {
	multicut.sh -auto -smart -remote $1
}

function decode {
	otrdecoder -e ${otrEmail} -p ${otrPassword} -i $1
}