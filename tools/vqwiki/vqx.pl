#!/usr/bin/perl

use strict;
use warnings;
use DBI;

my $dbh = DBI->connect("dbi:mysql:dbname=vqwiki;host=localhost;port=3306", 'root', '');

my $sql = "select name,contents from topic";
my $sth = $dbh->prepare($sql);
my @row;
$sth->execute
or die "SQL Error: $DBI::errstr\n";

while (@row = $sth->fetchrow_array) {
  my $export_file = 'export/' . $row[0] . '.md';
  print "$export_file\n";
  open my $export, '>', $export_file or die("Cannot open database config file $export_file: $!\n");
  print $export "# $row[0]\n\n";
  print $export $row[1];
  close $export;
}
