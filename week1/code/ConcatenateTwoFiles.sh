#!/bin/bash


#check that 2 files have been imported
if [ "$#" -ne 2 ]; then 
    echo "Import 2 files"
    exit 1
    
fi 

echo "you have imported "$1" and "$2""

# check that both files exist
if [ ! -f "$1" ]; then
    echo "The first file input is not a valid file" 
    exit 1
fi 


if
    [ ! -f "$2" ]; then
    echo "The second file input is not a valid file" 
    exit 1
fi 

#create a new file to put 2 combines files in
output_file="output.txt"
touch "$output_file"

cat "$1" > "$output_file"
cat "$2" >> "$output_file"

cat "$output_file"
exit 0

