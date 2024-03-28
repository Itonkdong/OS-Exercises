#!/bin/bash

toLower(){
  for arg in "$@"
  do
    echo "$arg" | awk '{ print tolower($1) }'

#    II WAY
#    new_arg=$(echo "$arg" | tr '[A-Z]' '[a-z]')
#    echo "$new_arg"

  done
}

if [ "$#" -le 0 ]; then
    echo "Invalid use of script. Send more args"
    exit 1
fi

toLower "$@"

# test == [ ]

