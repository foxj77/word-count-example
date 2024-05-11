if [ $# -eq 0 ]; then
  echo "Usage: $0 <file>"
  exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
  echo "Error: File does not exist."
  exit 1
fi

# Print the header using printf for alignment
printf "%-5s %-25s %s\n" "No." "Word" "Occurrences"

# Process the file to count unique words and their occurrences, sorted by frequency
cat "$1" | tr -sc 'A-Za-z' '\n' | tr 'A-Z' 'a-z' | sort | uniq -c | sort -nr | awk '{printf "%-5s %-25s %s\n", NR".", $2, $1}'