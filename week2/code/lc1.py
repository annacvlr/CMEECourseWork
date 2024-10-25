#!/usr/bin/env python3
"""
    script extracts latin names, common names, and mean mass from tuple of bird data using list comprehensions and loops
"""


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )
#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

"""make 3 different lists from this one tuple
    1) using list comprehension
    2) using for loops """


latinspecies= [bird[0] for bird in birds]
print(latinspecies)

commonname= [bird[1] for bird in birds]
print(commonname)
    
meanbodymass= [bird[2] for bird in birds]
print(meanbodymass)

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

latinspecies = []
for bird in birds:
    latinspecies.append(bird[0])
print("The latin names of the species are:", latinspecies)

commonname = []
for bird in birds:
    commonname.append(bird[1])
print("The common names are:", commonname)

meanbodymass = []
for bird in birds:
    meanbodymass.append(bird[2])
print("The mean body masses are", meanbodymass)


# A nice example out out is:
# Step #1:
# Latin names:
# ['Passerculus sandwichensis', 'Delichon urbica', 'Junco phaeonotus', 'Junco hyemalis', 'Tachycineata bicolor']
# ... etc.
 
