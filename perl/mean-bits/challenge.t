#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'challenge.pl';

use Test::More;

is( meanBits(6) , '2.00', 'given example (naive algorithm)' );
is( meanBits(0) , '1.00', 'handle 0 (naive algorithm)' );
is( meanBits(-5) , '0.00', 'handle negatives (naive algorithm)' );
is( meanBits(10000000) , '22.32', 'handle big numbers (naive algorithm)' );

is( meanBits_fast(6) , '2.00', 'given example (fast algorithm)' );
is( meanBits_fast(0) , '1.00', 'handle 0 (fast algorithm)' );
is( meanBits_fast(-5) , '0.00', 'handle negatives (fast algorithm)' );
is( meanBits_fast(10000000) , '22.32', 'handle big numbers (fast algorithm)' );

done_testing();
