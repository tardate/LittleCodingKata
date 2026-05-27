#!/usr/bin/env perl
#
use strict;
use warnings;

use lib ".";
require 'hello.pl';

use Test::More tests => 1;

is(hello_world(), 'Hello, World!', 'hello_world output should be sane');
