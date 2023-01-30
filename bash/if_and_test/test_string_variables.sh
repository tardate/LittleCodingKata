#!/bin/bash

VAR_SET=canary

echo -e "\n# = operator tests (equal):\n"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ "${VAR_SET}" = "canary" ]
then
  echo "it passes using [ \"\${VAR_SET}\" = \"canary\" ] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_SET}" = "canary" ]]
then
  echo "it passes using [[ \"\${VAR_SET}\" = \"canary\" ]] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [ "${VAR_NOT_SET}" = "canary" ]
then
  echo "fail"
else
  echo "returns false -> correctly fails using [ \"\${VAR_NOT_SET=}\" = \"canary\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi

if [[ "${VAR_NOT_SET}" = "canary" ]]
then
  echo "fail"
else
  echo "returns false -> correctly fails using [[ \"\${VAR_NOT_SET=}\" = \"canary\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi


echo -e "\n## == operator tests (equal):\n"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ "${VAR_SET}" == "canary" ]
then
  echo "returns true -> it passes using [ \"\${VAR_SET}\" == \"canary\" ] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_SET}" == "canary" ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_SET}\" == \"canary\" ]] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [ "${VAR_NOT_SET}" == "canary" ]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [ \"\${VAR_NOT_SET}\" == \"canary\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi

if [[ "${VAR_NOT_SET}" == "canary" ]]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [[ \"\${VAR_NOT_SET}\" == \"canary\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi


echo -e "\n## == operator tests (pattern matching):\n"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [[ "${VAR_SET}" == can* ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_SET}\" == can* ]] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_SET}" == cannot* ]]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [[ \"\${VAR_SET}\" == cannot* ]] # VAR_SET: ${VAR_SET}"
fi


echo -e "\n## != operator tests:\n"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ "${VAR_SET}" != "canary" ]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [ \"\${VAR_SET}\" != \"canary\" ] # VAR_SET: ${VAR_SET}"
fi

if [[ "${VAR_SET}" != "canary" ]]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [[ \"\${VAR_SET}\" != \"canary\" ]] # VAR_SET: ${VAR_SET}"
fi

if [ "${VAR_NOT_SET}" != "canary" ]
then
  echo "returns true -> it passes using [ \"\${VAR_NOT_SET}\" != \"canary\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_NOT_SET}" != "canary" ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_NOT_SET}\" != \"canary\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "returns false -> fail"
fi


echo -e "\n## -n operator tests (not null):\n"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ -n "$VAR_SET" ]
then
  echo "returns true -> it passes using [ -n \"\${VAR_SET}\" ] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [[ -n "$VAR_SET" ]]
then
  echo "returns true -> it passes using [[ -n \"\${VAR_SET}\" ]] # VAR_SET: ${VAR_SET}"
else
  echo "returns false -> fail"
fi

if [ -n "$VAR_NOT_SET" ]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [ -n \"\${VAR_NOT_SET}\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi

if [[ -n "$VAR_NOT_SET" ]]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [[ -n \"\${VAR_NOT_SET}\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
fi


echo -e "\n## -z operator tests (is null):\n"
echo "Given: VAR_SET=${VAR_SET} and VAR_NOT_SET not defined"

if [ -z "${VAR_SET}" ]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [ -z \"\${VAR_SET}\" ] # VAR_SET: ${VAR_SET}"
fi

if [[ -z "${VAR_SET}" ]]
then
  echo "returns true -> fail"
else
  echo "returns false -> correctly fails using [[ -z \"\${VAR_SET}\" ]] # VAR_SET: ${VAR_SET}"
fi

if [ -z "${VAR_NOT_SET}" ]
then
  echo "returns true -> it passes using [ -z \"\${VAR_NOT_SET}\" ] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "returns false -> fail"
fi

if [[ -z "${VAR_NOT_SET}" ]]
then
  echo "returns true -> it passes using [[ -z \"\${VAR_NOT_SET}\" ]] # VAR_NOT_SET: ${VAR_NOT_SET}"
else
  echo "returns false -> fail"
fi


echo -e "\n## =~ operator tests (regex matching):\n"
VAR_TEXT="a string with a canary in it"
echo "Given: VAR_TEXT=${VAR_TEXT}"

if [[ "${VAR_TEXT}" =~ .*canary.* ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_TEXT}\" =~ .*canary.* ]]"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_TEXT}" =~ canary.* ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_TEXT}\" =~ canary.* ]]"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_TEXT}" =~ "canary" ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_TEXT}\" =~ "canary" ]]"
else
  echo "returns false -> fail"
fi

if [[ "${VAR_TEXT}" =~ ca..ry ]]
then
  echo "returns true -> it passes using [[ \"\${VAR_TEXT}\" =~ ca..ry ]]"
else
  echo "returns false -> fail"
fi
