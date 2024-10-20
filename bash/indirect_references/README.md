# #180 References

Indirect variable de-referencing in bash scripts.

## Notes

Indirect references: using a variable that holds the name of another variable.
Indirection like that makes it possible to do all kinds of programming tricks in Bash that one really should not: mimic 2D/3D arrays etc.

But it can be useful for simple cases.


## Old Style

The old approach is actually quite tricky and doesn't actually need any new features.

If our variable of interest is called "X_value":

    X_value="the actual value"

An we have another variable called "variable_name" that will holder the name of the variable we will lookup:

    variable_name="X_value"

Then we can evaluate the result of echoing "variable_name" in a variable format:

    eval \$$variable_name

i.e. `\$$variable_name` will produce the string "$X_value", which is then evaluated as a command, returning "the actual value"

## New Syntax

A dollar-bang syntax was introduced in Bash version 2.

Instead of:

    eval \$$variable_name

Simply:

    ${!variable_name}


## Running the Example

See [examples.sh](./examples.sh) for a full example and test:

```
$ ./examples.sh
Three variables are defined:
  ${X_value}: "the X value"
  ${Y_value}: "the Y value"
  ${Z_value}: "the Z value"

We have a variable "${selected}" that selects for X, Y or Z
Currently:
  ${selected}: "X"

And ${selected} is used to construct the variable name we are interested in, stored in "$variable_name":
  variable_name="${selected}_value"
Currently:
  ${variable_name}: "X_value"

And finally we indirectly lookup the value of the variable referenced in ${variable_name}:
  selected_value=${!variable_name}
Currently:
  ${selected_value}: "the X value"
Success! ${selected_value} is returning the correct value

Changing "${selected}" to Y
Currently:
  ${selected}: "Y"
  ${variable_name}: "Y_value"
  ${selected_value}: "the Y value"
Success! ${selected_value} is returning the correct value

Older/alternative syntax for indirectly lookup is to evaluate with double-dollars: \$${variable_name}:
  eval selected_value=\$${variable_name}
Currently:
  ${selected}: "Z"
  ${variable_name}: "Z_value"
  ${selected_value}: "the Z value"
Success! ${selected_value} is returning the correct value
```

## Credits and References

* [Advanced Bash-Scripting Guide: Chapter 28. Indirect References](https://tldp.org/LDP/abs/html/ivr.html)
