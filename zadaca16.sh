#!/bin/bash

if [ "$#" = 0 ]; then
  echo "Please input the UID as a first argument"
  exit 1
fi
user=$1
all_processes=$(ps -ef | grep "$user" | awk '{print $2}')
children_processes=$(ps -ef | grep "$user" | awk '{print $3}')

echo "" | cat > out.txt

for pid in $all_processes
do
  counter=0
  for ppid in $children_processes
  do
    if [ "$pid" = "$ppid" ]; then
      counter=$(("$counter" + 1))
    fi
  done
  echo "The process $pid has $counter children" | cat >> out.txt
done

cat out.txt