#!/bin/bash

function server () {
  while true
  do
    read method path version
    if [[ $method = 'GET' ]]
    then
      if [[ -f ./www$path ]]
      then
        file=$(cat ./www$path)
        echo -en "HTTP/1.1 200 OK\r\n \r\n$file"
      else
        echo -e "HTTP/1.1 404 Not Found\r\n"
      fi
    else
      echo -e "HTTP/1.1 404 Not Found\r\n"
    fi
  done
}

coproc SERVER_PROCESS { server; }

netcat -lv 2345 <&${SERVER_PROCESS[0]} >&${SERVER_PROCESS[1]}
