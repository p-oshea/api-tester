#!/bin/sh

# load generating cURL script

curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!" 
curl -s "http://api-tester.test.svc:8080/api/v1/books/authors/{a, Garcia}?[1-1000]" &
pidlist="$pidlist $!"  

for i in $pidlist do 
  echo $i    
  wait $i || let "FAIL+=1" 
done  

if [ "$FAIL" == "0" ]; then 
  echo "---Completed sucessfully---" 
else 
  echo "▄██████████████▄▐█▄▄▄▄█▌"
  echo "██████▌▄▌▄▐▐▌███▌▀▀██▀▀"
  echo "████▄█▌▄▌▄▐▐▌▀███▄▄█▌"
  echo "▄▄▄▄▄██████████████"
  echo "($FAIL)" 
fi