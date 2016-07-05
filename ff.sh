#!/usr/bin/env bash

ffmpeg -i $1 -c:v libx264 -crf 18 -preset slower -map 0:0 -map 0:1 -c:a libfdk_aac -movflags +faststart $2