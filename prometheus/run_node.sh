#!/bin/bash -l

. /etc/bashrc

module use $HOME/.modulefiles
module load erlang/17.5

job_dir=$1
job_id=$2
session_timestamp=$3

hostname=`hostname`
emas_root=$HOME/ppagh/erlang-emas
logs_path=$job_dir/$hostname
mkdir -p $logs_path

duration=30000 # 30 seconds
world_migration_probability=0.001

additional_logs_path=$HOME/ppagh/logs/$session_timestamp/$job_id
mkdir -p $additional_logs_path

cd $job_dir
erl -sname $hostname -setcookie $job_id -pa $emas_root/ebin \
  -pa $emas_root/deps/*/ebin -noshell -detach \
  -eval "emas:start($duration, [{model, mas_hybrid}, {islands, 24}, {log_dir, \"$logs_path\"}, {world_migration_probability, $world_migration_probability}])." \
  -run init stop >> $additional_logs_path/$hostname
