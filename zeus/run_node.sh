#/bin/bash

. /etc/bashrc
module load apps/erlang/17.3

Time=$1
JobDir=$2
JobId=$3

EmasRoot=$HOME/erlang-emas
LogPath="$JobDir/`hostname`"
mkdir -p $LogPath

cd $JobDir
erl -sname emas -setcookie $JobId -pa $EmasRoot/ebin \
  -pa $EmasRoot/deps/*/ebin -noshell -detach \
  -eval "emas:start($Time, [{model, mas_hybrid}, {islands, 12}, {log_dir, \"$LogPath\"}, {world_migration_probability, 0.001}])." \
  -run init stop
