#!/usr/bin/env perl
#
use strict;
use warnings;
use JSON;

sub maxSolitaireMoves {
  my ($cards) = @_;
  my $moves = 0;

  for (my $i = 0; $i < $#$cards; $i++) {
    if (($cards->[$i]{rank} == $cards->[$i + 1]{rank} + 1) && ($cards->[$i]{color} ne $cards->[$i + 1]{color})) {
      $moves++;
    }
  }
  return $moves;
}

sub readJsonFile {
  my ($filename) = @_;
  open my $fh, '<:raw', $filename or die "Could not open file '$filename' $!";
  my $json_text = do { local $/; <$fh> };
  close $fh;
  return decode_json($json_text);
}

if (!caller()) {
  if (@ARGV != 1) {
    print STDERR "Usage: perl challenge.pl <cards-json-file-name>\n";
    exit 1;
  }
  my $filename = $ARGV[0];
  my $cards = readJsonFile($filename);

  print "# given cards=[" . join(', ', map { "$_->{rank}:$_->{color}" } @$cards) . "], result is:\n";

  my $result = maxSolitaireMoves($cards);
  print "$result\n";
}

1;
