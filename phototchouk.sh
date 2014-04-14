#!/bin/sh

# Original version by Nicolas Heiniger (2006)
# Usage :
# phototchouk.sh filename

### Parameters ###
width=1200
height=1200
quality=80
counter=1
index="0001"
filename=""

# checking the arguments
if [ $# -ne 1 ]; then
	echo "Usage : phototchouk filename"
elif [ -n $1 ]; then
	# putting arguments in variables
	filename="$1"

	# directory for the files to upload
	mkdir web
	# log file
	touch ./0conversion.txt

	# resizing
	for i in *.[jJ][pP][gG]; do
		echo "Processing $i"
		if [ "$counter" -lt 10 ]; then
			index="000"$counter
		elif [ $counter -lt 100 ]; then
			index="00"$counter
		elif [ $counter -lt 1000 ]; then
			index="0"$counter
		elif [ $counter -lt 10000 ]; then
			index=$counter
		else
			echo "Warning counter greater than 9999"
			exit -1
		fi
		echo "$i : ${filename}_$index.jpg" >> ./0conversion.txt
		convert $i -resize ${width}x$height -quality $quality ./web/${filename}_$index.jpg # copies for Phototchouk.com
		mv "$i" ./${filename}_$index.jpg # copies for the archive hard drive
		counter=$(( $counter + 1 ))
	done
	echo "Resizing ended successfully."
fi
