#!/bin/bash
echo 
read -r -p "Would you like to copy files in? [y/N] " response
if [[ "${response}" =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo "Enter dir path of files:"
    read dirPath
    cp -a ${dirPath}/. dir2
fi