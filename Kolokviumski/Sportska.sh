#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Nepravilno"
  exit 1
fi
directory="$1"

files=$(find "$directory"  -type f -name "kolo[0-9].rez.txt")
teams=()

for file in $files
do
  teams+=($(cat $file | awk -F"," '{print $2}'))
done

if [ -f tmp.txt ]; then
    rm tmp.txt
fi

for team in "${teams[@]}"
do
  echo "$team" | cat >> tmp.txt
done

uniqTeams=$(cat tmp.txt | sort | uniq)

for uniqTeam in $uniqTeams
do
  totalForTeam=0
  for file in $files
  do
    total=$(cat "$file" | awk -F"," -v team="$uniqTeam" 'BEGIN {wins=0; draws=0; } {
    if ($2 == team ){
      if ($1 == "W"){
        wins+=1
      }
      else if ($1 == "d"){
        draws+=1
      }
    }
    } END {print wins + draws}')
    totalForTeam=$((totalForTeam + total))
    done

    if [ $totalForTeam -ne 0 ]; then
        echo "$uniqTeam $totalForTeam"
    fi
done


