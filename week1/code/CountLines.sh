#!/bin/bash


#check that 1 file has been called amd then counting the # of lines
if [ $# -eq 1 ]; then 
    NumLines=`wc -l < $1`
    echo "The file $1 has $NumLines lines"
else
    echo "Import 1 file"
    
fi 


