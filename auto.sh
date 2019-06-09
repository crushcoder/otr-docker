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
if [ "${skipDecode}" != "true" ]; then
    for keyFile in /otr/*.otrkey
    do
        echo "Processing: $keyFile"
        decode $keyFile
    done
else
    echo "decode skipped"
fi

# cut
if [ "${skipCut}" != "true" ]; then
    for decodedFile in /otr/*.avi
    do
        mc $decodedFile
    done
else
    echo "cut skipped"
fi

# convert
if [ "${convert}" != "false" ] && [ "${skipConvert}" != "true" ]; then
	resultFileType=".m4v"
	for cutFile in /otr/cut/*.avi
	do
		convert "${cutFile}" "${cutFile}.m4v"
	done
else
    echo "convert skipped"
	resultFileType=".avi"
fi

# cleanup (only if success)
countOtr=`ls -1 *.otrkey 2>/dev/null | wc -l`
countResult=`ls -1 cut/*${resultFileType} 2>/dev/null | wc -l`
if [ "${skipCleanup}" != "true" ] && [ $countOtr == $countResult ] && [ `wc -c cut/*${resultFileType} | tail -n 1 | cut -c8-9` != "0" ]; then
	echo "cleanup"
	rm -f *.otrkey
	mv cut/*${resultFileType} ./
	rm -rf cut uncut decoded
elif [ "${skipCleanup}" == "true" ]; then
    echo "cleanup skipped, keeping intermediate files"
else
	echo "something went wrong, keeping intermediate files"
fi
