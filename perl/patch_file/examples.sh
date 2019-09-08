#!/bin/sh

echo "# Installing example.txt from template.."
cp example.txt.template example.txt

echo
echo "# Original file (example.txt): "

cat example.txt


echo
echo "# Example 1: General substitution (no file backup)"
echo "# changes all lines with 'line=*' to 'row=*' "

perl -i -pe '
s/$ARGV[0]/$ARGV[1]/;
if ( eof ) {
  print;
  close ARGV;
  exit;
}
' example.txt line= row=

echo "# .. diff after change:"
diff example.txt example.txt.template


echo
echo "# Example 2: Dependent substitution (with backup)"
echo "# changes the right-hand-side of the line matching 'my_key=' "

perl -i.2.backup -pe '
if (/$ARGV[0]=/) {
  $_="$ARGV[0]=$ARGV[1]\n";
}
if ( eof ) {
  # exit after finishing first file only. Make sure print last line processed
  print;
  close ARGV;
  exit;
}
' example.txt my_key new.service.io

echo "# .. diff after change:"
diff example.txt example.txt.2.backup


echo
echo "# Final example.txt after all these changes:"
cat example.txt
