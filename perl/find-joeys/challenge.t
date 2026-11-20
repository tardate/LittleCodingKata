#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'challenge.pl';

use Test::More;

is( isWithin("blossom", "flower") , 0, 'find flower in blossom' );
is( isWithin("blossom", "bloom") , 1, 'find bloom in blossom' );

is_deeply( [ findJoeys("blossom", ["flower", "bloom"]) ], ["bloom"], 'example 1' );
is_deeply( [ findJoeys("chocolate", ["cocoa", "candy"]) ], ["cocoa"], 'example 2' );
is_deeply( [ findJoeys("cat", ["feline"]) ], [], 'example 3' );

done_testing();
