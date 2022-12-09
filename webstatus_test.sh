#!/bin/bash

#List all resources
curl http://192.168.0.192/

echo "---------------------------------"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw '{
"mode" : "CHECK_TOKEN"
}' | grep "\"status\":\"ERROR\"\|\"data\":\"\""


echo "---------------------------------"
echo "Tests with cURL: GET_USERDATA"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw '{
"mode" : "GET_USERDATA",
"replPattern" : "##HOSTNAME##"
}' | grep "\"status\":\"ERROR\"\|\"message\":\"unable to show data - user not logged in!"


echo "---------------------------------"
echo "Tests with cURL: GET_DEVICEDATA"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw '{
"mode" : "GET_DEVICEDATA",
"replPattern" : "##HOSTNAME##"
}' | grep "\"status\":\"SUCCESS\"\|\"data\":{\"replPattern\":\"RevPi"


echo "---------------------------------"
echo "Tests with cURL: LOGIN"
PW_MD5=$(echo -n or7220 | md5sum | cut -d ' ' -f 1)
DATA_RAW="{\"mode\" : \"LOGIN\",
\"username\" : \"admin\",
\"hashcode\" : \"$PW_MD5\"}"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw "$DATA_RAW" | grep "\"status\":\"SUCCESS\"\|\"data\":{\"hostname\":\"RevPi\|\"sessionId\":"


echo "---------------------------------"
echo "Tests with cURL: LOGOUT"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw '{
"mode" : "LOGOUT"
}' | grep "\"status\":\"SUCCESS\"\|\"data\":{}"


echo "---------------------------------"
echo "Tests with cURL: CHANGE_PASSWORD"
PW_MD5=$(echo -n or7220 | md5sum | cut -d ' ' -f 1)
PW_MD5_NEW=$(echo -n PW_LAVA_TEST | md5sum | cut -d ' ' -f 1)
DATA_RAW="{\"mode\" : \"CHANGE_PASSWORD\",
\"username\" : \"admin\",
\"hashcode\" : \"$PW_MD5\",
\"newHashcode\" : \"$PW_MD5_NEW\",
\"removeResetPW\" : \"\"}"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw "$DATA_RAW" | grep "\"status\":\"SUCCESS\"\|\"data\":{\"hostname\":\"RevPi\|\"sessionId\":"


echo "---------------------------------"
echo "Tests with cURL: LOGIN"
PW_MD5=$(echo -n PW_LAVA_TEST | md5sum | cut -d ' ' -f 1)
DATA_RAW="{\"mode\" : \"LOGIN\",
\"username\" : \"admin\",
\"hashcode\" : \"$PW_MD5\"}"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw "$DATA_RAW" | grep "\"status\":\"SUCCESS\"\|\"data\":{\"hostname\":\"RevPi\|\"sessionId\":"


echo "---------------------------------"
echo "Tests with cURL: RESET_PASSWORD"
DATA_RAW="{\"mode\" : \"RESET_PASSWORD\",
\"username\" : \"admin\"}"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw "$DATA_RAW" | grep "\"status\":\"SUCCESS\"\|\"message\":\"\""


echo "---------------------------------"
echo "Tests with cURL: READ_STATUS"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw '{
"mode" : "READ_STATUS"
}' | grep "\"status\":\"ERROR\"\|\"message\":\"unable to show data - user not logged in!"


echo "---------------------------------"
echo "Tests with cURL: READ_CONFIG"
curl --verbose --location 'http://192.168.0.192:41080/php/dal.php' \
--header 'Content-Type: application/json' \
--data-raw '{
"mode" : "READ_CONFIG"
}' | grep "\"status\":\"ERROR\"\|\"message\":\"unable to show data - user not logged in!"

