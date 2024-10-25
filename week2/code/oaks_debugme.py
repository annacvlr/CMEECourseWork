#!/usr/bin/env python3
""" This script reads a CSV file with plant taxonomy data, it then checks if each genus is "Quercus",
    oak, and writes the results in a new CSV file in the Results folder. 


"""

import csv
import sys
import ipdb
import doctest
#Define function
def is_an_oak(name):
    """
    >>> is_an_oak('Fraxinus')
    False

    >>> is_an_oak('Quercus')
    True
    """
    """ Returns True if name is starts with 'quercus' """
    return name.lower() == 'quercus'
   

def main(argv): 
    with open('../data/TestOaksData.csv','r') as f, open('../results/JustOaksData.csv','w') as g:
        taxa = csv.reader(f)
        csvwrite = csv.writer(g)
        csvwrite.writerow(['Genus', ' species'])  # Add the headers you want in the output file


        next(taxa) #skips the header
        oaks = set()

        for row in taxa:
            #import ipdb; ipdb.set_trace()
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')

            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])
            else:
                print("False"+'\n')

            

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod(verbose=True)
