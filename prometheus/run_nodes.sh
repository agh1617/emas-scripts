#/bin/bash

# find $PBS_NODEFILE equivalent in Slurm
Hosts=(`cat $PBS_NODEFILE | uniq`)
Time=90000

for k in $(seq 0 9); do
  JobId=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`

  # check whether $SCRATCH occurs under the same directory
  # change moar_migrations to some random experiment session id
  JobDir="$SCRATCH/moar_migrations/$JobId"

  mkdir -p $JobDir
  cd $JobDir

  for host in ${Hosts[*]}; do
    # redirect stdout to log files instead of /dev/null
    # change script path
    pbsdsh -o -h $host $HOME/emas-scripts/zeus_3/run_node.sh $Time $JobDir $JobId > /dev/null &
  done

  wait
done
