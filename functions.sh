#!/usr/bin/env bash

function convert {
	ffmpeg -i "$1" -c:v libx264 -crf 20 -preset fast -map 0:0 -map 0:1 -c:a libfaac -movflags +faststart "$2"
}

function mc {
    if [ "${renameFile}" == "true" ]; then
        multicut.sh -name -remote $1
    else
	    multicut.sh -remote $1
	fi
}

function decode {
	otrdecoder -e ${otrEmail} -p ${otrPassword} -i $1
}