#!/bin/bash

if [ $# -lt 1 ]; then

  echo "Wrong usage of the script"
  echo "Send the number that you want to be increased by factor of 3.5"
  exit 1
fi

number=$1
echo "$number increased 3.5 is"

# $() == ``
# $(()) == `expr `

#Ako sakas da pravis presmetki so awk, ne ja stavaj promenlivata vo "", no kodot za awk stavi go vo ''
#Pr: Ne pravi awk '{ print "$number "* 3.5; }', tuku awk '{ print $number * 3.5; }'
#-----------------------------^--------------------------------------^


solution=$(echo "$number" | awk '{ print $number * 3.5; }')
printf "%.2f" "$solution"

