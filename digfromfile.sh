#!/bin/bash
servertodig=$1
testnum=0
failnum=0
while true
do
echo "------------------------------------------"
while read line
do
        dig @$servertodig $line A > /tmp/dig_$line
        cat /tmp/dig_$line | grep NOERROR > /dev/null
        if [ $? -eq 0 ]
        then
          querytime=`cat /tmp/dig_$line | grep 'Query time' | cut -d ':' -f2 `
          echo -e "$line \e[32mOK\e[39m - $querytime"
        else
          echo -e "$line \e[31mFAIL\e[39m"
          ((failnum=failnum+1))
        fi
        ((testnum=testnum+1))
done < domains2dig.txt
echo "# of test done: $testnum"
echo "# of fail: $failnum"
sleep 5
done
