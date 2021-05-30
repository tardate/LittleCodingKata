#!/bin/bash

X_value="the X value"
Y_value="the Y value"
Z_value="the Z value"
selected=X
variable_name=${selected}_value
selected_value=${!variable_name}

echo "Three variables are defined:"
echo "  \${X_value}: \"${X_value}\""
echo "  \${Y_value}: \"${Y_value}\""
echo "  \${Z_value}: \"${Z_value}\""
echo ""
echo "We have a variable \"\${selected}\" that selects for X, Y or Z"
echo "Currently:"
echo "  \${selected}: \"${selected}\""
echo ""
echo "And \${selected} is used to construct the variable name we are interested in, stored in \"\$variable_name\":"
echo "  variable_name=\"\${selected}_value\""
echo "Currently:"
echo "  \${variable_name}: \"${variable_name}\""
echo ""
echo "And finally we indirectly lookup the value of the variable referenced in \${variable_name}:"
echo "  selected_value=\${!variable_name}"
echo "Currently:"
echo "  \${selected_value}: \"${selected_value}\""

if [ "${selected_value}" == "the X value" ]
then
  echo "Success! \${selected_value} is returning the correct value"
else
  echo "fail!"
fi

selected=Y
variable_name=${selected}_value
selected_value=${!variable_name}

echo ""
echo "Changing \"\${selected}\" to Y"
echo "Currently:"
echo "  \${selected}: \"${selected}\""
echo "  \${variable_name}: \"${variable_name}\""
echo "  \${selected_value}: \"${selected_value}\""

if [ "${selected_value}" == "the Y value" ]
then
  echo "Success! \${selected_value} is returning the correct value"
else
  echo "fail!"
fi

selected=Z
variable_name=${selected}_value
eval selected_value=\$${variable_name}

echo ""
echo "Older/alternative syntax for indirectly lookup is to evaluate with double-dollars: \\\$\${variable_name}:"
echo "  eval selected_value=\\\$\${variable_name}"
echo "Currently:"
echo "  \${selected}: \"${selected}\""
echo "  \${variable_name}: \"${variable_name}\""
echo "  \${selected_value}: \"${selected_value}\""

if [ "${selected_value}" == "the Z value" ]
then
  echo "Success! \${selected_value} is returning the correct value"
else
  echo "fail!"
fi
