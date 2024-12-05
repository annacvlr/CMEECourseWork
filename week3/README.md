# CMEE bootcamp Week3
Week 3 coursework of the Biological Computing Bootcamp.

## Description
Week 3 covered
        - Coding in R including: 
        - Data Management and Visualisation including: data wrangling, handling big data, data visualisation, and graphics in R. 
        - Using Python to build workflows including: subprocesses. 


## Languages 
Python
R
    
## Dependencies
**ipdb** : for enhanced debugging
**tidyverse** : to use ggplot and melt
**Jupyter** : to create online files with code and writing
 

  

## Installation
pip install ipdb
pip install jupyter
    

## Project Structure and Usage
- Code: Contains Python files
- Data: Where all the data used has been collected
- Results: Contains the results from the code. 


## Code
**apply1.R**:Performs statistical calculations on a randomly generated matrix.

**apply2.R**:Defines a function and demonstrates its application on a matrix.

**basic_io.R**:Handles and writes CSV files.

**boilerplate.R**:Creates a function that takes two arguments, prints their information and returns a combined vector.

**break.R**:Demonstrates how to break out of a loop using a WHILE loop.

**browse.R**:Debugging.

**control_flow.R**:Demonstrates various various control structures: conditional statements, for loops, and while loops.

**DataWrang.R**:Wrangling PoundHill dataset.

**Florida.R**:This R script analyzes the relationship between the year and temperature from the Key West Annual Mean Temperature dataset using a permutation test. It calculates the observed correlation coefficient and performs 10,000 random shuffles of the temperature data to evaluate the likelihood of observing this correlation by chance.

**Girko.R**:Visualise eigenvalues of a random matrix in relatoin to an ellpisem illustrating Girko's Circular law.

**MyBars.R**: Creates a bar chart on the data Results.txt and creates a pdf.

**MyFirstJupyterNB.ipynb**:A Jupyter Notebook with two different plots, using p.plot and qplot.

**next.R**: For loop that checks if number is odd using %% modulo and prints if it is.

**plotLin.R**:Creates a linear regression data and creates a pdf from it. 

**PoundHill.R**:Reads a CSV file into a dataframe and converts it into a matrix.

**PP_Regress.R**: This R script performs linear regression analysis on ecological data to explore the relationship between predator and prey masses, categorized by feeding type and predator life stage. The results are saved in a CSV file, and a visual summary of the regression lines and data points is generated in a PDF file.

**preallocate.R**:Compares the performance of two functions, one without preallocated memory for a vector and one with. 

**R_conditionals.R**:Three functions that demonstrate how to use conditionals to check properties of numbers.

**sample.R**:Defines multiple functions to calculate the mean of random samples from a population and compares the execution time of different sampling methods, including loops with and without preallocation, as well as vectorized approaches using lapply and sapply.

**TestR.py**:Using subprocess package to run an R script (Test.R) and redirects the output and error messages to specified files"""

**TestR.R**:Prints "Hello, this is R!"

**TreeHeight.R**Function calculates the heights of trees given the distance of each tree from its base and angle to its top.

**try.R**:Function runs a simulation that involves sampling from a synthetic population w replacement and takes its mean but only if at least 30 unique samples are obtained.

**Vectorize1.R**:creates a large 1000x1000 matrix of random numbers, defines a function to compute the sum of all its elements using nested loops, and measures the execution time for this loop-based approach versus using the built-in vectorized sum function.


## Author
   Anna Cavalieri Canosa
    	ac524@ic.ac.uk

