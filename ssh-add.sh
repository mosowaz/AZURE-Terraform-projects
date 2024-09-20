#!/bin/bash

eval $(ssh-agent)

if [ $? -eq 0 ]; 
then 
	ssh-add ~/.ssh/github
else
	echo -e "Invalid argument!"
fi
