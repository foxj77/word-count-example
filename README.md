# word-count-example

## Description
This script processes a text file to provide a word count analysis. It counts the total number of words, the total number of unique words, and provides a frequency count of each word, sorted from the most to the least frequent.

The script is designed to handle words with possessive endings ('s) by treating them as the non-possessive form of the word.

All words are processed in a case-insensitive manner to ensure that 'Word' and 'word' are counted as the same word.

Hyphenated words are broken into two and counted separately.

Unicode characters, emoticons, are not supported and therefore not counted as a word.

## Features
- **Total Word Count:** Calculates how many words are in the file.
- **Total Unique Word Count:** Calculates how many unique words are in the file.
- **Word Frequency Count:** Lists each word alongside its frequency of occurrence in the file, sorted by the most frequent words first.

## Requirements
- Unix-like environment (Linux, MacOS)
- Bash shell
- Basic utilities: grep, sed, tr, wc, awk, sort

## Usage
To run the script, you need to pass a single text file as an argument. However, before executing the script, ensure it has the necessary executable permissions. 

### Setting Executable Permissions
If the script does not already have executable permissions, you can set them using the following command:

```bash
chmod +x count.sh
```

This command makes the script executable and ready to run.

### Executing the Script
Here is how to execute the script from a terminal:

```bash
./count.sh path_to_your_file.txt
```
Replace path_to_your_file.txt with the actual path to the text file you wish to analyze.

### Example Command
```bash
./count.sh sample.txt
```

### Output
The script outputs:

The name of the file processed.
Total word count in the file.
Total unique word count.
A table listing words, sorted by their frequency of occurrence, formatted as follows:

```bash
No.   Word                     Occurrences
1.    example                  15
2.    test                     10
```

## Error Handling
If no arguments are provided or the specified file does not exist, the script will output an appropriate error message guiding you to correct usage.

## Error Messages
If no file is provided: "Usage: count.sh <file>"
If the file does not exist: "Error: File does not exist."

## Testing

This project uses [Bats](https://github.com/bats-core/bats-core) (Bash Automated Testing System) for testing. Follow these instructions to run the tests.

### Prerequisites

First, ensure you have Bats installed. You can install Bats on most systems with the following commands



- on Ubuntu
```
sudo apt-get install bats
```

- on Mac
```
brew install bats-core
```
### Run Bats tests

``` bash
bats tests/
```
This will execute all Bats tests located in the tests folder and provide a report of any tests that fail along with successful ones.

Currently there are 3 test cases and these will be added to and be used as part of a continuation integration setup when changes are merged into main.  Due to time restraints just ensured the tests are added and can execute them.

Sample output of test results/output:
```
~/word-count-example$ bats  ./tests/
 ✓ Test with a regular file 
 ✓ Test with a same regular file in different order 
 ✓ Test with special characters 
 ✓ Test with empty file 
 ✓ Test with non-existing file 

5 tests, 0 failures
```
