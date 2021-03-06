#!/bin/bash

if [ $# -ne 2 ]; then
  echo "$0 <infile> <outfile>"
  exit 1
fi

input=$1
output=$2

# convert $input into a character array
# use sed to replace the last newline char with nul
# use awk to insert a nice header
# finally, use sed again to comment-out the last line (containing the length of the array)
header="// autogenerated by $0 from <$input>"
xxd -i ${input} | sed 's/0x0a$/0x00/g' | awk "NR==1{print \"$header\"}1" | sed '$s/^/\/\/ /' > $output
