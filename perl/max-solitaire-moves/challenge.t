#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'challenge.pl';

use Test::More;

is( maxSolitaireMoves([
  { rank => 7, color => "black" },
  { rank => 6, color => "red" },
  { rank => 5, color => "black" },
  { rank => 9, color => "red" }
]) , 2, 'example 1' );

is( maxSolitaireMoves([
  { rank => 8, color => "black" },
  { rank => 7, color => "red" },
  { rank => 6, color => "red" },
  { rank => 5, color => "black" }
]) , 2, 'example 2' );

done_testing();
