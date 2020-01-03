#!/bin/bash

# load generating cURL script

curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!"  

for job in $pidlist; do
    echo $job
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