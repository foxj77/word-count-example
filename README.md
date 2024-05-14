# word-count-example

## Description
This script processes a text file to provide a word count analysis. It counts the total number of words, the total number of unique words, and provides a frequency count of each word, sorted from the most to the least frequent. 


- The script is designed to handle words with possessive endings ('s) by treating them as the non-possessive form of the word. 

- All words are processed in a case-insensitive manner to ensure that 'Word' and 'word' are counted as the same word.

- Hyphenated words are broken into two and counted separately.

- Unicode characters, emoticons, are not supported and therefore not counted as a word.

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

Firstly clone the repository locally using the git command `git clone https://github.com/foxj77/word-count-example.git` or follow the instructions from Github.

### Setting Executable Permissions
If the script does not already have executable permissions, you can set them using the following command:

```bash
chmod +x count.sh
```
This command makes the script executable and ready to run.

### Executing the Script
Here is how to execute the script from a terminal:

```bash
./count.sh sampleData/data.txt
```


### Output
The script outputs:
  - The name of the file processed.
  - Total word count in the file.
  - Total unique word count.
  - A table listing words, sorted by their frequency of occurrence, formatted as follows:

```bash
File: sampleData/data.txt
Total word count: 225
Total unique word count: 153
No.   Word                      Occurrences
1.    a                         6
2.    ut                        5
3.    lorem                     4
4.    in                        4
5.    et                        4
6.    elit                      4
7.    consequat                 4
8.    tempor                    3
9.    sapien                    3
```

## Error Handling
If no arguments are provided or the specified file does not exist, the script will output an appropriate error message guiding you to correct usage.

## Error Messages
If no file is provided: 
`"Usage: count.sh <file>"`

If the file does not exist: 
`"Error: File does not exist."`

## Testing

This project uses [Bats](https://github.com/bats-core/bats-core) (Bash Automated Testing System) for testing. 

Tests can be run manually with the instructions below.  Otherwise the tests will be executed on a PR into main using a Github Actions workflow.  

### Prerequisites for running locally

First, ensure you have Bats installed. You can install Bats on most systems with the following commands

- on Ubuntu
```
sudo apt-get install bats
```
- on Mac
```
brew install bats-core
```

Follow these steps to run the Bats tests:

1. Open a terminal.
2. Navigate to the project directory with `cd path/to/project`.
3. Run the tests with the following command:

```bash
bats tests/
```

This command runs all Bats tests located in the `tests/` folder. The output shows the results of each test. If a test passes, you'll see a line with a check mark and the test description. 

If a test fails, you'll see a line with an "X" and the test description, along with an error message explaining what went wrong.

Currently there are 9 test cases and these will be added to and be used as part of a continuous integration setup when changes are merged into main.

Here's an example of what the output might look like:
```
~/word-count-example$ bats tests/
 ✓ Test with a regular file 
 ✓ Test with a same regular file in different order 
 ✓ Test with special characters 
 ✓ Test with empty file 
 ✓ Test with non-existing file 
 ✓ Test with hyphens and punctuation 
 ✓ Test with special characters and unicode characters 
 ✓ Test against large files 
 ✓ Test with special characters and numbers 

9 tests, 0 failures
```
In this example, all tests passed.