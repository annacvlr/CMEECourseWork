#!/usr/bin/env python3
"""using subprocess package to run an R script (Test.R) and redirects the output and error messages to specified files"""

import subprocess
p = subprocess.Popen("Rscript --verbose Test.R > ../results/Test.Rout 2> ../results/Test_errFile.Rout", shell=True).wait()
