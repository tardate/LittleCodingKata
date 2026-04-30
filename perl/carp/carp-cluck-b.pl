#!/usr/bin/env perl
#
package My::Layer;
use Carp qw(carp cluck);
sub c {
    carp "carp";
    cluck "cluck";
}

package main;
sub a { b() }
sub b { My::Layer::c() }

a();
