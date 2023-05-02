#!/bin/bash

var1="value1"
var2=


echo "## Explicit Reference"

echo "Given:"
echo "  var1=${var1}"
echo "\${var1}: ${var1}"

echo "## Reference with Default"

echo "Given:"
echo "  var2=${var2} (null)"
echo "  var3=${var3} (undefined)"

echo "\${var1-default}: ${var1-default}"
echo "\${var1:-default}: ${var1:-default}"
echo "\${var2-default}: ${var2-default}"
echo "\${var2:-default}: ${var2:-default}"
echo "\${var3-default}: ${var3-default}"
echo "\${var3:-default}: ${var3:-default}"

echo "## Reference with Set Default"
var4=
echo "Given:"
echo "  var4=${var4} (null)"
echo "  var5=${var5} (undefined)"

echo "\${var4=default}: ${var4=default}"
echo "\${var4}: ${var4}"
echo "\${var5=default}: ${var5=default}"
echo "\${var5}: ${var5}"

var6=
echo "Given:"
echo "  var6=${var6} (null)"
echo "  var7=${var7} (undefined)"

echo "\${var6:=default}: ${var6:=default}"
echo "\${var6}: ${var6}"
echo "\${var7:=default}: ${var7:=default}"
echo "\${var7}: ${var7}"

echo "## Alternate Value"

var8=value8
var9=
echo "Given:"
echo "  var8=${var8}"
echo "  var9=${var9} (null)"
echo "  var10=${var10} (undefined)"

echo "\${var8+alt}: ${var8+alt}"
echo "\${var8:+alt}: ${var8:+alt}"
echo "\${var9+alt}: ${var9+alt}"
echo "\${var9:+alt}: ${var9:+alt}"
echo "\${var10+alt}: ${var10+alt}"
echo "\${var10:+alt}: ${var10:+alt}"

echo "## Variable length"

var11="this string is 33 characters long"
echo "Given:"
echo "  var11=${var11}"

echo "\${#var11}: ${#var11}"

echo "## Remove Leading Match"

var12="abc/def/ghi/jkl"
echo "Given:"
echo "  var12=${var12}"

echo "\${var12#*/}: ${var12#*/}"
echo "\${var12##*/}: ${var12##*/}"

echo "## Remove Trailing Match"

var13="abc/def/ghi/jkl"
echo "Given:"
echo "  var13=${var13}"

echo "\${var13%/*}: ${var13%/*}"
echo "\${var13%%/*}: ${var13%%/*}"

echo "## Variable expansion"

var14="abcdefghijkl"
echo "Given:"
echo "  var14=${var14}"

echo "\${var14:3}: ${var14:3}"
echo "\${var14:3:3}: ${var14:3:3}"

echo "## Substring replacement"

var15="abcdefghijklm-abcdefghijklm"
echo "Given:"
echo "  var15=${var15}"

echo "\${var15/def/...}: ${var15/def/...}"
echo "\${var15//def/...}: ${var15//def/...}"
echo "\${var15/#abc/...}: ${var15/#abc/...}"
echo "\${var15/#klm/...}: ${var15/#klm/...}"
echo "\${var15/%abc/...}: ${var15/%abc/...}"
echo "\${var15/%klm/...}: ${var15/%klm/...}"
