#!/usr/bin/env perl
#
use strict;
use warnings;

sub isWithin {
  my ($word, $synonym) = @_;
  eval "\$word =~ tr/\Q$synonym\E//cd";
  die $@ if $@;
  return $word eq $synonym ? 1 : 0;
}

sub findJoeys {
  my ($word, $synonyms) = @_;
  my @results = ();
  foreach my $synonym (@$synonyms) {
    if (isWithin($word, $synonym)) {
      push @results, $synonym;
    }
  }
  return @results;
}

if (!caller()) {
  if (@ARGV != 2) {
    print STDERR "Usage: perl challenge.pl <word> <csv-synonyms>\n";
    exit 1;
  }
  my $word = $ARGV[0];
  my @synonyms = map { s/^\s+|\s+$//g; $_ } split(',', $ARGV[1]);

  print STDERR "# given word=$word, synonyms=[" . join(', ', @synonyms) . "], result is:\n";

  my @result = findJoeys($word, \@synonyms);
  print "[" . join(', ', @result) . "]\n";
}

1;
