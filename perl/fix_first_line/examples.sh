#!/bin/sh

echo "Installing example.hex from template.."
cp example.hex.template example.hex

echo
echo "Original example.hex (head only).."
head example.hex


echo
echo "Step 1: Patching the first line (with file backup)"
perl -i.backup -pe '
if ($. == 1) {
  if (!(/^:02.{4}04/)) {
    print ":020000040000FA\n";
  }
}
if ( eof ) {
  print;
  close ARGV;
  exit;
}
' example.hex

echo
echo "Cummulative diffs.."
diff example.hex example.hex.backup

echo
echo "Step 2: Try patching again - should not duplicate (without backup)"
perl -i -pe '
if ($. == 1) {
  if (!(/^:02.{4}04/)) {
    print ":020000040000FA\n";
  }
}
if ( eof ) {
  print;
  close ARGV;
  exit;
}
' example.hex

echo
echo "Cummulative diffs.."
diff example.hex example.hex.backup


echo
echo "Resulting example.hex (head only).."
head example.hex
