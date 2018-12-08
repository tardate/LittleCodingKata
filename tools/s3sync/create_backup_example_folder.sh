#!/bin/bash
#
# simple script to create something to backup

folder=backup_example_folder

if [ -d ${folder} ]
then
  echo "Removing existing ${folder}.."
  rm -fR ${folder}
fi

echo "Creating ${folder}.."
mkdir ${folder}

for basename in "test1" "test2" "test3"
do
  filename=${folder}/${basename}.txt
  echo ".. adding ${filename}"
  echo "${basename} @ $(date)" > ${filename}
done

mkdir ${folder}/docs

for basename in "doc1" "doc2" "doc3"
do
  filename=${folder}/docs/${basename}.txt
  echo ".. adding ${filename}"
  echo "${basename} @ $(date)" > ${filename}
done

echo "done."
