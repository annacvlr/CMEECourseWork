## My CMEE bootcamp Course Work

## Description
- Week 1 covered Shell Scripting bash and Git Version Control.
- Week 2 covered Python in general including: variables, data structures, loops, conditionals, comprehensions, functions, docstrings and debugging.
- Week 3 covered
       - Coding in R including: 
       - Data Management and Visualisation including: data wrangling, handling big data, data visualisation, and graphics in R. 
       - Using Python to build workflows including: subprocesses. 

## Languages 
- shell script
- plain txt
- Python
- R
- LaTeX

## Dependencies
ipdb : For enhanced debugging.
lubridate: For date handling and formatting.
dplyr: For data manipulation.
tidyr: For data tidying.
ggplot2: For plotting. 
WebPower: For statistical analysis. 
MASS: Modern Applied Statistics with S) is a package that provides functions for a wide range of statistical techniques, including linear and nonlinear modeling, classification, resampling, and more. It is often used for advanced statistical analyses and regression modeling.
ggpubr: extension to ggplot2, it provides additional functions to quickly add statistical annotations, customize plot themes, and adjust figure aesthetics.
mgcv: For fitting generalized additive models.
sjPlot: For exporting regression tables as images.
forecast: For time-series analysis with ARIMA models.
Jupyter : to create online files with code and writing

## Installation
pip install ipdb
pip install jupyter

## Project Structure and Usage
- Code: Contains script files.
- Data: Where all the data used has been collected.
- Results: Contains the results.

## Code

###week1
**CompileLaTeX.sh**: This script automates the compilation of LaTeX files into PDFs, processes bibliographic references with BibTeX, and cleans up temporary files. The main objective is to streamline the LaTeX workflow, including error handling and temporary file management, for efficient document preparation.
- File Existence Check: The script first checks if exactly one argument (the LaTeX file name) is provided. If not, it exits with an error message. It then ensures the existence of the specified .tex file before proceeding with any compilation steps.
- LaTeX Compilation: Using pdflatex, the script compiles the .tex file to generate a PDF. It runs pdflatex multiple times to ensure that all references and citations are correctly processed. After each compilation step, the script checks for errors, and if any command fails, it stops execution and displays an error message.
- Bibliographic Processing with BibTeX: After the initial LaTeX compilation, BibTeX is run to process the bibliography, creating the necessary .bbl file. The script verifies that BibTeX executes successfully before continuing.
- Multiple Re-compilations: To ensure that all LaTeX references (including citations and table of contents) are properly updated, the script runs pdflatex two more times following the BibTeX step.
- PDF Viewing: Once the PDF is generated, the script automatically opens it using the evince viewer for immediate inspection.
- Cleanup: After the successful generation of the PDF, the script deletes temporary files such as .aux, .log, .bbl, and .blg, ensuring that the working directory remains clean.
- This script simplifies the process of compiling LaTeX documents, reduces the chances of errors in compilation, and automates repetitive tasks, improving workflow efficiency for users working with LaTeX documents.


**boilerplate.sh**: This is a simple boilerplate shell script designed to serve as a template for starting new shell scripting projects. The primary goal is to provide a structured framework, making it easier to create and manage shell scripts.
- Script Header: The script begins with a header that includes the author's name, email, script name, a brief description of the script, and the date of creation. This helps with documentation and provides metadata about the script, making it easier to understand its purpose and origin.
- Echo Command: The core functionality of the script is to print a message to the terminal. Using the echo command, it outputs a simple message: "This is a shell script!". The -e flag is used with echo to enable the interpretation of escape sequences, allowing for the inclusion of newline characters in the output.
- Exit: Although commented out, the script includes an exit command at the end. This can be used to terminate the script gracefully. This step ensures that any further commands would not execute unless the exit condition is removed.
- This basic boilerplate script can be extended with more complex logic or additional functionality, such as argument parsing, error handling, and looping constructs, depending on the needs of the user.

**ConcatenateTwoFiles.sh**: This script automates the process of verifying the input files, combining their contents, and outputting the result to a new file. The goal is to ensure that the user has provided two valid, non-empty files, and if so, combine them into a new file.
- File Input Validation: The script starts by checking if exactly two arguments (representing file names) are passed. If the condition fails, it prints an error message and terminates the script. This prevents the user from proceeding without the required input files.
- File Existence Check: After confirming the number of arguments, the script checks if each of the provided files exists. If any of the files does not exist, it prints an error message and exits the script. This ensures that the user does not try to process non-existent files.
- Empty File Check: The script further checks if either of the provided files is empty using the -s test. If either file is empty, an error message is shown, and the script stops execution. This helps avoid processing files that might not contain useful data.
- File Concatenation: Once the files pass all checks, the script creates a new file (output.txt). It concatenates the content of the first file followed by the content of the second file into the output file using the cat command. The result is then printed to the terminal.
- Exit: The script terminates gracefully with exit 0 after performing all tasks successfully, ensuring the user knows the process has completed.
- This script can be modified to include further validation or enhanced features, such as error handling for file permissions or user prompts.

**CountLines.sh**:This script is designed to check if a file is provided as an argument and then count the number of lines in that file. The objective is to ensure that the user has specified a valid file and then provide information about how many lines it contains.
- File Argument Validation: The script first checks if exactly one argument (the file name) is provided. If the condition is met, it proceeds to count the lines of the file. If no file is provided, or more than one file is specified, it prints an error message instructing the user to import exactly one file.
- Counting Lines: If a valid file is provided, the script uses the wc -l command to count the number of lines in the file. The < $1 syntax ensures that only the contents of the file are passed to the wc command, and not the file name itself. It then stores the result in the variable NumLines and prints the number of lines in the file.
- Handling Missing or Multiple Files: If no file or multiple files are provided, the script prints a message asking for exactly one file to be provided.
- This script is simple yet useful for basic file analysis tasks. It ensures that users can quickly assess the size of a file (in terms of lines) and can be expanded to handle different types of file processing or additional error checks, such as verifying that the file exists.

**csvtospace.sh**:This script automates the process of converting CSV (Comma Separated Values) files into SSV (Space Separated Values) format. It checks if the directory containing the CSV files exists, and then performs the conversion by replacing commas with spaces in each CSV file found in that directory.
- Directory Check: The script first checks if the ../data/temperatures directory exists. If the directory does not exist, it outputs "there is no directory." If the directory is found, it outputs "there is a directory."
- File Conversion Process: The script uses the tr command, which is used to translate characters, to replace commas with spaces in each CSV file. It iterates over each .csv file found in the specified directory (../data/temperatures/). The basename command is used to extract the filename without its extension, and the new .ssv file is created in the same directory with a space-separated format.
- Handling Missing Files: If no CSV files are found in the specified directory, the script outputs "no CSV files in directory."
- Final Message: After all files are processed, the script outputs a message confirming that the CSV files have been successfully converted into SSV files.
- This script provides a simple way to batch convert multiple CSV files into SSV format for further processing or analysis. It is useful for tasks that require a space-separated format instead of commas, such as some types of data input for specific applications or systems.

**FirstBiblio.bib**:This BibTeX entry refers to Pierre-François Verhulst's seminal 1838 article titled "Notice sur la loi que la population suit dans son accroissement", which was published in the journal Corresp. Math. Phys. (Volume 10, pages 113–126). The paper marks a key development in the study of population dynamics, introducing the Logistic Growth Model, which mathematically describes how populations grow under limited resources, ultimately stabilizing as they approach a carrying capacity. 

**MyExampleScript.sh**:hello_user.sh: This script is a simple shell script that demonstrates basic usage of shell variables and the echo command in bash. The script outputs a personalized greeting message based on the system's username.
- Variables: The script defines two variables:
MSG1: A string with the value "Hello".
MSG2: A variable that retrieves the current system's username, $USER.
- Output: The script prints a greeting message to the terminal. It combines the value of MSG1 and MSG2 to output "Hello <username>", where <username> is replaced with the current user's system username.
Additionally, it also prints another greeting message using the USER environment variable directly.
- Basic Concept: This script is a basic demonstration of how to use environment variables ($USER) and custom variables (like MSG1 and MSG2) in shell scripts, along with simple string concatenation and output using echo.
    
**tabtocsv.sh**:tabtocsv.sh: This script is designed to convert a tab-delimited file into a comma-separated values (CSV) file. The process involves replacing tab characters with commas and saving the output into a new .csv file.
- Input File Check: The script begins by verifying that exactly one argument (the file path) is provided. If the argument count is not 1, it prompts the user to provide a file and exits.
- File Existence Check: It ensures that the input file exists. If the file is not found, the script will output an error message and exit.
- Tab-to-Comma Conversion: Once the input file is validated, the script proceeds with the conversion. It reads the file, replaces all tab characters (\t) with commas using the tr command, and saves the result into a new .csv file with the same name as the original but appending .new.csv to it.
- Output: After conversion, the script outputs a success message indicating the creation of the new comma-delimited CSV file.
- Error Handling: The script includes basic error handling to ensure that the correct file is provided and that the conversion process can proceed without issues.

**tiff2png.sh**: This script converts all .tif files in the current directory into .png files using the convert command from the ImageMagick software suite. It also checks if the specified input file exists.
- Input File Check: The script first checks if the specified input file exists. If the file does not exist, it outputs an error message and exits.
- Converting .tif to .png: After the initial check, the script processes all .tif files in the current directory. For each .tif file, it prints a message stating that the file is being converted, then uses the convert command to create a .png version of the file. The new file name is derived by removing the .tif extension and adding .png instead.
- Error Handling: If the input file doesn't exist, the script terminates early with an error message. However, if .tif files are found, the script proceeds with the conversion process.
- Output: The result of the conversion is a new .png file for each .tif image in the directory. The names of the new files match the original .tif files, with only the extension changed to .png.

**UnixPrac1.txt**:This script is useful for bioinformatics tasks, providing insight into sequence lengths, base pair composition, and the presence of specific subsequences. It can be particularly useful for genomic data analysis, allowing for efficient extraction and analysis of key statistics from FASTA files.

**variables.sh**: This script demonstrates how to use and manipulate variables in a shell script. It covers both special variables, which provide information about the script execution, and user-defined variables, which allow you to store and use custom values within the script.

###week2 
**align_seqs.py**: Aligns two DNA sequences and determines the best alignment score using a scoring system. 

**basic_csv.py**: Reads a CSV file to extract and display species name along with their body mass. 

**basic_io1** Reads a text file line by line printing each line, the second part skips blank lines.

**basic_io2** Saves the elements of a list to a file.

**basic_io3** Demonstrates how to save and load a python dictionary using the pickle module.

**Boilerplate.py**: Code serves a boilerplate, adding more functionality, documentation and error handling.

**cfexercises1.py**: Implements mathematical functions such as  calculating square roots, finding maximums, sorting lists, and computing factorials.

**cfexercises2.py**: Functions that print "hello" based on various conditions and loop structures.

**control_flow.py**: Functions that perform mathematical operations, such as identifying if a number is odd or even, if its prime etc...

**debugme.py**: Demonstrates error handling techniques using try/except blocks, showcasing common error scenarios.

**dictionary.py**: Populates a dictionary called taxa_dic derived from taxa so that it maps order names to sets of taxa and prints it to screen.

**lc1.py** Script extracts latin names, common names, and mean mass from tuple of bird data using list comprehensions and loops.

**lc2.py**: Script processes Uk rainfall data and demonstrates how to use list comprehensions and conventional loops to filter + display the data.

**loops.py**: Demonstrates how to use 
    - FOR loops: for iterating over a sequence
    - WHILE loops: continues WHILE a specific condition is TRUE

**MyExampleScript.py**: Takes a single argument x, squares it and prints result

**oaks_debugme.py**: This script reads a CSV file with plant taxonomy data, it then checks if each genus is "Quercus",oak, and writes the results in a new CSV file in the Results folder. 

**oaks.py**: Script identifies oak species from a list of plant names using traditional loops and list comprehensions.

**sysargv**: This script demonstrates how to handle command line arguments.

**test_control_flow.py**: This script determines whether a number is odd or even, with a function.

**tuple.py**: Script defines a tuple, with brid species latin name, common name and mass. 
    the script then iterates over the tupe and prints the details of each bird.

**using_name.py**: Demonstrates the use of the __name__ variable to differentiate between script execution and module importation.

##week3

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

###Rstats week
**assessment.R**: This script demonstrates how to perform data wrangling and cleaning in R, using multiple datasets related to tree growth, phenology, and weather data. The objective is to prepare the datasets for statistical analysis, focusing on merging datasets, handling date formats, cleaning TreeID columns, and converting phenology scores into dummy variables.
- Uploading and Inspecting the following datasets:
       a) girth: Contains girth (circumference) data of monitored trees.
       b) phenology: Contains phenology information, including leaf flushing data through spring.
       c) weather: Contains daily weather records (temperature, etc.) from a weather station.
       d) trees: Provides species and location information for oak trees.
- It then previews the first few rows of each dataset using head() to inspect the structure and contents.
- Handling Dates: The script checks and converts the Date column in the phenology dataset from a character format to Date format using lubridate::ymd(). It also converts the TIMESTAMP column in the weather dataset into a Date column (renamed as Date) using as.Date(), ensuring consistency between the phenology and weather datasets.
- Handling Girth Dates: The girth dataset includes year ranges. The script defines a function (parse_date) that extracts the start year from these ranges and creates a new DateStart column, representing the start date of the monitoring period for each tree.
- Cleaning TreeID Columns: Both girth and phenology datasets have a TreeID column, but some TreeID values contain non-numeric characters. The script:
Converts the TreeID to integers in the phenology dataset.
Filters out any non-numeric or zero values in the TreeID column to ensure that only valid tree identifiers remain.
- Merging Datasets:The script merges the phenology and girth datasets by the TreeID column using a left join (left_join()). It ensures that the DateStart from the girth dataset is less than or equal to the Date from the phenology dataset, indicating that the phenology event occurred after the tree monitoring period started.
- Grouping and Sorting Data: After merging, the dataset is grouped by TreeID, and data is arranged by the DateStart (start date of girth monitoring) and Date.x (date of phenology event). The slice_max() function is then used to keep only the most recent observation for each tree.
- Handling Phenology Scores (Dummy Variables): Although the code to convert the Score (phenology scores) into dummy variables is currently commented out, the intended approach is to use mutate() and case_when() to create a new column that classifies the phenology scores into distinct categories (e.g., bud burst, not yet burst).
- Writing the Cleaned Data: The final merged and cleaned dataset is written to a new CSV file (merged.csv) using write.csv() for further analysis or use in other scripts.

**AssStats.R**: This script is well-structured to process and analyze data related to tree phenology, specifically budburst scores, and their relationship with girth and timing metrics. Here's an overview of the key sections and operations performed in the script:
   1. Converting bud burst scores into dummy variables.
   2. Conducting statistical analyses on the relationship between the day of the year (DateofYear) and tree girth (Girth_cm).
   3. Visualizing the data through various plots.
   4. Running different regression models to explore the relationship between tree growth and bud burst timing.
   - Loading and Preparing Data: The script begins by loading the merged dataset (merged.csv) that combines girth and phenology data using read.csv().
   - Converting Bud Burst Scores to Dummy Variables: The Score column, which represents the phenological stage (e.g., bud burst), is converted into numeric dummy variables:
 1) Representing "bursting" (e.g., "2", "<2", ">2").
 2) Representing "bursted" (e.g., "3", "4", "5", "6").
 3)Representing "not bursted" (e.g., "0", "1").
  The conversion is done using mutate() and case_when() from dplyr.
   - Cleaning Data: Rows where the Score_numeric is NA are removed to ensure that only valid data is used in further analysis.
   - Calculating Day of the Year (DateofYear): The DateofYear is calculated using the yday() function from the lubridate package to represent the day of the year for each observation.
   - Filtering for Bud Burst Events: A subset of the data (testdata) is created, containing only rows where the Score_numeric equals 1 (indicating bud burst).
   - Visualizing the Data: The relationship between DateofYear and Girth_cm is visualized using ggplot2. Scatter plots, boxplots, and smoothed lines are generated to explore how the girth of trees changes during the bud burst period.
   - Descriptive Statistics: Summary statistics are calculated for both the DateofYear and Girth_cm variables, including measures like mean, median, standard deviation, range, and interquartile range (IQR).
  A boxplot is also generated to visually inspect the distribution of Girth_cm values.
   - Linear Regression Models: Several regression models are fitted to the data to explore the relationship between DateofYear and Girth_cm:
 -     Linear model: A basic linear regression model (lm()).
 -     Polynomial regression: Models with polynomial terms for DateofYear (up to degree 4).
 -      Logarithmic and exponential models: Exploring log transformations of both the predictor and response variables.
- The best model is selected based on the lowest Akaike Information Criterion (AIC).
 - Assumption Checking for Linear Models: Various diagnostic plots and statistical tests are used to check the assumptions of the linear regression model:
-    Linearity: A plot of the fitted values vs. residuals.
-    Independence of errors: Durbin-Watson test.
-    Homoscedasticity: Checking for constant variance of residuals.
-    Normality of residuals: Histogram and Q-Q plot of the residuals.
- Other Regression Models: The script explores other models like ARIMA (Auto-Regressive Integrated Moving Average) for time-series data and Generalized Additive Models (GAM) for non-linear relationships. The models are evaluated using AIC and R-squared values to find the best fitting model.
- Creating Visual Outputs he script generates several plots, including:
- Scatter plots with regression lines.
- Boxplots to visualize the distribution of girth across different days of the year.
   It saves the plots to .jpeg files for further reporting or presentation.
   - Exporting Model Results: The results of the linear regression model, including coefficients and other details, are saved as a table in .jpeg format for easy inclusion in reports.
 -  Additionally, the script generates summary plots for the models, saved as .jpeg files.
This script provides an in-depth analysis of the relationship between bud burst timing and tree growth, utilizing various regression models to explore and visualize the data. By converting phenology scores to dummy variables, checking model assumptions, and fitting multiple types of regression models, the script offers a thorough statistical analysis.

**HO1.R**: This script does mathematical exercises. 

**H02.R**: This script analyzes Tarsus measurements from the SparrowSize.txt dataset, exploring statistical summaries and visualizations.
 -   Data Loading and Exploration: Read the dataset, inspect its structure, and summarize the Tarsus variable.
 - Missing Value Handling: Identify and remove NA values.
 - Statistics: Calculate mean, median, variance, range, and standard deviation.
 - Visualizations: Create histograms with varied bin sizes, density plots, and z-score visualizations.
 - Z-Scores: Compute and visualize z-scores to standardize Tarsus.
    
**HO3.R**: This script analyzes variables in the SparrowSize.txt dataset to determine the type and summary statistics for key measurements.
   - Data Loading: Reads the dataset into R.
   - Variable Types: Determines the type of each variable (categorical or continuous).
   - Summary Statistics: Generates histograms and summary statistics for: BirdID (categorical): Assesses distribution and frequencies; Year (categorical/numeric): Reviews temporal trends; Tarsus, Bill, and Wing (continuous): Histograms and statistical summaries (mean, median, etc.).
    
**HO4.R**:
This script calculates standard errors (SE) for various measurements in sparrows (e.g., Tarsus, Wing, Bill, and Mass), and performs statistical tests to assess differences and hypotheses.
   - Data Preparation:Load the dataset (SparrowSize.txt) and handle missing values using subset.Separate data for specific years (e.g., 2001) for targeted analyses.
   - Calculations: Compute SE for different measurements:Tarsus, Wing, Bill, Mass
   - Statistical Tests:
    A) One-sample t-test: Compare Tarsus mean to a hypothetical value (e.g., 18.5).
    B) Two-sample t-test: Assess differences in Tarsus between sexes.
   - Summaries:
    Calculate summary statistics (e.g., mean, length) for variables.
    Test for specific years or subsets of the data.
   - Requirements. Required Package: dplyr for data manipulation.The script assumes that missing values are encoded as "NA" and filters these values for each variable.
   - Output:
    SE Calculations for each measurement and specific year subsets.
    t-test Results for mean comparisons and between-group differences.
    Useful for understanding sparrow morphology and its variations.
        
**HO5.R**: This script compares sparrow wing lengths (Wing) across years and sexes, using statistical tests to identify significant differences. 
  - Key comparisons include:
    a) Wing length in 2001 vs. the overall (grand-total) mean.
    b) Differences in wing length between sexes in 2001.
    c) Differences in wing length between sexes across the entire dataset.
- Data Preparation: Load the SparrowSize.txt dataset. Filter out missing values for Tarsus and ensure accurate comparisons.
- Analyses:
    Comparison 1: Test if the mean wing length in 2001 differs from the grand-total mean.
    Comparison 2: Test if male and female wing lengths differ in 2001.
    Comparison 3: Test if male and female wing lengths differ in the full dataset.
- Statistical Tests:
    Perform one-sample t-tests (e.g., 2001 wing length vs. grand-total mean).
    Perform two-sample t-tests (e.g., male vs. female wing lengths).
   - Reporting:
   Summarize results in a table, including sample sizes (N).
       Interpret results in plain text for clarity.
   - Requirements
       dplyr: For data manipulation.
   - Ensure the dataset is correctly structured with NA values representing missing data.
   - Output
   A. Statistical Test Results:
-       Whether wing length in 2001 differs significantly from the grand-total mean.
 -      Differences in wing length between males and females in 2001 and across the full dataset.
   B. Key Findings:
- Wing lengths in 2001 do not significantly differ from the grand-total mean.    
- Statistically significant differences exist in wing lengths between males and females in 2001, with males having longer wings (mean difference: 2.19 cm).
- Differences in wing length between sexes are also significant across the full dataset.
This analysis provides insights into sparrow wing morphology and its variations across time and sexes.


**HO6.R**:This script performs basic statistical analysis and a power analysis for two variables x and y. Key steps include linear regression modeling, calculating effect size, statistical power, and sample size, along with plotting results.
   - Basic Statistical Analysis: 
    A) Linear Regression: The script fits a linear model (lm(y~x)) to the data and outputs a summary, ANOVA table, residuals, covariance, and variance.
    B) Plotting: The relationship between x and y is visualized using a scatter plot.
    C) Regression Equation: The fitted line equation y = 0.8288x + 2.6164 is displayed.
   - Statistical Power Analysis:
    a) WebPower Package: The WebPower package is used to calculate the required sample size for achieving a specific statistical power.
    b) Effect Size and Power: The script calculates power for a two-sample t-test with an effect size of 0.25 and 80% power. It explores how sample size influences power and generates plots for the results.
    c) Sample Size for Desired Power: Given a small effect size (e.g., d=0.11), the script estimates the required sample size to achieve 80% power.
   - Requirements
    dplyr: For data manipulation.
    WebPower: For statistical power analysis.
   - Output: The summary and ANOVA results from the linear regression model.
   - Plots:
    A plot showing the relationship between x and y.
    A plot of statistical power against sample size.
   - Power Calculations:
    The probability of detecting an effect based on different sample sizes.
    Estimated sample sizes required for a desired power level.
This script is useful for understanding how statistical power and sample size relate to detecting meaningful differences in data, and it provides a basis for making data-driven decisions about study design.

**HO6.R**: This script demonstrates how to work with vectors in R, including accessing elements by index, performing simple arithmetic, and plotting linear relationships. It also shows how to create custom plots with grid lines and segments.
   - Vector Indexing:The script creates a sequence of numbers (x) from -5 to 5. It then shows how to access specific elements of the vector using indexing. Examples include accessing the first, second, and last elements of the vector using both direct indexing and a sequence of indices.
   - Plotting a Simple Linear Model:
    Linear Equation: A linear model y = a + b * x is defined where a = 2 and b = 1.
    The script then generates a plot of x versus y using this equation.
       Grid Lines and Segments: The plot is enhanced with grid lines and segments at the origin (both vertical and horizontal lines).
   - Plotting Adjustments:
       The plot is initially drawn with a white background, and grid lines are added using segments() to mark the x and y axes.
       The abline() function is used to plot the straight line defined by the equation y = 2 + 1 * x.
   - Output: A plot showing a simple linear relationship between x and y. Grid lines indicating the x and y axes, along with a plotted line based on the linear equation.

**HO7.R**: This script demonstrates how to work with simple linear functions, including accessing vector elements using indexing, applying linear functions to data, and visualizing the results using plots in R.
 - Vector Creation and Indexing:
       A sequence x from -5 to 5 with a step size of 1 is created using seq(-5, 5, 1).
       Different methods are used to access elements in the vector x, such as using the [[ ]] operator and checking specific indices:
    Access the first element (x[[1]]).
    Access the last element using x[[length(x)]].
    Indexing is also demonstrated using a sequence (i <- seq(0, 10, 1)).
   - Linear Function:
    A linear function y = a + b * x is defined, where a = 2 and b = 1. This function is applied to the sequence x to compute y.
   - Plotting:
    The relationship between x and y is visualized using the plot() function.
    Grid lines are added using the segments() function to highlight the x and y axes.
    The line corresponding to the linear equation y = 2 + 1 * x is added using the abline() function.
   - Plot Customization: The plot background is set to white using col="white". Dashed grid lines are added at the axes using segments(0, -10, 0, 10, lty=3) and segments(-10, 0, 10, 0, lty=3). The line defined by the linear function is drawn in the plot using abline(a=2, b=1).
   - This script provides a simple introduction to basic vector manipulation, applying linear functions, and customizing plots in R. It is a useful starting point for learners who want to understand indexing in vectors and visualizing data through basic linear model

**HO10.R**: This script demonstrates how to calculate and visualize variance and covariance in R. The script also explores the relationship between two variables and shows how their covariance changes depending on the strength of their association.
   - Variance Calculation:
    The script generates three sets of random data using rnorm(), each with different standard deviations (sqrt(1), sqrt(10), and sqrt(100)).
    The variance of each dataset is computed using the var() function.
   - Visualizing Data with Plots:
    The script plots the generated data using the plot() function. For each dataset (y1, y2, and y3), points are plotted, and horizontal and vertical reference lines (abline()) are added.
       The data points are visualized with color-coded points (col="red", col="blue", col="green"), and gridlines are added for clarity.
   - Polygons for Variance: The script uses the polygon() function to illustrate the spread of data points for each dataset. These polygons show how the deviations from the mean vary across the data.
    The polygons are drawn for each data point to visually emphasize the deviations from the mean.
   - Covariance Calculation:
    The script calculates covariance between two variables x and y1 using the cov() function.
    It plots these variables (x and y1) and includes the covariance value in the plot title using the main=paste() function.
    The script also explores how the covariance changes for different relationships:
    A positive relationship (y1 = x * 1 + rnorm(21, 0, sqrt(1))).
    A random relationship (y2 = rnorm(21, mean=0, sd=sqrt(1))).
      A negative relationship (y3 = x * (-1) + rnorm(21, 0, sqrt(1))).
   - Plotting with Covariance:
    Three plots are generated to visualize the covariance between x and y1, x and y2, and x and y3.
       The covariance values are displayed on each plot's title, illustrating how the relationship between variables affects the covariance.
This script demonstrates the concepts of variance and covariance, showing how they can be calculated and visualized in R. By visualizing the data and computing the covariance between variables with different relationships, the script provides insight into how the strength and direction of the association between variables influence these statistics.

**HO11.R**: This R script demonstrates how to explore a dataset (daphnia.txt) and fit a model using multiple variables to explain the response variable (Growth.rate). The script covers the following steps:
   - Data exploration and summary statistics.
   - Visualization of the data using boxplots and histograms.
   - Checking assumptions such as homogeneity of variance and normality.
   - Calculating means and standard errors for different groups.
   - Fitting a linear regression model to assess the impact of multiple explanatory variables (Detergent and Daphnia) on the response variable.
   - Output:
    A) Boxplots: Visualize the distribution of growth rates for different detergent types and Daphnia clones.
       B) Variance: Check for homogeneity of variance across groups.
    C) Histogram: Assess the normality of the Growth.rate data.
       D) Bar Plots: Display means and standard errors for Growth.rate by Detergent and Daphnia.
    E) Linear Model: Summarizes the effects of Detergent and Daphnia on Growth.rate.

**HO12.R**: This script demonstrates how to explore, build, fit, interpret, and validate Poisson regression models for fisheries data. The focus is on modeling the relationship between total fish abundance (TotAbund) and explanatory variables such as the mean depth of the water column (MeanDepth) and time periods (Period).
- Data Exploration: Load dataset on fish abundance, which includes information on the density (Dens), mean depth (MeanDepth), and total abundance (TotAbund) of fish across different sites and time periods (from 1977 to 2002).The dataset is examined using the str() function to understand the structure, and exploratory visualizations are created to observe the relationship between MeanDepth and TotAbund.
   - Model Building and Fitting: A basic Poisson regression model is built using the formula TotAbund ~ MeanDepth, where TotAbund is the response variable, and MeanDepth is the explanatory variable. The glm() function is used to fit the model with the Poisson family, and the summary of the model is examined to interpret the coefficients and understand how MeanDepth affects the total abundance of fish.
   - Model Diagnostics: A series of diagnostic plots is created using the plot() function to check for model assumptions such as linearity, residuals, and outliers. The script computes Cook's distance to identify potential outliers, with a threshold of Cook’s distance greater than 1. The script examines overdispersion by comparing the model's deviance to the degrees of freedom.
   - Model Refitting and Validation: Based on the model diagnostics, the script refits the model by incorporating the interaction between MeanDepth and Period using the formula TotAbund ~ MeanDepth * Period. The model is re-evaluated using the summary() and anova() functions, and the impact of time periods on fish abundance is assessed.
   - Visualizations: 
       Scatter plots and boxplots are created to visualize the relationships between MeanDepth, TotAbund, and Period.
       Scatterplot: Shows the relationship between MeanDepth and TotAbund, colored by Period.
       Boxplot: Displays the distribution of TotAbund for each time period (Period).
This script demonstrates how to build a Poisson regression model in R to analyze fish abundance data. It includes key steps in model fitting, validation, and interpretation, as well as visualizations to help explore the data and assess model assumptions. By incorporating interactions between explanatory variables, the script provides a more accurate understanding of how factors like MeanDepth and Period influence total fish abundance.

###HPC 

**ac524_HPC_2024_demographic_cluster.R**: This script runs a stochastic demographic simulation model in a High-Performance Computing (HPC) environment, designed to project population dynamics over time. The script leverages parallel processing, allowing different initial conditions to be simulated across multiple nodes.
Key Features:
   - Clearing Workspace and Loading Functions:
       The script begins by clearing the R environment and loading necessary functions from an external file (Demographic.R) that supports the simulation process.
   - Cluster Job Initialization:
       The script is designed to run in parallel on an HPC cluster. It uses a job number (iter) to control the seed for random number generation, ensuring each parallel job has a unique initialization.
   - Model Parameter Definitions:
    Parameters such as Clutch Distribution, Growth Matrix, and Reproduction Matrix are defined. These matrices describe the population's growth rates, reproduction strategies, and the distribution of offspring.
    - Initial State Setup:
       The script initializes the population state based on predefined conditions (e.g., adults or spread across life stages). The initial state is chosen depending on the job number (iter), which selects one of several possible conditions for each parallel run.
   - Running Simulations:
       The script performs a set of 150 stochastic simulations. Each simulation uses the initial conditions defined earlier and runs a population model over a fixed time period (120 steps). Results are stored in a list and saved to a file specific to the job number.
   - Data Saving:
       After running the simulations, the results are saved into a .rda file for further analysis. This file can be used for post-processing or visualization of the simulation outcomes.
   - Parallel Execution:
       As the script is intended for HPC use, it allows multiple simulations to run concurrently, making efficient use of computational resources. This parallel approach speeds up the analysis process and helps in running large-scale simulations for demographic studies.
This script models population dynamics using stochastic processes, where random variables (like growth rates and reproductive success) are incorporated to simulate realistic population changes. It is useful for ecological modeling, conservation studies, and demographic research where understanding population growth under uncertainty is critical. The model can be applied to a variety of species and is particularly useful for studying populations with complex life cycle stages.

**ac524_HPC_2024_main.r** The script is structured to simulate demographic and ecological models for species populations using both deterministic and stochastic methods, employing high-performance computing (HPC) resources for parallel execution. Below is an overview of the key sections:
User Information and Setup:

  - Personal Information: The user defines their name, preferred name, email, and username, which are stored in variables.
    Workspace Note: A reminder is given not to clear the workspace in this section to ensure that essential information remains intact for subsequent code executions.

Section One: Stochastic Demographic Population Model
- Question 0: Initializing Population States

Two functions are defined for initializing the population:

  state_initialise_adult: Sets all individuals to the adult life stage.
  state_initialise_spread: Evenly distributes individuals across all life stages with a small adjustment for any remainder.

- Question 1: Deterministic Simulation

This function runs a deterministic simulation for a population with four life stages and an initial population size of 100 individuals. It compares two initial conditions:

    One with all individuals as adults.
    Another with individuals spread across all life stages. The simulation is run for 24 steps, and the population sizes over time are plotted and saved as question_1.png. The plot compares the growth under these two conditions, and a brief explanation about how the initial distribution affects population growth is provided.

- Question 2: Stochastic Simulation

The function question_2 performs a stochastic simulation with the same initial conditions as Question 1 but includes variability in the model (e.g., clutch distribution). It again runs the simulation for 24 steps and compares the population size time series for both initial conditions. The resulting plot is saved as question_2.png. The function also asks for an explanation of the difference in smoothness between the deterministic and stochastic simulations.
Subsequent Questions 3-6: HPC and Cluster Execution

These questions involve parallelizing the simulation code to run on an HPC cluster. For Questions 3 and 4, code for running the simulations across multiple nodes is expected, while Questions 5 and 6 involve creating plots and providing written explanations.
Section Two: Individual-Based Ecological Neutral Theory Simulation

This section outlines a neutral ecological model, where species' population dynamics follow neutral theory assumptions (i.e., no species have an inherent advantage over others). Functions for initializing communities, simulating neutral steps, and generating time series are provided. The section includes several questions (7-20) where the user must write functions to simulate species richness, neutral evolution, and speciation over time.
Question 21: Vector Summation

A utility function, sum_vect, is defined to add two vectors of unequal lengths. The shorter vector is padded with zeros to match the length of the longer one, ensuring that their elements can be added together element-wise.
Challenge Questions (A-E)

These questions involve more complex simulations and are meant to challenge the user to apply the concepts learned in the exercises to new, more difficult problems.
Plotting and Output

For most questions, a plot is generated and saved as a .png file. These plots visualize population growth or changes in species diversity over time based on the simulated scenarios.
General Observations and Tips:

 -   Modular Approach: Functions are used to modularize tasks (e.g., simulation, initialization, plotting), making it easier to maintain and test individual components.
  -  HPC Utilization: For scalability, especially in larger simulations, the script utilizes HPC resources for parallel execution, which is essential for running large-scale simulations in reasonable timeframes.

This script is designed for advanced ecological modeling, where both deterministic and stochastic models are used to simulate population dynamics over time. It emphasizes the importance of understanding how initial conditions influence long-term population growth and how computational tools can be used to explore complex ecological systems efficiently. The integration of HPC resources ensures that large-scale simulations can be handled efficiently, while the modular code structure promotes flexibility and reusability in the modeling process.

**ac524_HPC_2024_neutral_cluster.R** This setup suggests that the exercise will involve running simulations based on a neutral ecological model, possibly on an HPC cluster, with the provided script (abc123_HPC_2024_main.R) containing the main logic, such as function definitions for population modeling, speciation, or statistical analysis. The rest of the code that will follow (likely in abc123_HPC_2024_main.R) will likely define more detailed steps, such as defining population parameters, running simulations, and possibly visualizing or analyzing the output data.


**ac524_HPC_2024_test.R**: The script sources two key R files, ac524_HPC_2024_main.R and Demographic.R, which contain functions to be used in the exercises. It is structured to allow for testing and debugging functions that will be used in cluster-based simulations.
Key Features:

  -  Function Sourcing: The script begins by sourcing external R scripts that contain the necessary functions for the exercises. These files are expected to define the key functions used for the exercises.
  -  Function Testing: The script allows you to test individual functions (like species_richness(), state_initialise_adult(), and sum_vect()) interactively to ensure they work correctly before being used in larger simulations.
   - Environment Cleanup: It starts by clearing the R environment (rm(list=ls())), ensuring that no leftover objects interfere with the script’s execution.
   - Debugging: The script is useful for debugging, where you can modify and test smaller parts of the code. However, it is recommended that the code be tidied up before final submission, especially before integrating it into the main simulation run.

- The main goal of the script is to define and test functions in isolation, preparing them for later use in the main simulation code. This approach is meant to help maintain an organized workflow and ensure that all functions are properly tested before running large simulations on the cluster.

**Demongraphic.R**:This script is designed for simulating stochastic and deterministic demographic models in a population over time, as part of the CMEE 2024 HPC exercises. It contains functions to model population dynamics, both deterministically (fixed transitions between states) and stochastically (incorporating randomness in transitions).
Key Functions:

 -   Deterministic Model:
        deterministic_step(): Calculates the next state of the population using a projection matrix.
        deterministic_simulation(): Runs a simulation for a given length, applying the deterministic model to update population sizes at each time step.

   - Stochastic Model:
        multinomial(): Simulates the multinomial distribution for survival/maturation and death probabilities.
        survival_maturation(): Updates the population state based on survival and maturation probabilities derived from a growth matrix.
        random_draw(): Makes a random selection based on a probability distribution.
        stochastic_recruitment(): Calculates the recruitment probability for new individuals based on the reproductive matrix and clutch size distribution.
        offspring_calc(): Calculates the number of offspring produced at each time step, accounting for recruitment and clutch sizes.
        stochastic_step(): One step of the stochastic model, updating the population with survival, maturation, and offspring.
        stochastic_simulation(): Runs a full simulation of the population using the stochastic model, stopping if the population reaches zero.

- Purpose:

    Deterministic models assume fixed transitions and predictable population changes, while stochastic models incorporate randomness, making them more suitable for modeling real-world biological processes where variability and uncertainty are common.
    The script is designed to simulate both models over a specified time period and can be extended for use in high-performance computing (HPC) environments to run large-scale simulations efficiently.
    
        

## Author
   Anna Cavalieri Canosa
    	ac524@ic.ac.uk


