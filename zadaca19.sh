#!/bin/bash

if [ "$#" -eq 0 ]; then
  echo "Send the name of the file where you want to save the result"
  exit 1
fi

#Bidejki netstat -r ne raboti za obicni korisnici bez soodvetni privilegii, vo netstat_stats.txt e zapishan e eden primer na izlez od netstat -r, za da moze da se istestira zadacata

file_to_save="$1"

echo -n "" | cat > "$file_to_save"

interfaces=$(awk '$NF != "Iface" {print $NF}' < netstat_stats.txt | uniq)
addresses=$(awk '$NF != "Iface" {print $NF}' < netstat_stats.txt )
for interface in $interfaces
do
  counter=0
  for addrres in $addresses
  do
    if [ "$interface" = "$addrres" ]; then
        counter=$(("$counter" + 1))
    fi
  done
  echo "Interface: $interface - Destinations: $counter" | cat >> "$file_to_save"
done

