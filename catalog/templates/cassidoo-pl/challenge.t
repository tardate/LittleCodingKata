#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'challenge.pl';

use Test::More;

is( challengeFunction("param1") , 1, 'example 1' );

done_testing();
