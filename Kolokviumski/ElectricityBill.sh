#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Wrong use of the script"
  exit 1
fi


fromMonth="$1"
toMonth="$2"
echo "$fromMonth"

oldIFS=$IFS
IFS=$'\n'
citiesInfo=$(cat electricity-bill.txt |grep -v 'Month' | awk -F"|" '{print $0}')

#Ako sakas uniq da raboti mora liniite da se edna do druga, pa zatoa gi sortirame
names=$(echo "$citiesInfo" | awk -F"|" '$1 != "Name" {print $1}' | sort | uniq)

for name in $names
do
  statsFrom=$(cat electricity-bill.txt |grep "$name" | awk -v month="$fromMonth" -F"|" '{ if($3 == month) {print $0} }')
  statsTo=$(cat electricity-bill.txt |grep "$name" | awk -v month="$toMonth" -F"|" '{ if($3 == month) {print $0} }')
  if [ -n "$statsFrom" ]; then
      if [ -n "$statsTo" ]; then
        firstMonth=$(echo "$statsFrom" | awk -F"|" '{ print $5}')
        secoundMonth=$(echo "$statsTo" | awk -F"|" '{ print $5}')
        if [ "$firstMonth" -gt "$secoundMonth" ]; then
            echo "$name"
        fi

        else
          echo "$statsFrom" | cut -d "|" -f1
      fi
  fi
  done
