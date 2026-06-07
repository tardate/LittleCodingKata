#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'challenge.pl';

use Test::More;

is( packSuitcases([4, 8, 1, 4, 2], [10, 6, 8]) , 3, 'example 1' );
is( packSuitcases([9, 7, 6], [10, 6]) , -1, 'example 2' );

done_testing();
