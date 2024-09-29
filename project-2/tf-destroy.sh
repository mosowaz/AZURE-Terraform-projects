#!/bin/bash

cd ~/Desktop/Projects/project-2/rt_table-nsg && terraform apply -destroy --auto-approve
if [ $? -ne 0 ]
then 
    echo -e "Failed to destroy. Check directory"
    exit 1
fi

cd ~/Desktop/Projects/project-2/compute && terraform apply -destroy --auto-approve
if [ $? -ne 0 ]
then 
    echo -e "Failed to destroy. Check directory"
    exit 2
fi

cd ~/Desktop/Projects/project-2/network && terraform apply -destroy --auto-approve
if [ $? -ne 0 ]
then 
    echo -e "Failed to destroy. Check directory"
    exit 3
fi