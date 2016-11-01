#!/bin/bash -l

session_timestamp=$1

srun -l /bin/hostname | sort -n | awk '{printf "'\''%s'\''.\n", $2}' > $HOME/.hosts.erlang

for i in $(seq 0 9); do
  job_id=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`

  job_dir="$SCRATCH/ppagh/$session_timestamp/$job_id"

  mkdir -p $job_dir
  cd $job_dir

  for host in ${hosts[*]}; do
    srun -o --nodelist=$host $HOME/ppagh/run-scripts/prometheus/run_node.sh $job_dir $job_id > /dev/null &
  done

  wait
done
