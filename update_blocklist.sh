#!/bin/bash
blocklist=$1
i=0
header="tmsh modify ltm dns cache transparent transparent_cache local-zones {"
#header="tmsh modify ltm dns cache validating-resolver resolvercache local-zones {"

footer="}"
thelist=""
echo "processing the block list: $blocklist"

while read line
do
    ((i=i+1))
    IFS=',' read -r -a array <<< "$line"
    zonename=${array[0]}
    wallgarden=${array[1]}
    if [ "$wallgarden" = "block" ]; then
      zone="{ name $zonename type static }"
   else
      zone="{ name $zonename records add { \"$zonename IN CNAME $wallgarden\" } type static }"
    fi
    echo "record number $i - $zonename --> $wallgarden"
    thelist="$thelist $zone"
done < $blocklist

echo "$header $thelist $footer" > update_run.sh
echo "running tmsh command..."
sh update_run.sh
echo "done"
