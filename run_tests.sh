#!/bin/bash

command_list=("kops version"
    "kubectl version --client"
    "kops version"
    "helm version --client")

for ((i = 0; i < ${#command_list[@]}; i++))
do
    echo "Running '${command_list[$i]}':"
    docker run --rm  $1 ${command_list[$i]}
    if [ $? -ne 0 ]
    then
      echo "Test '${command_list[$i]}' FAILED!"
      exit 1
    fi
done
