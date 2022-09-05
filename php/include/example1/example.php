<?php

echo "Running: example.php\n";

echo "CALLED: A \$adjective \$color \$fruit\n"; // A
echo "RESULT: A $adjective $color $fruit\n"; // A

echo "DEFAULT_FRUIT: " . DEFAULT_FRUIT . "\n";

echo "Now including f_inner.php\n";

include 'f_inner.php';

echo "CALLED: A \$adjective \$color \$fruit\n"; // A
echo "RESULT: A $adjective $color $fruit\n"; // A juicy green pear

echo "DEFAULT_FRUIT: " . DEFAULT_FRUIT . "\n";

?>
