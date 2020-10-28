#!/bin/sh

# generate a noise.prof file using `sox noise.wav -n noiseprof noise.prof`
# with noise.wav containing only the background noise

noiseprof="noise.prof"

file="${1}"
outfile=$(basename "$file" .mp4).wav

ffmpeg -i "$file" -map 0:1 tmpaudio.wav > /dev/null
sox tmpaudio.wav "$outfile" noisered "$noiseprof" 0.35
echo "$outfile"
