#!/bin/bash
#PBS -lwalltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb

module load anaconda3/personal

cp $HOME/ac524_HPC_2024_demographic_cluster.R $TMPDIR
cp $HOME/Demographic.R $TMPDIR
cp $HOME/ac524_HPC_2024_main.R $TMPDIR


cd $TMPDIR



R --vanilla < $HOME/ac524_HPC_2024_demographic_cluster.R

mv simulation_quest4_* $HOME
mv $HOME/simulation_quest4_* $HOME/rda

mv $HOME/run_demographic_cluster.sh.* $HOME/errors_outputs



echo "R has finished running"

