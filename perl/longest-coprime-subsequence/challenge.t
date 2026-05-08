#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'challenge.pl';

use Test::Simple 'no_plan';

ok( gcd(4, 3) == 1, 'gcd output should indicate coprime' );
ok( gcd(3, 4) == 1, 'gcd output should indicate coprime' );
ok( gcd(3, 7) == 1, 'gcd output should indicate coprime' );
ok( gcd(7, 3) == 1, 'gcd output should indicate coprime' );
ok( gcd(7, 2) == 1, 'gcd output should indicate coprime' );
ok( gcd(2, 7) == 1, 'gcd output should indicate coprime' );
ok( gcd(12, 18) == 6, 'gcd output should be sane' );
ok( gcd(18, 12) == 6, 'gcd output should be sane' );

ok( longestCoprimeSubsequence(6, 12, 4, 8) == 1, 'no coprime numbers' );
ok( longestCoprimeSubsequence(4, 3, 7, 2) == 4, 'should find sequence of 4 coprime numbers (4, 3, 7, 2)' );
ok( longestCoprimeSubsequence(4, 3, 7, 2, 6, 9) == 4, 'should find sequence of 4 coprime numbers (4, 3, 7, 2)' );
ok( longestCoprimeSubsequence(4, 3, 6, 9, 7, 2) == 3, 'should find sequence of 3 coprime numbers (9, 7, 2)' );
