cat callslog.txt | awk -F"|" '{ if ($1 ~ /^+1[0-9]*9$/ && $3 % 2 == 0  && $4 % 2 == 0) {print $0}}' | awk -F"|" '{
split($2,charArray,"");
count=0;
for(i=0;i<length(charArray); i++){
if(charArray[i] == "8"){
count += 1
}
}
if (count >= 2) {
print $0
}
}' | awk -F"|" 'BEGIN {totalS = 0; totalPrice = 0} {totalS += $3 * 60; totalCalls+=1} END {average = totalS/totalCalls; print "Average is", average}'
