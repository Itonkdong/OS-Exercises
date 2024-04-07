IFS=$'\n'
fileNames=($(cat input.json | grep 'filepath' | awk -F":" '{print $2}' | sed s/\"//g))
durations=($(cat input.json | grep 'duration' | awk -F":" '{print $2}' | sed s/\"//g))
fileSizes=($(cat input.json | grep 'filesize' | awk -F":" '{print $2}' | sed s/\"//g))

if [ ! -f "./output.csv" ]; then
    touch "./output.csv"
fi

i=0
totalDuration=0

for duration in "${durations[@]}"
do
  forrmated=$(echo "$duration" | sed s/,// | sed 's/ //')
  totalDuration=$(echo "$forrmated" | awk -v total="$totalDuration" '{da=total+$1; print da}')
done

average=$(echo $totalDuration | awk -v num="${#durations[@]}" '{av=$1/num; print av}')

echo "id, filepath, filesize, is_longer" | cat >> "./output.csv"

for file in "${fileNames[@]}"
do
  duration="${durations[$i]}"
  formated=$(echo "$duration" | sed s/,// | sed 's/ //')
  fileSize="${fileSizes[$i]}"

  is_longer=$(echo "$formated" | awk -v avg="$average" '{ if ($1 > avg) { print 1 } else { print 0 } }')
  echo "$(( i + 1 )),${file}${fileSize}, ${is_longer}" | cat >> "./output.csv"
  i=$(( i + 1))
done
