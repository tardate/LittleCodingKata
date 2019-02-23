#!/bin/bash

source_path=./original/
destination_path=./copy


echo "Performing pristine copy of ${source_path} to ${destination_path}"
rm -fR ${destination_path}
rsync -av ${source_path} ${destination_path}

echo "Adding 3.txt to source and removing 1.txt from dest"
echo "3" > ${source_path}3.txt
rm ${destination_path}/1.txt

echo "And update with sync.."
rsync -av ${source_path} ${destination_path}
