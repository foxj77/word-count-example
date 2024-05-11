if [ $# -eq 0 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
  echo "Error: File does not exist."
  exit 1
fi

# Strip possessive 's and normalize case
processed_content=$(cat "$1" | grep -oE '\w+'\''?\w*' | sed "s/'s$//g" | tr 'A-Z' 'a-z')

# Get the total word count
total_words=$(echo "$processed_content" | wc -w)

# Get the total unique word count
total_unique_words=$(echo "$processed_content" | sort | uniq | wc -l)

# Print the filename and total word count
echo "File: $1"
echo "Total word count: $total_words"
echo "Total unique word count: $total_unique_words"

# Print the header using printf for alignment
printf "%-5s %-25s %s\n" "No." "Word" "Occurrences"

# Process the file to count unique words and their occurrences, sorted by frequency
echo "$processed_content" | sort | uniq -c | sort -nr | awk '{printf "%-5s %-25s %s\n", NR".", $2, $1}'
