#!/usr/bin/env bats

setup() {
    # This function runs before each test
    temp_file=$(mktemp)
}

teardown() {
    # This function runs after each test to clean up
    rm -f "$temp_file"
}

@test "Test with a regular file" {
  # Create a temporary test file
  echo "hello world's cat's mat." > "$temp_file"
  # Run your script with the temporary file
  run bash count.sh "$temp_file"
  # Test output
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Total word count: 4" ]
  [ "${lines[2]}" = "Total unique word count: 4" ]
  [ "${lines[3]}" = "No.   Word                      Occurrences" ]
  [ "${lines[4]}" = "1.    world                     1" ]
  [ "${lines[5]}" = "2.    mat                       1" ]
  [ "${lines[6]}" = "3.    hello                     1" ]
  [ "${lines[7]}" = "4.    cat                       1" ]
}

@test "Test with a same regular file in different order" {
  echo "world's hello mat. cat's" > "$temp_file"
  # Run your script with the temporary file
  run bash count.sh "$temp_file"
  # Test output
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Total word count: 4" ]
  [ "${lines[2]}" = "Total unique word count: 4" ]
  [ "${lines[3]}" = "No.   Word                      Occurrences" ]
  [ "${lines[4]}" = "1.    world                     1" ]
  [ "${lines[5]}" = "2.    mat                       1" ]
  [ "${lines[6]}" = "3.    hello                     1" ]
  [ "${lines[7]}" = "4.    cat                       1" ]
}

@test "Test with special characters" {
  echo "world's hello! mat. cat's john,smith?" > "$temp_file"
  # Run your script with the temporary file
  run bash count.sh "$temp_file"
  # Test output
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Total word count: 6" ]
  [ "${lines[2]}" = "Total unique word count: 6" ]
  [ "${lines[3]}" = "No.   Word                      Occurrences" ]
  [ "${lines[4]}" = "1.    world                     1" ]
  [ "${lines[5]}" = "2.    smith                     1" ]
  [ "${lines[6]}" = "3.    mat                       1" ]
  [ "${lines[7]}" = "4.    john                      1" ]
  [ "${lines[8]}" = "5.    hello                     1" ]
  [ "${lines[9]}" = "6.    cat                       1" ]
}

@test "Test with empty file" {
  # Run your script with the empty file
  run bash count.sh "$temp_file"
  # Check the outputs
  [ "$status" -eq 0 ]
  [ "${lines[1]}" = "Total word count: 0" ]
  [ "${lines[2]}" = "Total unique word count: 0" ]
}

@test "Test with non-existing file" {
  # Use a definitely non-existing file path
  run bash count.sh "/path/that/does/not/exist"
  # Check the outputs
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Error: File does not exist." ]
}

@test "Test with hyphens and punctuation" {
    echo "state-of-the-art high-quality it's isn't end." > "$temp_file"
    run bash count.sh "$temp_file"
    [ "$status" -eq 0 ]
    [ "${lines[2]}" = "Total unique word count: 9" ]
    # Clean up
    rm "$temp_file"
}

@test "Test with special characters and unicode characters" {
    echo "café naïve 💖" > "$temp_file"
    run bash count.sh "$temp_file"
    [ "$status" -eq 0 ]
    [ "${lines[2]}" = "Total unique word count: 2" ]
}

@test "Test against large files" {
    # generate test file with numbers to 10,000 each on new line
    seq 10000 > "$temp_file"
    run bash count.sh "$temp_file"
    [ "$status" -eq 0 ]
    [ "${lines[1]}" == "Total word count: 10000" ]
}

@test "Test with special characters and numbers" {
    echo "hello123 goodbye! #amazing" > "$temp_file"
    run bash count.sh "$temp_file"
    [ "$status" -eq 0 ]
    [ "${lines[2]}" = "Total unique word count: 3" ]
}