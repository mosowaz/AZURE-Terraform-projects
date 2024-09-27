#!/bin/bash

cd ~/Desktop/Projects/project-2/network && terraform validate
if [ $? -eq 0 ]; then
   terraform apply --auto-approve
   sleep 3

   if [ $? -ne 0 ]; then
      echo "terraform apply failed"
      exit 1
   fi
else 
   echo -e "Wrong directory or code validation failed" \\n
   exit 2
fi

cd ~/Desktop/Projects/project-2/compute && terraform validate
if [ $? -eq 0 ]; then
   terraform apply --auto-approve
   sleep 3

   if [ $? -ne 0 ]; then
      echo "terraform apply failed"
      exit 3
   fi
else 
   echo -e "Wrong directory or code validation failed" \\n
   exit 4
fi

cd ~/Desktop/Projects/project-2/rt_table-nsg && terraform validate
if [ $? -eq 0 ]; then
   terraform apply --auto-approve
   sleep 3

   if [ $? -ne 0 ]; then
      echo "terraform apply failed"
      exit 5
   fi
else 
   echo -e "Wrong directory or code validation failed" \\n
   exit 6
fi