#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Invalid use of script";
    exit 1
fi

fromTime="$1"
toTime="$2"
directory="$3"

if [ -d "$directory" ]; then
    rm -r "$directory"
fi

mkdir "$directory"

#Plus treba eden grep '10.10.0.0', ama za testiranje bez nego
filttered=$(cat who.txt | grep '2024-04-07' | awk -v from="$fromTime" -v to="$toTime" '{split($4,time,":"); if (time[1] >= from && time[1] <= to) {print $0} }')
IFS=$'\n'

for entry in $filttered
do
  index=$(echo "$entry" | awk '{print $1}')
  mkdir "$directory/$index"

#Vaka treba pravilno, ama za da se istestira localno so git bash vtoroto gledajte go
#  allFilesForStudent=$(find ~/home/"$index" -type f -name "")
  allFilesForStudent=$(find ./ -type f -name "zad[0-9]-t[0-9].sh")
  for file in $allFilesForStudent
  do
    if [ -f "$directory/$index/$file" ]
    then

      areSame=1
      file1Lines=($(cat "$file"))
      file2Lines=($(cat "$directory/$index/$file"))
      if [ "${#file1Lines[@]}" -ne "${#file2Lines[@]}" ];
      then
        file1Size=$(ls -l "$file" | awk '{print $5}')
        file2Size=$(ls -l "$directory/$index/$file" | awk '{print $5}')
        if [ "$file1Size" -ge "$file2Size" ]; then
            rm "$directory/$index/$file"
            cp "$file" "$directory/$index/"
        fi
      else
        for (( i = 0; i < "${#file1Lines[@]}"; i++ )); do
            if [ "${file1Lines[$i]}" != "${file2Lines[$i]}" ];
            then
              areSame=0
              break
            fi
        done
        if [ "$areSame" -eq 0 ]; then
            file1Size=$(ls -l "$file" | awk '{print $5}')
            file2Size=$(ls -l "$directory/$index/$file" | awk '{print $5}')
            if [ "$file1Size" -ge "$file2Size" ]; then
                rm "$directory/$index/$file"
                cp "$file" "$directory/$index/"
            fi
        fi
      fi
    else
      cp "${file}" "$directory/$index/"
    fi
  done

done




