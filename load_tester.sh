#!/bin/bash

# load generating cURL script

DATE=`date +"%m-%d-%Y-%H-%M-%S"`
OUTPUT=\/tmp\/load_tester-$DATE.log
URL_TMP=$1
START_NUM=$2
END_NUM=$3
FAIL=0


URL_COMPLETE=$URL_TMP\?\[$START_NUM\-$END_NUM\]

# if the command was not passed with a parameter to name the report, it will exit
if [ -z "$URL_TMP" ]
then
	echo "incorrect syntax  "load_tester.sh URL STARTNUMBER ENDNUMBER""
  echo "example "load_tester.sh https://kong-admin-sandbox.6623-7082ab.cor00005.cna.ukcloud.com/routes/4201b21a-a45d-41f7-b9fd-7c530db6d0e4 1 3 3""
	echo "this will test that URL with ?1, ?2, ?3 appended to it and record results"
  exit 1
elif [ -z "$START_NUM" ]
then
	echo "incorrect syntax  "load_tester.sh URL STARTNUMBER ENDNUMBER""
  echo "example "load_tester.sh https://kong-admin-sandbox.6623-7082ab.cor00005.cna.ukcloud.com/routes/4201b21a-a45d-41f7-b9fd-7c530db6d0e4 1 3 3""
	echo "this will test that URL with ?1, ?2, ?3 appended to it and record results"
  exit 1
elif [ -z "$END_NUM" ]
then
	echo "incorrect syntax  "load_tester.sh URL STARTNUMBER ENDNUMBER""
  echo "example "load_tester.sh https://kong-admin-sandbox.6623-7082ab.cor00005.cna.ukcloud.com/routes/4201b21a-a45d-41f7-b9fd-7c530db6d0e4 1 3 3""
	echo "this will test that URL with ?1, ?2, ?3 appended to it and record results"
  exit 1
else
	echo "Running curl commands" 
fi



curl -w "@format" -o /dev/null $URL_COMPLETE >> $OUTPUT 2> /dev/null &
pidlist="$pidlist $!" 
curl -w "@format" -o /dev/null $URL_COMPLETE >> $OUTPUT 2> /dev/null &
pidlist="$pidlist $!" 
curl -w "@format" -o /dev/null $URL_COMPLETE >> $OUTPUT 2> /dev/null &
pidlist="$pidlist $!" 
curl -w "@format" -o /dev/null $URL_COMPLETE >> $OUTPUT 2> /dev/null &
pidlist="$pidlist $!" 
curl -w "@format" -o /dev/null $URL_COMPLETE >> $OUTPUT 2> /dev/null &
pidlist="$pidlist $!" 

for job in $pidlist; do
    echo thread pid $job
    wait $job || let "FAIL+=1"
done  


if [ "$FAIL" == "0" ]; then 
  echo "---Completed sucessfully---" 
else 
  echo "▄██████████████▄▐█▄▄▄▄█▌"
  echo "██████▌▄▌▄▐▐▌███▌▀▀██▀▀"
  echo "████▄█▌▄▌▄▐▐▌▀███▄▄█▌"
  echo "▄▄▄▄▄██████████████"
  echo "Oh noes, I have failed ($FAIL) times" 
fi