#!/bin/bash

command_list=("kops version"
    "kubectl version --client"
    "kops version")

for ((i = 0; i < ${#command_list[@]}; i++))
do
    echo "Running '${command_list[$i]}':"
    docker run --rm --name test1 sudermanjr/utilities:$1 ${command_list[$i]}
    echo "Exit Code: $?"
done
