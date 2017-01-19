#!/bin/sh
NP="`mpc current | grep -Po '(?<=: ).+?(?= *\[)' | sed -e 's/ - /: /'`"
LEN="`echo $NP | wc -c`"
if [ "$LEN" -gt 53 ]
then
	echo "[`echo $NP | cut -c1-50`..."
else
	echo "[$NP]"
fi
