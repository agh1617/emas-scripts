#!/bin/bash -l

session_timestamp=$1

for i in $(seq 0 2); do
  job_id=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`

  job_dir="$SCRATCH/ppagh/$session_timestamp/$job_id"

  mkdir -p $job_dir
  cd $job_dir

  srun -l /bin/hostname | sort -n | awk '{printf "'\''%s'\''.\n", $2}' > $job_dir/.hosts.erlang
  wait
  srun -o /dev/null $HOME/ppagh/run-scripts/prometheus/scalability/run_node.sh $job_dir $job_id
  wait
done
