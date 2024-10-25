#!/usr/bin/env python3
# Filename: using_name.py


""" how to use the __name__ special variable to determine whether a module is being run directly or imported into another script"""

if __name__ == '__main__':
    print('this program is being run by itself')
else:
    print('I am being imported from another script/program/module')

print ("this modules name is:" + __name__)
