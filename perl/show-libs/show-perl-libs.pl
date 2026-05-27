#!/usr/bin/env perl
# Show the Perl library paths and installed modules
# Usage: show-perl-libs.pl [-v]
use ExtUtils::Installed;

my $verbose = grep { $_ eq '-v' } @ARGV;

print "PERL5LIB: ", $ENV{'PERL5LIB'};

print "\n\nLIBRARY PATH:\n";
printf "%d %s\n", $i++, $_ for @INC;

print "\nINSTALLED MODULES\n";

# find all the installed modules
my $installed = ExtUtils::Installed->new();

# list modules
foreach my $module ($installed->modules()) {
  my $version = $installed->version($module) || "???";
  print("Found module $module Version $version\n");
  if (!$verbose) {
    next;
  }
  print("  Files:\n");
  foreach my $file ($installed->files($module)) {
    print("    - $file\n");
  }
  print("  Directories:\n");
  foreach my $dir ($installed->directories($module)) {
    print("    - $dir\n");
  }
}
