#!/usr/bin/env perl
#
package Demo;
use Carp;
use Carp qw(cluck longmess shortmess);

sub readFile {
	my $filename = shift(@_);
	open(FILE, $filename) or croak("Cannot locate file!");
	print <FILE>;
	close FILE;
}

sub demoCarp {
  carp "This is a warning message. (carp: warning message from perspective of caller)";
  print shortmess("shortmess:");
  print longmess("longmess:");
}

sub demoCluck {
  cluck "This is a warning message with stack trace. (cluck: like carp but with stack trace)";
  print shortmess("shortmess:");
  print longmess("longmess:");
}

sub demoCroak {
  croak "This is an error message. (croak: error message from perspective of caller)";
}

sub demoConfess {
  confess "This is an error message. (confess: like croak but with stack trace)";
}

sub demoCarpModule {
  my $method = shift(@_);

  print "\n## Demonstrating: $method\n";

  if ($method eq 'carp') {
    demoCarp();
  } elsif ($method eq 'croak') {
    demoCroak();
  } elsif ($method eq 'cluck') {
    demoCluck();
  } elsif ($method eq 'confess') {
    demoConfess();
  } elsif ($method eq 'read-file-ok') {
    readFile('data.txt');
  } elsif ($method eq 'read-file-bad') {
    readFile('data.txt.missing');
  } elsif ($method eq 'settings') {
    print "Carp settings:\n";
    print "  Carp::MaxEvalLen: ", $Carp::MaxEvalLen, "\n";
    print "  Carp::MaxArgLen: ", $Carp::MaxArgLen, "\n";
    print "  Carp::MaxArgNums: ", $Carp::MaxArgNums, "\n";
    print "  Carp::Verbose: ", $Carp::Verbose, "\n";
  } else {
    print "Unknown argument. Use 'carp', 'croak', 'confess', 'cluck', 'read-file-ok', 'read-file-bad', or 'settings'.\n";
  }
}

package main;
my $arg = shift(@ARGV) // 'carp';
Demo::demoCarpModule($arg);

1;
