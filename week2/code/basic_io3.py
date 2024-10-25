#!/usr/bin/env python3
"""
    Demonstrates how to save and load a python dictionary using the pickle module

"""


# To save an object (even complex) for later use
my_dictionary = {"a key": 10, "another key": 11}

import pickle

f = open('../sandbox/test.txt,'wb') ## note the b: accept binary files
pickle.dump(my_dictionary, f)
f.close()

## Load the data again
f = open('../sandbox/test.txt','rb')
another_dictionary = pickle.load(f)
f.close()

print(another_dictionary)

with open('../Documents/CMEECourseWork/week2/sandbox/test.txt', "r") as myfile:
    # do things to myfile
    ...
    
