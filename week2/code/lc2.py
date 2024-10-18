# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
""" Make a list w the month and the amount of rain, where rain was above 100mm. use a for and an if"""
rainy_months = [(month, rain) for month, rain in rainfall if rain >100]
print("Each month had the following mm of rainfall above 100mm:", rainy_months)

 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

not_rainy_months = [(month, rain) for month, rain in rainfall if rain <50]
print("Each month had the following mm of rainfall below 50mm:", not_rainy_months)


# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

rainy_months1 = []
for month,rain in rainfall:
    if rain > 100:
        rainy_months1.append((month, rain))
print ("Each month had the following mm of rainfall above 100mm:", rainy_months1)

not_rainy_months1 = []
for month,rain in rainfall:
    if rain <50 :
        not_rainy_months1.append((month, rain))
print ("Each month had the following mm of rainfall below 50mm:", not_rainy_months1)



# A good example output is:
#
# Step #1:
# Months and rainfall values when the amount of rain was greater than 100mm:
# [('JAN', 111.4), ('FEB', 126.1), ('AUG', 140.2), ('NOV', 128.4), ('DEC', 142.2)]
# ... etc.

