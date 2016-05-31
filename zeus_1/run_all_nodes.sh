#/bin/sh

. /etc/bashrc
NodeCount=`cat $PBS_NODEFILE | uniq | wc -l`

MinNodes=1
MaxNodes=$(($NodeCount / 2))

for i in $(seq $MinNodes 5 $MaxNodes); do
  printf "Running on $i and $(($NodeCount - $i)) nodes\n"

  for k in $(seq 0 9); do
    $HOME/erl-scripts/run_specific_nodes.sh $i 0 &
    $HOME/erl-scripts/run_specific_nodes.sh $(($NodeCount - $i)) $i &

    wait
  done

  printf "Finished on $i and $(($NodeCount - $i)) nodes\n"
done
