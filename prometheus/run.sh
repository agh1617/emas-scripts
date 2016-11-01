#!/bin/bash -l

session_timestamp=`date +%s`

min_nodes=1
max_nodes=100
step=2

grant=plglogin
partition=plgrid
time="00:20:00"

mkdir -p "$SCRATCH/ppagh"

for num_nodes in $(seq $min_nodes $step $max_nodes); do
  printf $num_nodes

  sbatch --partition=$partition \
         --account=$grant \
         --nodes=$num_nodes \
         --ntasks=$num_nodes \
         --cpus-per-task=12 \
         --time=$time \
         --job-name=emas-$num_nodes \
         $HOME/ppagh/run-scripts/prometheus/run_nodes.sh $session_timestamp
done
