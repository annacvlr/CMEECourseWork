#!/usr/bin/env python3
"""script reads a text file line by line printing each line, 
    the second part skips blank lines
    """


#open a file to read
f = open('../Documents/CMEECourseWork/week2/sandbox/test.txt', 'r')
# use "implicit" for loop:
# if the object is a file, python will cycle over lines
for line in f:
    print(line)

# close the file
f.close()

# Same example, skip blank lines
f = open('../Documents/CMEECourseWork/week2/sandbox/test.txt', 'r')
for line in f:
    if len(line.strip()) > 0:
        print(line)

f.close()





# Open a file for reading
with open('../sandbox/test.txt', 'r') as f:
    # use "implicit" for loop:
    # if the object is a file, python will cycle over lines
    for line in f:
        print(line)

# Once you drop out of the with, the file is automatically closed

# Same example, skip blank lines
with open('../sandbox/test.txt', 'r') as f:
    for line in f:
        if len(line.strip()) > 0:
            print(line)
