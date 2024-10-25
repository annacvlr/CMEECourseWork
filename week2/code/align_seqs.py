#!/usr/bin/env python3
"""
    This script determines the best alignment of 2 sequences saves the results to a file.
"""



import csv
import doctest

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
def read_sequences():
    with open('../data/sequences.csv','r') as file:
        read = csv.DictReader(file)
        for row in read:
            return row['seq1'], row['seq2']

seq1, seq2 = read_sequences()       
seq2
#seq1
#test if seq1 is right


"""Order the longest sequence to stay infront"""

l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2: #if seq1 is longer keep it there
    s1 = seq1
    s2 = seq2
else: #if seq2 is longer swap the two
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 


#test that s1 is the longest sequence
#s1
#s2

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)

"""function that aligns the sequences and compares the counts"""
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0 #starts at zero and counts the number of matching bases
    for i in range(l2): #go thru the range of s2 (which is l2 long)
        if (i + startpoint) < l1: # match within s1 length (l1)
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    #print("." * startpoint + matched)           
    #print("." * startpoint + s2)
    #print(s1)
    #print(score) 
    #print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences
my_best_align = None
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z > my_best_score:
        my_best_align = "." * i + s2 # think about what this is doing!
        my_best_score = z 
print(my_best_align)
print(s1)
print("Best score:", my_best_score)


with open('../results/alignment.txt', 'w' ) as f:
    f.write("My best align is:" + my_best_align + '\n')
    f.write( s1 + '\n')
    f.write(f"best score: {my_best_score}")

