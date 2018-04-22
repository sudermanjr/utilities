#!/bin/bash

command_list=("kops version"
    "kubectl version --client"
    "helm version --client"
    "vault version")

mkdir -p test-results/basic
echo "Utility Versions:\n\n" > test-results/basic/versions.txt
errors=0
for ((i = 0; i < ${#command_list[@]}; i++))
do
    echo "Running '${command_list[$i]}':" >> test-results/basic/versions.txt 
    docker run --rm  $1 ${command_list[$i]} >> test-results/basic/versions.txt
    if [ $? -ne 0 ]
    then
      echo "Test '${command_list[$i]}' FAILED!" >> test-results/basic/errors.txt
      ((errors+=1))
    fi
done

exit $errors
