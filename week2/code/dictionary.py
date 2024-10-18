taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]



# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.

#taxa_dict = dict(taxa)
#print(taxa_dict)

# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. 
# OR, 
# 'Chiroptera': {'Myotis  lucifugus'} ... etc

"""make a dictionary 
of species in their orders"""

taxa_dict={}
for species, order in taxa:
        if order not in taxa_dict:
                taxa_dict[order]=set()
                taxa_dict[order].add(species)
        else:
                taxa_dict[order].add(species)
print(taxa_dict)
#### Your solution here #### 

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
taxa_dict={}
{taxa_dict.setdefault(order, set()).add(species) for species, order in taxa}
print(taxa_dict)

