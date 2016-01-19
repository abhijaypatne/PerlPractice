#!/usr/bin/perl -w
#ident "@(#) Try to show how printf works."

use strict;

my $a = 10;


#
# Prints : Inc-Ten [11], Inc-Eleven [12] Inc-Twelve [13]
#
printf ( "Inc-Ten [%d], Inc-Eleven [%d] Inc-Twelve [%d]\n",
&inc ( $a ), &inc ( $a ), &inc ( $a ) );

$a = 10; # Re-initialise..

#
# Prints: Ten [12], Inc-Eleven [11] Inc-Twelve [12]
#
printf ( "Ten [%d], Inc-Eleven [%d] Inc-Twelve [%d]\n",
$a, &inc ( $a ), &inc ( $a ) );

$a = 10; # Re-initialise..

#
# Prints: Ten [10], Inc-Eleven [11] Inc-Twelve [12]
#
printf ( "Ten [%d], Inc-Eleven [%d] Inc-Twelve [%d]\n",
&same ( $a ), &inc ( $a ), &inc ( $a ) );

=pod

So based on this:

1. printf gets evaluated left to right.
2. It first gives preference to operations on its arguments, than arguments.

=cut

sub inc {
  print "Got i [$a] to increment\n";
  ++ $a;
  return $a;
}

sub same {
  return @_;
}
