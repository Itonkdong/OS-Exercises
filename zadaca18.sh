#!/bin/bash

if [ "$#" -eq 0 ]; then
  echo "Send the user ID as an argument"
  exit 1
fi

user="$1"

# Dokolku koristis promenliva vo regex, stavi '', mesto ""
total_time=$(top -bn 1 | awk '$2 ~ /^'$user'/ {print $11}' | awk 'BEGIN{ hours=0;minutes=0;sec=0;} {
    split($1,h,":");
    hours+=h[1];
    split(h[2],ms,".")
    minutes+=ms[1]
    sec+=ms[2]
  } END{print hours * 3600 + minutes * 60 + sec}')

echo "The total time of the user $user is $total_time"

