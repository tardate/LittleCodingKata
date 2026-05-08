#!/usr/bin/env perl
#
use strict;
use warnings;

sub hello_world {
  return "Hello, World!";
}

print hello_world(), "\n" if !caller();

1;
