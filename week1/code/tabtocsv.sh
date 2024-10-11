#!/bin/sh
# Author: Your name you.login@imperial.ac.uk
# Script: tabtocsv.sh
# Description: substitute the tabs in the files with commas
#
# Saves the output into a .csv file
# Arguments: 1 -> tab delimited file
# Date: Oct 2019

#echo "Creating a comma delimited version of $1 ..."
#cat $1 | tr -s "\t" "," >> $1.csv
#echo "Done!"
#exit

#improved script

#check that 1 file has been imported
if [ "S#" -ne 1 ]; then 
    echo "Import 1 file"
    exit 1
fi 

# check that the file is an existing file
if [ ! -f "$1" ]; then
    echo "There is no file" 
    exit 1
fi 
 
#convert the tab file to csv
    echo "Creating a comma delimited version of $1 ..."
    cat "$1" | tr -s "\t" "," >> "${1}.new.csv"
    echo "Done!"
    exit 0


