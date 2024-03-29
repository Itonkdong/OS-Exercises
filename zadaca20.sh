interface_names=$( grep -oE '^[a-z]*[0-9]*:' < ifconfig_output.txt)
mac_addresses=($(grep 'inet6' < ifconfig_output.txt | awk '{print $3}'))
ip_addresses=($( grep 'inet addr' < ifconfig_output.txt | awk '{split($2,tmp,":"); print tmp[2]}'))

#MNOGU VAZNO:
# OUTPUTOT NA AWK, GREP, SED, NE E NIZA, AMI STRING KOISTO E ODDELEN SO \N ZNACI.
# ZA DA SE DOBIE NIZA POTREBNO E VO USTE EDNI ZAGRADI DA SE STAVI CELIOT IZRAZ


i=0

for interface in $interface_names
do
  echo "Interface: $interface"
  echo "---------------------"
  echo "${ip_addresses[i]}"
  echo "${mac_addresses[i]}"
  echo ""
  i=$(("$i" + 1))
done