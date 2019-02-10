#!/bin/bash

disks=`df -h  | tr -s ' ' | cut -d" " -f 6 | grep "/media/pi/"`
disks_arr=($disks)
original_length=${#disks_arr[@]}

disk1=""
disk2=""

new_disks=""
new_arr=()
new_arr_length=0

while true; do
	new_disks=`df -h  | tr -s ' ' | cut -d" " -f 6 | grep "/media/pi/"`
	new_arr=($new_disks)
	new_arr_length=${#new_arr[@]}
	temp_length=$((original_length + 2))
	if [[ $new_arr_length == $temp_length ]]; then
		disk1=${new_arr[$((original_length + 0))]}
		disk2=${new_arr[$((original_length + 1))]} 
		echo "got both disks"
		echo $disk1
		echo $disk2
		break
	fi
done

rsync -a -P $disk1/ $disk2

if [ "$?" -eq "0" ]; then
	# success
	omxplayer --no-keys ~/BackMeUp/music/centuryfox.mp3 &
else
	# some sort of failure
	omxplayer --no-keys ~/BackMeUp/music/womp.mp3 &
fi
