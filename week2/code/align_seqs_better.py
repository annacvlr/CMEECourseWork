"""A script which takes two DNA sequences from a .csv file, finds alignments between them, and prints the result in a text file"""
#imports
import csv

#reading in data into a list called seq
with open('03_Cool_Coatis/data/Sequence.csv', 'r') as f:
    csvread = csv.reader(f)
    seq = []
    for row in csvread:
        seq.append(row)

# splitting the two sequences up and turing them into strings
seq2 = seq[0][0]
seq1 = seq[1][0]

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """
    Computes the score by comparing two sequences (s1 and s2) starting from an arbitrary start point.
    
    Parameters:
    s1 (str): The longer sequence.
    s2 (str): The shorter sequence.
    l1 (int): Length of the longer sequence.
    l2 (int): Length of the shorter sequence.
    startpoint (int): The start point in the longer sequence where the alignment begins.

    Returns:
    int: The score (number of matching bases) for the alignment at the given start point.
    """
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences, save the alignment to a list
my_best_align = []
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z == my_best_score:
        my_best_align.append("." * i + s2) # the number of "." before the allignment shows where along the sequence the allignment is
    elif z > my_best_score:
        my_best_align = []
        my_best_align.append("." * i + s2)  
        my_best_score = z 


#write the best score and alignment into a text file
g = open("03_Cool_Coatis/results/best_align.txt","w")
g.write("Best allignments:")
g.write(','.join(my_best_align) + '\n') 
g.write("Best score:")
g.write(str(my_best_score) + "\n")
g.write("Aligned with the sequence:")
g.write(s1)
g.close()


