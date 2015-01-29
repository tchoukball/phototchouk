#!/bin/sh

# Original version by Nicolas Heiniger (2006)
# Usage :
# ./phototchouk.sh [filename]

### Parameters ###
width=2048
height=2048
quality=100
counter=1
index="0001"
# getting the current directory name
filename="$(printf '%q\n' "${PWD##*/}")"
proceed=false

# checking the arguments
if [ $# -ne 1 ]; then
	printf "Use $filename as filename for the photos? [y|n] "
	read answer
	if [[ "$answer" = [Yy] ]]; then
		proceed=true
	else
		echo "Usage : ./phototchouk.sh [filename]"
	fi
elif [ -n $1 ]; then
	# putting argument in variable
	filename="$1"
	proceed=true
fi

if [ "$proceed" = true ]; then

	# directory for the files to upload
	mkdir web
	# log file
	touch ./0conversion.txt

	# computing the total number of files to convert
	nbFilesToConvert=$(ls *.[jJ][pP][gG] | wc -l)
	echo "$nbFilesToConvert files to convert"

	# resizing
	for i in *.[jJ][pP][gG]; do
		nbFilesToConvert=$((nbFilesToConvert-1))
		echo "Processing $i ($nbFilesToConvert files left)"
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
