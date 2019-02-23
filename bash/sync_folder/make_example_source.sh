#!/bin/bash
source_path=./original

echo "Making a fresh copy of ${source_path}"
rm -fR ${source_path}
mkdir ${source_path}
echo "1" > ${source_path}/1.txt
echo "2" > ${source_path}/2.txt
mkdir ${source_path}/sub1
echo "sub1 1" > ${source_path}/sub1/1.txt
echo "sub1 2" > ${source_path}/sub1/2.txt
mkdir ${source_path}/sub2
echo "sub2 2" > ${source_path}/sub2/1.txt
echo "sub2 2" > ${source_path}/sub2/2.txt
