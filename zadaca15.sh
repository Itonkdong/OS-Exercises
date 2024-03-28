#!/bin/bash

if [ "$#" = 0 ]; then
  echo "Please input the UID as a first argument"
  exit 1
fi
user=$1

user_times=$( last | grep ^"$user" | awk '{print $NF}' | sed -e 's/(//' -e 's/)//')

total_time=0

for time in $user_times
do
  if [ "$time" = "in" ]; then
      continue
  fi

  hours=$(echo "$time" | awk -F: '{print $1}')
  minutes=$(echo "$time" | awk -F: '{print $2}')
  total_time=$(( "$total_time" + 60 * "$hours" + "$minutes" ))
done

echo "$total_time minutes" | cat > out.txt
cat out.txt