#/bin/bash

MinNodes=1
MaxNodes=3
Step=2

Grant=grant_name

for i in $(seq $MinNodes $Step $MaxNodes); do
  printf $i
  qsub -q l_short -N emas_$i -A $Grant -l nodes=$i:ppn=12 -l walltime=00:20:00 $HOME/erl-scripts/run_nodes.sh
done
