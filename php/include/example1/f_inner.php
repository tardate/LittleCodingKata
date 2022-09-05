<?php

echo "Included: f_inner.php\n";
echo "f_inner defining : \$color and \$fruit\n";

$color = 'green';
$fruit = 'pear';

include 'f_inner_inner.php';

?>
