#!/usr/bin/env python3

""" code serves a boilerplate, adding more functionality, documentation and error handling.
"""

__appname__ = ' [application name here] '
__author__ = 'Anna Cavalieri (ac524@ic.ac.uk)'
__version__ = '0.01'
__license__ = 'license for this code/program'

##imports
import sys

def main(argv):
    """ main entry point of program"""
    print('This is a boilerplate')
    return 0

if __name__ == "__main__":
    """make sure main function called from command line"""
    status = main(sys.argv)
    sys.exit(status)