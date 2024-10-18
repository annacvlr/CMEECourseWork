#!/bin/bash

## the script automates processng of LaTeX files into PDF, handling bibliographic processing & cleaning up of 
## temporary files.

## Error handling is used to avoid errors that rise if files are missing.
if ["$#" -ne 1]; then
    echo "no filename argument is provided"
    exit 1
fi

if [! -f "$1.tex" ]; then  
    echo "The file '$1.tex' does not exist"
    exit 1
fi 


pdflatex "$1.tex" # compiles LaTeX file & checks that the command worked successfully
if [$? -ne 0]; then
    echo "pdflatex failed for '$1.tex'"
    exit 1
fi 


bibtex $1 # runs bibtex
if [$? -ne 0]; then
    echo "bibtex failed for '$1.tex'"
    exit 1
fi 

pdflatex $1.tex #recompiles
if [$? -ne 0]; then
    echo "pdflatex failed for '$1.tex'"
    exit 1
fi 

pdflatex $1.tex # recompiles 
if [$? -ne 0]; then
    echo "pdflatex failed for '$1.tex'"
    exit 1
fi 

evince $1.pdf & #opens generated pdf

##cleanup of temporary files
rm *.aux
rm *.log
rm .*bbl
rm .*blg
