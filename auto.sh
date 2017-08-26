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

# cleanup (only if success)
count=`ls -1 cut/*.m4v 2>/dev/null | wc -l`
if [ $count != 0 ] && [ `wc -c cut/*.m4v | tail -n 1 | cut -c8-9` != "0" ]; then
	echo "cleanup"
	rm -f *.otrkey
	mv cut/*.m4v ./
	rm -rf cut uncut decoded
else
	echo "no .m4v files, something went wrong"
fi
