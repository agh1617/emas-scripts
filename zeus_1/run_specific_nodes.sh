#/bin/bash

. /etc/bashrc

JobId=`head /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1`
JobDir="$SCRATCH/erlang-mas/$JobId"
mkdir -p $JobDir
cd $JobDir

NodeCount=$1
Offset=$2

AllHosts=(`cat $PBS_NODEFILE | uniq`)
Hosts=("${AllHosts[@]:$Offset:$NodeCount}")

printf "'%s'.\n" "${Hosts[@]}" > ./.hosts.erlang

Time=90000

printf "Starting job $JobId on $NodeCount nodes"

for host in ${Hosts[*]}; do
  pbsdsh -o -h $host $HOME/erl-scripts/run_node.sh $Time $JobDir $JobId > /dev/null &
done

wait

printf "Job $JobId has ended. Logs are written to $JobDir."
