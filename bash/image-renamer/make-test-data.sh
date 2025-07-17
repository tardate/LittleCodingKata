#!/usr/bin/env bash

source_path=./assets/sample-data
dest_path=./example-data

echo "Making a fresh copy of ${dest_path}"
rm -fR ${dest_path}
mkdir -p ${dest_path}
cp -R ${source_path}/* ${dest_path}
