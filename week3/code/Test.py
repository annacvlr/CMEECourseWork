import subprocess
p = subprocess.Popen("Rscript --verbose Test.R > ../results/Test.Rout 2> ../results/Test_errFile.Rout", shell=True).wait()