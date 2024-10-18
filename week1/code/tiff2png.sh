#!/bin/bash


if [ ! -f "$1" ]; then  
   echo "The file '$1' does not exist"
   exit 1
fi 

for f in *.tif; do  
        echo "Converting $f"; 
        convert "$f"  "$(basename "$f" .tif).png"; 
done
