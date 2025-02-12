#!/usr/bin/env python3

"""Script includes functions to perform mathematical operations, 
    such as identifying if a number is odd or even, if its prime etc..."
"""

__appname__ = ' [application name here] '
__author__ = 'Anna Cavalieri (ac524@ic.ac.uk)'
__version__ = '0.01'
__license__ = 'license for this code/program'

##imports
import sys



def even_or_odd(x=0):
    """find whether a number is even?odd"""
    if x % 2==0:
        return f"{x} is Even"
    return f"{x} is Odd"


"""find which is the largest divisor of x among 2,3,4,5."""
def largest_divisor_five (x=120):
   
    largest = 0 
    if x % 5 == 0:
        largest = 5
    elif x % 4 ==0: #else if 
        largest = 4
    elif x % 3 == 0:
        largest = 3
    elif x % 2 ==0:
        largest = 2
    else: #when all if elf conditions are not met 
        return f"No divisor found for {x}"  #each function can return a value/variable"
    return f"the largest divisor of {x} is {largest}"



""" find if number is prime"""
def is_prime (x=70):
    for i in range(2,x): 
        if x % i == 0:
            print(f"{x} is not a prime: {i} is a divisor")
            return False
    print (f"{x} is a prime")
    return True

"""find all primes up to x"""
def find_all_primes(x=22):
    allprimes = []
    for i in range(2, x+1):
        if is_prime(i):
            allprimes.append(i)
    print(f"There are {len(allprimes)} primes between 2 and {x}")
    return allprimes

def main(argv):
    print(even_or_odd(22))
    print(even_or_odd(33))
    print(largest_divisor_five(120))
    print(largest_divisor_five(121))
    print(is_prime(60))
    print(is_prime(59))
    print(find_all_primes(100))
    return 0

if(__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)

#f"test string{variable} -- best incorporating variables in a string 