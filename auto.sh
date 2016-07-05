#!/usr/bin/env bash

#ffmpeg -bsf:v h264_mp4toannexb -sn  -vcodec libx264 "$i.ts"
function convert {
	ffmpeg -i $1 -c:v libx264 -crf 18 -preset slower -map 0:0 -map 0:1 -c:a libfdk_aac -movflags +faststart $2
}

function mc {
	multicut.sh -auto -smart -remote $1
}

function decode {
	otrdecoder -e ${otrEmail} -p ${otrPassword} -i $1
}

# store cutlist.at url to file
filename=/root/.cutlist.at
if [ -a "$filename" ] then
	rm "$filename"
fi
touch "$filename"
echo ${cutlistAtUrl} >> "$filename"

# decode
for keyFile in /otr/*.otrkey
do
	echo "Processing: $keyFile"
	decode $keyFile
done

# cut
for decodedFile in /otr/*.avi
do
	mc $decodedFile
done

# convert
for cutFile in /otr/cut/*.avi
do
	convert "${cutFile}" "${cutFile}.m4v"
done

# cleanup
rm -f *.otrkey
mv cut/*.m4v ./
rm -rf cut uncut decoded