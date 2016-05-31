#/bin/bash

Hosts=(`cat $PBS_NODEFILE | uniq`)
Time=90000

for k in $(seq 0 2); do
  JobId=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`
  JobDir="$SCRATCH/erlang-mas/$JobId"

  mkdir -p $JobDir
  cd $JobDir

  for host in ${Hosts[*]}; do
    pbsdsh -o -h $host $HOME/erl-scripts/run_node.sh $Time $JobDir $JobId > /dev/null &
  done

  wait
done
