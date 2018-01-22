#!/bin/bash

PROVIDER=$1
ACTION=$2

cd $PROVIDER
if [ $? -ne 0 ]; then
	echo "Unsupported provider: $PROVIDER"
	exit 1
fi
if [ $ACTION == "create" ]; then
	terraform init
	terraform apply -auto-approve
	if [ $? -ne 0 ]; then
		echo "Error on terraform apply command execution"
		exit 1
	fi
elif [ $ACTION == "destroy" ]; then
	terraform destroy -force
else
	echo "Unknown action: $ACTION"
	exit 1
fi

exit 0
