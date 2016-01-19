#!/usr/bin/perl -w
#ident "@(#) Try out different constructs."

use strict;
use Switch;

sub usage {
  die "usage: $0 <colour>\n";
}

&usage () unless scalar @ARGV;
my $sColour = shift;

print "Using if-elsif-else..\n";
if ( $sColour eq 'red' ) {
  print "Colour is red!\n";
}
elsif ( $sColour eq 'blue' ) {
  print "Colour is blue!\n";
}
else {
  print "Unknown colur [$sColour]..\n";
}

#-----------------------------
# Implement a C-style switch..
#-----------------------------
print "Implementing a C-style switch with goto..\n";

my $sSwitch = $sColour =~ /^(red|blue)$/ ? $sColour : 'default';

goto $sSwitch; {
  red:
    print "Colour is red!\n";
  last;

  blue:
    print "Colour is blue!\n";
  last;

  default:
    print "Unknown colur [$sColour]..\n";
  last;
}

#---------------
# Using a hash..
#---------------
my %hsColours = ( 'red' => 1, 'blue' => 2 );

print "Using a hash..\n";

if ( $hsColours { $sColour } ) {
  print "Colour is $sColour!\n";
}
else {
  print "Unknown colur [$sColour]..\n";
}

#----------------------
# Use Perl 5.8 switch..
#----------------------
require 5.008;
print "Using Perl 5.8 switch construct..\n";

switch ( $sColour ) {
  case 'red' {
    print "Colour is $sColour!\n";
  }

  case 'blue' {
    print "Colour is $sColour!\n";
  }

  case 'default' {
    print "Unknown colur [$sColour]..\n";
  }
}
