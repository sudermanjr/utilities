#!/bin/bash

command_list=("kops version"
    "kubectl version --client"
    "helm version --client"
    "vault version")

mkdir -p test-results
echo "Utility Versions:" > test-results/versions.txt
echo "" >> test-results/versions.txt
echo "" >> test-results/versions.txt
errors=0
for ((i = 0; i < ${#command_list[@]}; i++))
do
    echo "Running '${command_list[$i]}':" >> test-results/versions.txt 
    docker run --rm  $1 ${command_list[$i]} >> test-results/versions.txt
    if [ $? -ne 0 ]
    then
      echo "Test '${command_list[$i]}' FAILED!" >> test-results/errors.txt
      ((errors+=1))
    fi
done

exit $errors
