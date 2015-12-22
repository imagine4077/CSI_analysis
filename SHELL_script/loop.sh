#!/bin/bash

time=$(date +%y%m%d-%H%M%S)
mkdir data/${time}
cd data/${time}

for i in $( seq 1 30 )
do
	echo "start, loop ${i}"
	echo "3"
	sleep 1
	echo "2"
	sleep 1
	echo "1"
	sleep 1
	/home/wifitest/Documents/zw/iperf_csi.sh &
	echo "0"
	sleep 27
	echo "terminate, loop ${i}"
done
echo "experiment done!"
cd ..
exit
