#!/bin/bash

files=$(ls -l | sed -n '/^-/p' | sed 's/ .*[0-9]*:[0-9]*//')

for file in $files
do
  echo "$file"

done
