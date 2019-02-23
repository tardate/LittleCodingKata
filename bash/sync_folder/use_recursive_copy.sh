#!/bin/bash

source_path=./original
destination_path=./copy

if [ -e ${destination_path} ] ; then
  rm -fR ${destination_path}
fi
echo "Making a copy of ${source_path} in ${destination_path}"
cp -R ${source_path} ${destination_path}
