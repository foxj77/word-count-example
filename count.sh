#!/bin/bash

# Check if a file parameter is given
if [ $# -eq 0 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
  echo "Error: File does not exist."
  exit 1
fi

# Process the file to count unique words and their occurrences, sorted by frequency
cat "$1" | tr -sc 'A-Za-z' '\n' | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr | awk '{printf "%-20s - %s\n", $2, $1}'