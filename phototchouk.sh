#!/bin/sh

# Nicolas Heiniger (2006)
# Version : 1.1 (28.8.2007)
# Utilisation :
# photoFSTB.sh filename

### Paramètres ###
width=1200
height=1200
quality=80
counter=1
index="0001"
filename=""

# on vérifie les arguments
if [ $# -ne 1 ]; then
	echo "Usage : photoFSTB filename"
elif [ -n $1 ]; then
	# on met les arguments dans nos variables
	filename="$1"
	
	# fichier de conversion
	mkdir web
	touch ./0conversion.txt
	
	# on change la taille
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
		convert $i -resize ${width}x$height -quality $quality ./web/${filename}_$index.jpg # copie pour le web
		mv "$i" ./${filename}_$index.jpg # copie pour le disque dur FSTB
		counter=$(( $counter + 1 ))
	done
	echo "Resizing ended successfully."
fi
