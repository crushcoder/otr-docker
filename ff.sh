#!/usr/bin/env bash

ffmpeg -i $1 -c:v libx264 -crf 20 -preset fast -map 0:0 -map 0:1 -c:a libfdk_aac -movflags +faststart $2
