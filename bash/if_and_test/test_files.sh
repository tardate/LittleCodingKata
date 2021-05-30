#!/bin/bash

echo -e "\n# -e operator tests (file exists):"

if [ -e "./test_files.sh" ]
then
  echo "correctly returns true for [ -e \"./test_files.sh\" ]"
else
  echo "fail"
fi

if [ -e "./bogative.sh" ]
then
  echo "fail"
else
  echo "correctly returns false for [ -e \"./bogative.sh\" ]"
fi

echo -e "\n# ! -e operator tests (not file exists):"

if [ ! -e "./bogative.sh" ]
then
  echo "correctly returns true for [ ! -e \"./bogative.sh\" ]"
else
  echo "fail"
fi


echo -e "\n# -f operator tests (is a file):"

if [ -f "./test_files.sh" ]
then
  echo "correctly returns true for [ -f \"./test_files.sh\" ]"
else
  echo "fail"
fi

if [ -f "../if_and_test" ]
then
  echo "fail"
else
  echo "correctly returns false for [ -f \"../if_and_test\" ]"
fi

if [ -f "./bogative.sh" ]
then
  echo "fail"
else
  echo "correctly returns false for [ -f \"./bogative.sh\" ]"
fi


echo -e "\n# -d operator tests (is a directory):"

if [ -d "../if_and_test" ]
then
  echo "correctly returns true for [ -d \"../if_and_test\" ]"
else
  echo "fail"
fi

if [ -d "./test_files.sh" ]
then
  echo "fail"
else
  echo "correctly returns false for [ -d \"./test_files.sh\" ]"
fi

if [ -d "./bogative.sh" ]
then
  echo "fail"
else
  echo "correctly returns false for [ -d \"./bogative.sh\" ]"
fi
