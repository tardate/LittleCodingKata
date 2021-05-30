#!/bin/bash

VAR_SET=canary

echo -e "\n# = operator tests (equal):"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ "${VAR_SET}" = "canary" ]
then
  echo "it passes using [ \"\${VAR_SET}\" = \"canary\" ] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [[ "${VAR_SET}" = "canary" ]]
then
  echo "it passes using [[ \"\${VAR_SET}\" = \"canary\" ]] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [ "${VAR_NOT_SET}" = "canary" ]
then
  echo "fail"
else
  echo "correctly fails using [ \"\${VAR_NOT_SET=}\" = \"canary\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi

if [[ "${VAR_NOT_SET}" = "canary" ]]
then
  echo "fail"
else
  echo "correctly fails using [[ \"\${VAR_NOT_SET=}\" = \"canary\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi


echo -e "\n## == operator tests (equal):"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ "${VAR_SET}" == "canary" ]
then
  echo "it passes using [ \"\${VAR_SET}\" == \"canary\" ] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [[ "${VAR_SET}" == "canary" ]]
then
  echo "it passes using [[ \"\${VAR_SET}\" == \"canary\" ]] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [ "${VAR_NOT_SET}" == "canary" ]
then
  echo "fail"
else
  echo "correctly fails using [ \"\${VAR_NOT_SET}\" == \"canary\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi

if [[ "${VAR_NOT_SET}" == "canary" ]]
then
  echo "fail"
else
  echo "correctly fails using [[ \"\${VAR_NOT_SET}\" == \"canary\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi


echo -e "\n## == operator tests (pattern matching):"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [[ "${VAR_SET}" == can* ]]
then
  echo "it passes using [[ \"\${VAR_SET}\" == can* ]] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [[ "${VAR_SET}" == cannot* ]]
then
  echo "fail"
else
  echo "correctly fails using [[ \"\${VAR_SET}\" == cannot* ]] # VAR_SET: ${VAR_SET}"
fi


echo -e "\n## != operator tests:"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ "${VAR_SET}" != "canary" ]
then
  echo "fail"
else
  echo "correctly fails using [ \"\${VAR_SET}\" != \"canary\" ] # VAR_SET: ${VAR_SET}"
fi

if [[ "${VAR_SET}" != "canary" ]]
then
  echo "fail"
else
  echo "correctly fails using [[ \"\${VAR_SET}\" != \"canary\" ]] # VAR_SET: ${VAR_SET}"
fi

if [ "${VAR_NOT_SET}" != "canary" ]
then
  echo "it passes using [ \"\${VAR_NOT_SET}\" != \"canary\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "fail"
fi

if [[ "${VAR_NOT_SET}" != "canary" ]]
then
  echo "it passes using [[ \"\${VAR_NOT_SET}\" != \"canary\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "fail"
fi


echo -e "\n## -n operator tests (not null):"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ -n "$VAR_SET" ]
then
  echo "it passes using [ -n \"\${VAR_SET}\" ] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [[ -n "$VAR_SET" ]]
then
  echo "it passes using [[ -n \"\${VAR_SET}\" ]] # VAR_SET: ${VAR_SET}"
else
  echo "fail"
fi

if [ -n "$VAR_NOT_SET" ]
then
  echo "fail"
else
  echo "correctly fails using [ -n \"\${VAR_NOT_SET}\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi

if [[ -n "$VAR_NOT_SET" ]]
then
  echo "fail"
else
  echo "correctly fails using [[ -n \"\${VAR_NOT_SET}\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi


echo -e "\n## -z operator tests (is null):"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ -z "${VAR_SET}" ]
then
  echo "fail"
else
  echo "correctly fails using [ -z \"\${VAR_SET}\" ] # VAR_SET: ${VAR_SET}"
fi

if [[ -z "${VAR_SET}" ]]
then
  echo "fail"
else
  echo "correctly fails using [[ -z \"\${VAR_SET}\" ]] # VAR_SET: ${VAR_SET}"
fi

if [ -z "${VAR_NOT_SET}" ]
then
  echo "it passes using [ -z \"\${VAR_NOT_SET}\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "fail"
fi

if [[ -z "${VAR_NOT_SET}" ]]
then
  echo "it passes using [[ -z \"\${VAR_NOT_SET}\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "fail"
fi


echo -e "\n## =~ operator tests (regex matching):"

VAR_TEXT="a string with a canary in it"
echo "Given: VAR_TEXT=${VAR_TEXT}"

if [[ "${VAR_TEXT}" =~ .*canary.* ]]
then
  echo "it passes using [[ \"\${VAR_TEXT}\" =~ .*canary.* ]]"
else
  echo "fail"
fi

if [[ "${VAR_TEXT}" =~ canary.* ]]
then
   echo "it passes using [[ \"\${VAR_TEXT}\" =~ canary.* ]]"
else
  echo "fail"
fi

if [[ "${VAR_TEXT}" =~ "canary" ]]
then
   echo "it passes using [[ \"\${VAR_TEXT}\" =~ "canary" ]]"
else
  echo "fail"
fi

if [[ "${VAR_TEXT}" =~ ca..ry ]]
then
   echo "it passes using [[ \"\${VAR_TEXT}\" =~ ca..ry ]]"
else
  echo "fail"
fi
