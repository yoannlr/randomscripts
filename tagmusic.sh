#!/bin/sh

# $1 is the config file
# config file format is
#
# ./path/to/file.ext	Song artist	Song title
#
# one line is one music file
# fields are separated with tab (\t)

config="${1}"
dir="${PWD}"

tag() {
	ext="${1##*.}"
	ffmpeg -i "$dir/${1}" \
		-c copy \
		-metadata artist="${2}" \
		-metadata title="${3}" \
		"${dir}/${1}.tag.${ext}"
	rm "$dir/${1}"
	mv "$dir/${1}.tag.${ext}" "$dir/${1}"
}

while read line
do
	file=$(echo "$line" | cut -d$'\t' -f1)
	artist=$(echo "$line" | cut -d$'\t' -f2)
	title=$(echo "$line" | cut -d$'\t' -f3)
	tag "$file" "$artist" "$title"
done < "$config"
