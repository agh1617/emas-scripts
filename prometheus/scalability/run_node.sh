#!/bin/bash -l

. /etc/bashrc

module use $HOME/.modulefiles
module load erlang/17.5

job_dir=$1
job_id=$2

hostname=`hostname`
emas_root=$HOME/ppagh/erlang-emas
logs_path=$job_dir/$hostname
mkdir -p $logs_path

duration=90000 # 90 seconds
world_migration_probability=0.001
total_islands=240

islands_on_this_node=`expr $total_islands / $SLURM_JOB_NUM_NODES`

cd $job_dir
erl -sname $hostname -setcookie $job_id -pa $emas_root/ebin \
  -pa $emas_root/deps/*/ebin -noshell -detach \
  -eval "emas:start($duration, [{model, mas_hybrid}, {islands, $islands_on_this_node}, {log_dir, \"$logs_path\"}, {world_migration_probability, $world_migration_probability}])." \
  -run init stop
