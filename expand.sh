#!/bin/bash
a="\"asn\" = '"
c="'"
b=$(whois -h whois.radb.net \!iAS-IU13WAN,1 | tr -d '\n' | grep -Po "AS[0-9]+" | grep -Po "[0-9]+" | awk -v d="' OR \"asn\" = '" '{s=(NR==1?s:s d)$0}END{print s}')
echo "AS-IU13WAN,$a$b$c" > as-sets.csv
exclude=$(whois -h whois.radb.net \!iAS-IU13WAN,1 | tr -d '\n' | grep -Po "AS[0-9]+" | grep -Po "[0-9]+" | awk -v d="|" '{s=(NR==1?s:s d)$0}END{print s}')
readarray -t objects < AS-SET.txt
for object in "${objects[@]}"
do
  #echo "$object,1"
  #echo "whois -h whois.radb.net \!i$object,1"
  b=$(whois -h whois.radb.net \!i$object,1 | tr -d '\n' | grep -Po "AS[0-9]+" | grep -Po "[0-9]+" | egrep -v "$exclude" |awk -v d="' OR \"asn\" = '" '{s=(NR==1?s:s d)$0}END{print s}')
  #echo "$object,$a$b$c"
  echo "$object,$a$b$c" >> as-sets.csv
done
