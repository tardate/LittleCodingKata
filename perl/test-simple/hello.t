#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'hello.pl';

use Test::Simple tests => 1;

ok( hello_world() eq "Hello, World!", 'hello_world output should be sane');
