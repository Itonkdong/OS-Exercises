
getFiles(){
  fromTime="$1"
  toTime="$2"
  files=$(find ../ -type f -name "*.txt")
  for file in $files
  do
    dayOfFIle=$(ls -l "$file" | awk '{print $7}')
    if [ "$dayOfFIle" -ge "$fromTime" ] && [ "$dayOfFIle" -le "$toTime" ];
    then
        echo "$file"
    fi

  done

}

findAllTextFiles()
{
  files="$1"
  destination="$2"
  for file in $files
  do
    size=$(ls -l "$file" | awk '{print $5}')
    if [ "$size" -gt 100 ]
    then
        totalEchoCount=$(cat "$file" | grep -o 'echo' | wc -w)
        newName="$destination/226009_$totalEchoCount.txt"
        z=0
        if [ -f "$newName" ];
        then
            z=$(find "$destination" -maxdepth 1 -type f -name "226009_${totalEchoCount}*.txt" | wc -l)
            newName="$destination/226009_${totalEchoCount}${z}.txt"
            cp "$file" "$newName"
        else
            cp "$file" "$newName"
        fi
    fi
  done
}

if [ "$#" -ne 3 ]; then
    echo "Invalid use of the script"
    exit 1
fi

destination="$3"

if [ ! -d "$destination" ]
then
  echo "Creating folder $destination"
  mkdir "$destination"
fi

startTime="$1"
endTime="$2"

filteredFiles=$(getFiles "$startTime" "$endTime")
findAllTextFiles "$filteredFiles" "$destination"