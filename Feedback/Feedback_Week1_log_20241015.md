
# Feedback on Week 1 Log

## Project Structure & Workflow
- **Project directories**: The project structure includes essential folders such as `code`, `data`, `Results`, and `sandbox`. The presence of these directories demonstrates an organized structure, crucial for project scalability. However, the following improvements are suggested:
  - Add a `.gitignore` file: This helps in avoiding unnecessary files (e.g., temporary or compiled files) from being committed to version control.
  - Weekly directories: It's great to see a weekly folder structure. However, you should ensure that extra files like `.blg`, `.bbl`, and `.pdf` files are excluded using `.gitignore`.

- **README Files**:
  - The `README.md` files exist in both the parent and `week1` directory, which is a good practice for documenting the project and its specific sub-sections. That said, there are areas that need improvement:
    - The main `README.md` could include more detailed information, such as installation instructions, dependencies, and more context on the purpose of the project.
    - For the `week1/README.md`, while the provided description of shell scripting and bash usage is useful, the document would benefit from a more comprehensive breakdown of what each script does, with usage examples.

## Code Syntax & Structure
- **Shell Scripts**:
  - In general, the shell scripts are well-written with appropriate comments, which aids in understanding the code. Below are some specific feedback points:
    - **`variables.sh`**: The script runs but encounters an issue with an empty input value causing an `expr: syntax error`. It's essential to validate user input before using it in operations like addition. Consider adding input validation to handle cases where inputs may be empty or invalid.
    - **`myscript.sh`**: The script content is incomplete and only contains the word `script`. Ensure that placeholder files are either fully implemented or removed if unnecessary.
    - **`ConcatenateTwoFiles.sh`**: The script properly checks for file existence and handles concatenation well. It would be more robust to handle cases where the input files are empty or malformed.
    - **`CompileLaTeX.sh`**: This script runs into errors, likely because of missing files or incorrect file paths. The `pdflatex` command also throws errors when no valid `.tex` file is passed. Adding error handling for file paths and existence checks can improve robustness. Also, the clean-up commands are failing due to misformatted patterns (`rm .*bbl`).
    - **`tabtocsv.sh`**: There's an issue with a syntax error (`S#` instead of `$#`). Fix this to correctly check the number of arguments passed to the script.
    - **`csvtospace.sh`**: This script makes assumptions about directory locations that may not hold true in different environments, resulting in errors like `No such file or directory`. Use relative paths or verify the existence of directories before proceeding.

- **Other Code Files**:
  - **`.tex` and `.bib` files**: The `.tex` file (`FirstExample.tex`) is well-structured and compiles a simple LaTeX document. Ensure that these files are cleaned up after compilation to avoid clutter.
  - **`tiff2png.sh`**: This script works but only if `.tif` files exist. Adding checks for file existence would be useful before attempting the conversion.
  - **`UnixPrac1.txt`**: This file includes useful Unix commands for genomic analysis. It could be better documented to explain the steps and purpose of each section more clearly. Additionally, ensure that paths to data files are correct when running the script.

## Recommendations:
- **General Code Hygiene**:
  - Add input validation to handle edge cases (empty input, incorrect file paths, etc.) in your scripts.
  - Ensure that scripts are portable by using relative paths or dynamically detecting file locations.
  - Regularly clean up unnecessary files and ensure `.gitignore` is updated accordingly to avoid committing files that should not be part of the repository.

- **Documentation**:
  - Update the README files with more detailed instructions on usage, dependencies, and how to run the scripts. A section on common issues and troubleshooting would also be helpful.
  - Each script should have its purpose, inputs, and outputs documented in both the README and within the script itself.

Keep up the great work, and continue improving code structure and documentation practices!
