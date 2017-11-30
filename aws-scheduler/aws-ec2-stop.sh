#!/bin/bash

echo "----------------------------------------------------"
echo "- Stoping AWS EC2 Instances - $(date)"

export IDS_NO_DOWN=$(aws ec2 describe-tags --filters Name="key",Values="NoShutdown" | grep ResourceId | sed "s/\"ResourceId\": \"/ /g" | sed 's/\"//g' | sed 's/,//g')

export IDS_ALL=$(aws ec2 describe-instances | grep InstanceId |sed "s/\"InstanceId\": \"/ /g" | sed 's/\"//g' | sed 's/,//g')

echo "--IDS_NO_DOWN=${IDS_NO_DOWN}"

for ID in ${IDS_NO_DOWN}
do
	echo $ID
	IDS_ALL=$(echo "${IDS_ALL}" | sed "s/${ID}//g")
done

echo "--IDS_ALL=${IDS_ALL}"

aws ec2 stop-instances --instance-ids ${IDS_ALL} 

echo "- Stoping finished. - $(date)"
echo "----------------------------------------------------"
echo
