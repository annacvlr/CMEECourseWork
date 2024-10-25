#!/usr/bin/env python3
import csv
# csv module permits reading and writing to CSV files
""" read a csv file with species data, process each row to extract specoes name & create a new CSV file 
    called bodymass.csv with species name and body mass
"""


with open('../Documents/CMEECourseWork/week2/data/testcsv.csv','r') as f:
    csvread = csv.reader(f)
#open the testcsv.csv & read it 


temp =[]
for row in csvread:
    temp.append(tuple(row))
    print(row)
    print("the species is", row[0])
#loop iterating over each row - each row is converted to a tuple & appended to temp list
#prints first element (species name) and entire row

    
with open('../Documents/CMEECourseWork/week2/data/testcsv.csv','r') as f:
    with open('../Documents/CMEECourseWork/week2/data/bodymass.csv','w') as g:

        csvread = csv.reader(f)
        csvwrite = csv.writer(g)
        for row in csvread:
            print(row)
            csvwrite.writerow([row[0], row[4]])

#opens testcsv.csv (reading r) and bodymass.csv (writing w)
# creates writer object to write a new file 
#
