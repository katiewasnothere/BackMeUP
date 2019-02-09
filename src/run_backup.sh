#!/bin/bash

disks=`df -h  | tr -s ' ' | cut -d" " -f 9 | grep "/Volumes/"`
disks_arr=($disks)
original_length=${#disks_arr[@]}

disk1=""
disk2=""

new_disks=""
new_arr=()
new_arr_length=0

while true; do
	new_disks=`df -h  | tr -s ' ' | cut -d" " -f 9 | grep "/Volumes/"`
	new_arr=($new_disks)
	new_arr_length=${#new_arr[@]}
	echo "new len: $new_arr_length"
	temp_length=$((original_length + 2))
	if [[ $new_arr_length == $temp_length ]]; then
		disk1=${new_arr[$((original_length + 0))]}
		disk2=${new_arr[$((original_length + 1))]} 
		break
	fi
done

rsync -a -P $disk1 $disk2
