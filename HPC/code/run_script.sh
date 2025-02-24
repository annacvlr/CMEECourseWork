#!/bin/bash
#PBS -l walltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb

module load anaconda3/personal
export TMPDIR="/rds/general/ephemeral/user/ac524/ephemeral"
mkdir -p $TMPDIR
echo "TMPDIR is set to: $TMPDIR"


echo "Copying files..."
cp $HOME/Demographic.R $TMPDIR/
cp $HOME/ac524_HPC_2024_demographic_cluster.R $TMPDIR/
ap 

echo "Switching to TMPDIR..."
cd $TMPDIR
pwd  # Print working directory

echo "Checking if files copied correctly:"
ls -l  # List all files in TMPDIR

echo "Running R script..."
R --vanilla < ac524_HPC_2024_demographic_cluster.R

echo "Moving results back..."
mv sim_result_* $HOME

echo "Cleaning up TMPDIR..."
rm -r $TMPDIR

echo "Job finished!"
