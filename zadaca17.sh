#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "You must send 2 arguments. First arg: 'from directory', Second arg:'to directory'"
  exit 1
fi

from_directory="$1"
to_directory="$2"

if ! ls -l | grep -q $"$to_directory"  ; then
  echo "The folder $to_directory does not exits. Creating $to_directory ..."
  mkdir "$to_directory"
fi

correct_files=$(ls "${from_directory}" | grep '[0-9][0-9]*[a-z][a-z]*\.out')

total_size=0

for file in $correct_files
do
  echo "$file is A OK"
  mv "$from_directory/$file" "$to_directory/"

  if [ -x "$to_directory/$file" ]; then
      file_size=$(ls -l "$to_directory/$file" | awk '{print $6}')
      total_size=$(("$total_size" + "$file_size"))
  fi

done

echo "Total size of executable files is $total_size"