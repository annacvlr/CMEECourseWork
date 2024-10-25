#!/usr/bin/env python3
"""
The Script provides different functions that complete mathematical results, docstring tests have been included
"""

__author__ = 'Anna Cavalieri (ac524@ic.ac.uk)'
__version__ = '0.01'

import sys
import doctest


#define the functions first
def foo_1(x):
    """ find the Sqrt

    >>> foo_1(9)
    3.0

    """
    return x ** 0.5



def foo_2(x, y):
    """ find which number is bigger

    >>> foo_2(10,20)
    20

    """

    if x > y:
        return x
    return y

foo_2(3,5)


def foo_3(x, y, z):
    """ give the numbers in order

    >>> foo_3(10,20,5)
    [5, 10, 20]

    """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    if x > y:
        tmp = x
        x = y
        y = tmp
    return [x, y, z]

def foo_4(x):
    """ give the factorial

    >>> foo_4(5)
    120
    
    """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x): # a recursive function that calculates the factorial of x
    """ give the factorial of x

    >>> foo_5(5)
    120

    """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result
    if x == 1:
        return 1
    return x * foo_5(x - 1)
     
def foo_6(x): # Calculate the factorial of x in a different way; no if statement involved
    """ give the factorial of x

    >>> foo_6(5)
    120
    
    """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result
    if x == 1:
        return 1
    return x * foo_5(x - 1)
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto


""" define main & create user inputs for each function """

def main(argv):
    print("Test with argument 10:")
    print("foo_1(10):", foo_1(10))
    print("foo_2(10):", foo_2(10,20))
    print("foo_3(10):", foo_3(10,20,30))
    print("foo_4(10):", foo_4(10))
    print("foo_5(10):", foo_5(10))
    print("foo_6(10):", foo_6(10))

    #FOR THE USER TO ACTUALLY INPUT STUFF THE FOLLOWING CODE WOULD WORK FOR EACH FUCNTION
    #try:
       # user_input = float(input("enter a number for factorial calculations:"))
       # print("foo_1:", foo_1(user_input))


       # x = float(input ("Enter first number for foo_2:  "))
        #y = float(input("Enter second number for foo_2:  "))

        #print("foo_2:", foo_2(x, y))


        #x2 = float(input ("Enter first number for foo_3:  "))
        #y2 = float(input("Enter second number for foo_3:  "))
        #2 = float(input("Enter thrid number for foo_3:  "))
        #print("foo_3:", foo_3(x2, y2, z2))  # Use user_input as z

        #user_input4 = float(input("enter a number for factorial calculations:"))
        #print("foo_4:", foo_4(int(user_input4)))


        #user_input5 = float(input("enter a number for factorial calculations:"))
        #print("foo_5:", foo_5(int(user_input5)))


        #user_input6 = float(input("enter a number for factorial calculations:"))
        #print("foo_6:", foo_6(int(user_input6)))

 
    #except ValueError:
     #   print("Please enter a valid number.")
      #  return 1

    return 0



doctest.testmod()



if(__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
