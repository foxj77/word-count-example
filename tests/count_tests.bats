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
  [ "${lines[1]}" = "Total word count: 4" ]
  [ "${lines[2]}" = "Total unique word count: 4" ]
  [ "${lines[3]}" = "No.   Word                      Occurrences" ]
  [ "${lines[4]}" = "1.    world                     1" ]
  [ "${lines[5]}" = "2.    mat                       1" ]
  [ "${lines[6]}" = "3.    hello                     1" ]
  [ "${lines[7]}" = "4.    cat                       1" ]
  
  # Clean up
  rm "$temp_file"
}

@test "Test with a same regular file in different order" {
  # Create a temporary test file
  temp_file=$(mktemp)
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
  
  # Clean up
  rm "$temp_file"
}

@test "Test with special characters" {
  # Create a temporary test file
  temp_file=$(mktemp)
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
  [ "${lines[1]}" = "Total word count: 0" ]
  [ "${lines[2]}" = "Total unique word count: 0" ]

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
