#!/usr/bin/env bats

# Load a helper library if needed

@test "Test with a regular file" {
  # Create a temporary test file
  temp_file=$(mktemp)
  echo "hello world's cat's mat." > "$temp_file"

  # Run your script with the temporary file
  run bash count.sh "$temp_file"
  
  # Test output
  [ "$status" -eq 0 ]
  [ "${lines[2]}" = "Total word count: 4" ]
  [ "${lines[3]}" = "Total unique word count: 4" ]
  [ "${lines[5]}" = "No.   Word                     Occurrences" ]
  [ "${lines[6]}" = "1.    world                    1" ]
  [ "${lines[7]}" = "2.    mat                      1" ]
  [ "${lines[8]}" = "3.    hello                    1" ]
  [ "${lines[9]}" = "3.    cat                      1" ]
  
  # Clean up
  rm "$temp_file"
}

@test "Test with empty file" {
  # Create an empty temporary file
  temp_file=$(mktemp)

  # Run your script with the empty file
  run bash count.sh "$temp_file"

  # Check the outputs
  [ "$status" -eq 0 ]
  [ "${lines[2]}" = "Total word count: 0" ]
  [ "${lines[3]}" = "Total unique word count: 0" ]

  # Clean up
  rm "$temp_file"
}

@test "Test with non-existing file" {
  # Use a definitely non-existing file path
  run bash count.sh "/path/that/does/not/exist"

  # Check the outputs
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Error: File does not exist." ]
}
