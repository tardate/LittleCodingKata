#!/usr/bin/env perl
#
use Carp qw(carp cluck);

sub c {
    carp "carp";
    cluck "cluck";
}
sub a { b() }
sub b { c() }

a();
