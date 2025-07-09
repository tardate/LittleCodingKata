#!/usr/bin/env bash

source_path=./tmp/original
destination_path=./tmp/copy

if [ -e ${destination_path} ] ; then
  rm -fR ${destination_path}
fi
echo "Making a copy of ${source_path} in ${destination_path}"
cp -R ${source_path} ${destination_path}
