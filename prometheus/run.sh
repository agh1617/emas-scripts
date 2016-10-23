#!/bin/bash -l

session_timestamp=`date +%s`

min_nodes=1
max_nodes=100
step=2

grant=plglogin

mkdir -p "$SCRATCH/ppagh"

for num_nodes in $(seq $min_nodes $step $max_nodes); do
  printf $num_nodes

  sbatch -p plgrid \
         -A $grant \
         -N $num_nodes \
         --ntasks-per-node=24 \
         --time=00:20:00 \
         -J ppagh-emas-$num_nodes \
         $HOME/ppagh/run-scripts/prometheus/run_nodes.sh $session_timestamp
done
