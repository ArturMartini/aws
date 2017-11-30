#!/bin/bash

export IDS_ALL_RUN=""
export IDS_ALL_RUN_DESC=""
export IDS_KEEP_RUN=""
export IDS_KEEP_RUN_DESC=""
export IDS_DOWN=""
export IDS_DOWN_DESC=""
export EMAILS="your_email@domain.com"

IDS_ALL_RUN=$(aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" | grep InstanceId |sed "s/\"InstanceId\": \"/ /g" | sed 's/\"//g' | sed 's/,//g')


IDS_KEEP_RUN=$(aws ec2 describe-tags --filters Name="key",Values="NoShutdown" | grep ResourceId | sed "s/\"ResourceId\": \"/ /g" | sed 's/\"//g' | sed 's/,//g')



for ID in ${IDS_ALL_RUN}
do
	IDS_ALL_RUN_DESC="${IDS_ALL_RUN_DESC} Running | ${ID} - $(aws ec2 describe-tags --filters "Name=resource-id,Values=${ID}" "Name=key,Values=Name" | grep \"Value\":)\n" 

done

for ID in ${IDS_KEEP_RUN}
do
	IDS_KEEP_RUN_DESC="${IDS_KEEP_RUN_DESC} Running | ${ID} - $(aws ec2 describe-tags --filters "Name=resource-id,Values=${ID}" "Name=key,Values=Name" | grep \"Value\":)\n"
done

for ID in ${IDS_KEEP_RUN}
do
	IDS_ALL_RUN=$(echo "${IDS_ALL_RUN}" | sed "s/${ID}//g")
done
for ID in ${IDS_ALL_RUN}
do
	IDS_DOWN_DESC="${IDS_DOWN_DESC} Stoping | ${ID} - $(aws ec2 describe-tags --filters "Name=resource-id,Values=${ID}" "Name=key,Values=Name" | grep \"Value\":)\n"
done


export EC2_DESC="\n\nRelatório EC2\n------------------------------------------------\nMáquinas running:\n${IDS_ALL_RUN_DESC}\n\nMaquinas keep running:\n${IDS_KEEP_RUN_DESC}\n\nMaquinas stoping:\n${IDS_DOWN_DESC}\n------------------------------------------------\n"

echo -e "${EC2_DESC}"
echo "----------------------------------------------------"
echo "- Alert AWS EC2 Instances - $(date)"

echo -e "Iniciado o processo de shutdown do ambiente AWS.\n\nO processo será executado dentro de 30 minutos.\n\nCaso queira parar o processo, entrar na máquinas Peer, digitar o comando crontab -e e comentar as linha.\n\nViva o shell script \o/ =)${EC2_DESC}" | mail -s "AWS Shutdown \o/" ${EMAILS}

echo "- Alert finished. - $(date)"
echo "----------------------------------------------------"
