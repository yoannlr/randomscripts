#!/bin/bash

# Animation script with bash
#
# Usage
# 1st argument: film file
# 2nd argument: height of a frame
# 3rd argument (optionnal): duration between each frame
#
#
# Example
#
# $ cat film_file
# ( ._.)   (._. )
# ( ._.)/  (._. )
# ( ._.)/ \(._. )
#
# $ ./films.sh film_file 1 0.25
# Plays the film with each line of 'film_file' as a frame

if test "${#}" -lt 2
then
	echo "Usage: ${0} <film_file> <frame_height>"
	exit 1
fi

if test -e "${1}"
then
	echo "Playing ${1} with frame height of ${2}"
else
	echo "${0}: film not found"
	exit 1
fi

i=1
nl=$(cat "${1}" | wc -l)
fh="${2}"
nf=$((nl / fh))
delay=0.5

echo "There are ${nf} frames in this film"

if test -z "${3}"
then
	echo "Using ${delay} as default time interval value"
else
	delay="${3}"
fi

sleep 1

while test "${i}" -le "${nf}"
do
	tput clear
	tput cup 5 0
	cat "${1}" | head -$((i * fh)) | tail -"${fh}"
	tput cup $((5 + fh + 5)) 0
	echo "${i} / ${nf}"
	sleep "${delay}"
	i=$((i + 1))
done
