# CMEE bootcamp Week1
Week 1 coursework of the Biological Computating Bootcamp.

## Description
Week 1 covered Shell Scripting bash and Git Version Control.

## Languages 
shell script
plain txt

## Dependencies
none

## Installation
none

## Project Structure and Usage
- Code: Contains script files.
- Data: Where all the data used has been collected.
- Results: Contains the results.

##Code
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

## Author
   Anna Cavalieri Canosa
    	ac524@ic.ac.uk


