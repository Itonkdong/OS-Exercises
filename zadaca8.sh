#!/bin/bash

if [ $# -lt 3 ]; then

  echo "Wrong usage of the script"
  echo "ren regex new_name file1, file2"
  exit 1
fi

regex_to_find=$1
new_name=$2
shift
shift




for file in "$@"
do

  if [ -f "$file" ]; then
    # DO NOT USED '' AT SED WHEN U ARE TYPING IN  BASH SCRIPT
    new_file_name=$(echo "$file"| sed s/"$regex_to_find"/"$new_name"/)
    mv "$file" "$new_file_name"
  fi
done
