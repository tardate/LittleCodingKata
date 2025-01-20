# #260 Parameter Substitution

All about Bash parameter substitution.

## Notes

The `${}` syntax is used to manipulating and/or expanding variables.

### Explicit Reference

`${parameter}`

### Reference with Default

`${parameter-default}`, `${parameter:-default}`

If parameter not set, use default. Does not modify the variable.
The `:` form also applies the substitution when the parameter is set but is null.

### Reference with Set Default

`${parameter=default}`, `${parameter:=default}`

If parameter not set, set it to default.
The `:` form also applies the substitution when the parameter is set but is null.

### Alternate Value

`${parameter+alt_value}`, `${parameter:+alt_value}`

If parameter set, use alt_value, else use null string.
The `:` form also applies the substitution when the parameter is set but is null.

### Reference Or Error

`${parameter?err_msg}`, `${parameter:?err_msg}`

If parameter set, use it, else print err_msg and abort the script with an exit status of 1
The `:` form also applies the substitution when the parameter is set but is null.

### Variable length

`${#var}`

String length (number of characters in $var).

For an array:

* `${#array}` is the length of the first element in the array
* `${#array[*]}` and `${#array[@]}` give the number of elements in the array

### Remove Leading Match

`${var#Pattern}` Remove from $var the shortest part of $Pattern that matches the front end of $var.

`${var##Pattern}` Remove from $var the longest part of $Pattern that matches the front end of $var.

### Remove Trailing Match

`${var%Pattern}` Remove from $var the shortest part of $Pattern that matches the back end of $var.

`${var%%Pattern}` Remove from $var the longest part of $Pattern that matches the back end of $var.

### Variable expansion

`${var:pos}` Variable var expanded, starting from offset pos.

`${var:pos:len}` Expansion to a max of len characters of variable var, from offset pos

### Substring replacement

`${var/Pattern/Replacement}` First match of Pattern, within var replaced with Replacement.

`${var//Pattern/Replacement}` Global replacement. All matches of Pattern, within var replaced with Replacement

`${var/#Pattern/Replacement}` If prefix of var matches Pattern, then substitute Replacement for Pattern.

`${var/%Pattern/Replacement}` If suffix of var matches Pattern, then substitute Replacement for Pattern.

## Example Script

See [example.sh](./example.sh):

```bash
$ ./example.sh
## Explicit Reference
Given:
  var1=value1
${var1}: value1
## Reference with Default
Given:
  var2= (null)
  var3= (undefined)
${var1-default}: value1
${var1:-default}: value1
${var2-default}:
${var2:-default}: default
${var3-default}: default
${var3:-default}: default
## Reference with Set Default
Given:
  var4= (null)
  var5= (undefined)
${var4=default}:
${var4}:
${var5=default}: default
${var5}: default
Given:
  var6= (null)
  var7= (undefined)
${var6:=default}: default
${var6}: default
${var7:=default}: default
${var7}: default
## Alternate Value
Given:
  var8=value8
  var9= (null)
  var10= (undefined)
${var8+alt}: alt
${var8:+alt}: alt
${var9+alt}: alt
${var9:+alt}:
${var10+alt}:
${var10:+alt}:
## Variable length
Given:
  var11=this string is 33 characters long
${#var11}: 33
## Remove Leading Match
Given:
  var12=abc/def/ghi/jkl
${var12#*/}: def/ghi/jkl
${var12##*/}: jkl
## Remove Trailing Match
Given:
  var13=abc/def/ghi/jkl
${var13%/*}: abc/def/ghi
${var13%%/*}: abc
## Variable expansion
Given:
  var14=abcdefghijkl
${var14:3}: defghijkl
${var14:3:3}: def
## Substring replacement
Given:
  var15=abcdefghijklm-abcdefghijklm
${var15/def/...}: abc...ghijklm-abcdefghijklm
${var15//def/...}: abc...ghijklm-abc...ghijklm
${var15/#abc/...}: ...defghijklm-abcdefghijklm
${var15/#klm/...}: abcdefghijklm-abcdefghijklm
${var15/%abc/...}: abcdefghijklm-abcdefghijklm
${var15/%klm/...}: abcdefghijklm-abcdefghij...
```

## Credits and References

* [Advanced Bash-Scripting Guide: Parameter Substitution](https://tldp.org/LDP/abs/html/parameter-substitution.html)
