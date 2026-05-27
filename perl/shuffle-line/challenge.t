#!/usr/bin/env perl
#
use strict;
use warnings;

use lib '.';
require 'challenge.pl';

use Test::More;

is_deeply(
    [ shuffleLine(['Ada', 'Ben', 'Cam', 'Diya', 'Eli', 'Fay'], 3) ],
    ['Ada', 'Ben', 'Diya', 'Eli', 'Cam', 'Fay'],
    'example 1'
);

is_deeply(
    [ shuffleLine(['A', 'B', 'C', 'D', 'E'], 2) ],
    ['A', 'C', 'E', 'B', 'D'],
    'example 2'
);


is_deeply(
    [ shuffleLine(['Mo', 'Noah', 'Oli'], 1) ],
    ['Mo', 'Noah', 'Oli'],
    'example 3'
);


is_deeply(
    [ shuffleLine(['Mo', 'Noah', 'Oli'], 0) ],
    ['Mo', 'Noah', 'Oli'],
    'handles n=0 correctly'
);

done_testing();
