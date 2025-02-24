#!/bin/bash
#PBS -lwalltime=12:00:00
#PBS -l select=1:ncpus=1:mem=1gb

module load anaconda3/personal

cp $HOME/ac524_HPC_2024_demographic_cluster.R $TMPDIR
cp $HOME/Demographic.R $TMPDIR
cp $HOME/ac524_HPC_2024_main.R $TMPDIR
cp $HOME/cluster_simulation.R $TMPDIR

cd $TMPDIR



R --vanilla < $HOME/cluster_simulation.R

#mv simulation_results_* $HOME
mv $HOME/simulation_results_* $HOME/rda




echo "R has finished running"
