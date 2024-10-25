#!/usr/bin/env python3
""" script defines a tuple, with brid species latin name, common name and mass. 
    the script then iterates over the tupe and prints the details of each bird.
"""


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by
# species 
# 
# A nice example output is:
# 
# Latin name: Passerculus sandwichensis Common name: Savannah sparrow Mass: 18.7
# ... etc.

for latin_name, common_name, mass in birds:
    print ("latin name: ", latin_name, "common name: ", common_name, "bird mass: ", mass)
