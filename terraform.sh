#!/bin/sh

PROVIDER=$1
ACTION=$2

cd $PROVIDER
if [ $ACTION == "create" ]; then
	terraform init
	terraform apply -auto-approve
elif [ $ACTION == "destroy" ]; then
	terraform destroy -force
fi

exit 0