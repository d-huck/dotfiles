#!/bin/zsh

DIR="/tmp/vit_pids"

if [[ ! -d "$DIR" ]]; then
    exit 1
fi

for pidFile in $(ls "$DIR"/*.pid); do
   pid=$(basename $pidFile .pid)
   kill -SIGUSR1 $pid &> /dev/null
   if [[ $? -ne 0 ]]; then
      rm $pidFile
   fi
done
