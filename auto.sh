#!/usr/bin/env bash

source functions.sh
#ffmpeg -bsf:v h264_mp4toannexb -sn  -vcodec libx264 "$i.ts"


# store cutlist.at url to file
filename=/root/.cutlist.at
if [ -a "$filename" ]; then
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