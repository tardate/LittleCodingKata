<?php

$term1 = '240610708';
$term2 = 'QNKCDZO';

$term1_md5 = md5($term1);
$term2_md5 = md5($term2);

echo "$term1 as md5: $term1_md5\n";
echo "$term2 as md5: $term2_md5\n";

$result_eql2 = $term1_md5 == $term2_md5;

if($result_eql2) {
  echo "md5($term1) == md5($term2) : true (!!!)\n";
  echo "  -> This comparison is true because both md5() hashes start '0e' so PHP type juggling understands these strings to be scientific notation.  By definition, zero raised to any power is zero.\n";
}

$result_eql3 = $term1_md5 === $term2_md5;
if(!$result_eql3) {
  echo "md5($term1) === md5($term2) : false\n";
  echo "  -> always use the triple equals === for comparing stirng values to avoid all the quirks and pitfalls.\n";
}

?>
