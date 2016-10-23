#/bin/bash

MinNodes=1
MaxNodes=100
Step=2

Grant=plglogin

for i in $(seq $MinNodes $Step $MaxNodes); do
  printf $i
  # find qsub (and all its options) equivalent in Slurm
  # replace l_short queue with appropriate Prometheus queue
  # change script path
  qsub -q l_short -N emas_$i -A $Grant -l nodes=$i:ppn=12 -l walltime=00:20:00 $HOME/emas-scripts/zeus_3/run_nodes.sh
done
