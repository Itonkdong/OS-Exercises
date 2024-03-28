#!/bin/bash

echo "Type the number in front of the file to view it's content"

files=$(ls -l | awk '$1 ~ /^-/ {print $NF}')

select file in $files "Exit Program"; do

  if [ "$file" = "Exit Program" ]; then
    echo "Exiting..."
    exit 1
  fi
  if [  ! -f "$file" ]; then
    echo "The selected file is not a file. Try another"
  else
    cat "$file"
  fi

done

