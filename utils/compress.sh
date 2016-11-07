#!/bin/bash -l

#SBATCH -J emas-compress
#SBATCH -N 1
#SBATCH --ntasks-per-node=1
#SBATCH --time=03:00:00
#SBATCH -A plglogin
#SBATCH -p plgrid

cd $SCRATCH/ppagh

results_path=$1

compressed_path=$results_path
compressed_path+=".tar.gz"

srun tar -zcvf $compressed_path $results_path
