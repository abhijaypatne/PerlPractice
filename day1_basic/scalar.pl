#!/usr/bin/perl -w
#ident "@(#) Scalar example 1"

use strict;

#
# Initialising new variables..
#
my $sString; # Undef, by default..
my $iDigit = undef; # Initialise with undefs;

$sString = "Setu Gupta";
$iDigit = 21;
print "String [$sString] Digit [$iDigit]\n";

#
# Assigning values as a list..
#
my ( $sVar1, $sVar2 ) = (undef,2); # Also undefs..
my ( $sVar3, $sVar4 ) = ('X') x 2; # Initialised to 'X'..
print "var3 [$sVar3] var4 [$sVar4]\n";

#
# Assigning values if un-assigned..
#
$sVar1 ||= ( $sVar2 ||= 1 ) ++ ;
print "var1 [$sVar1] var2 [$sVar2]. Assigned!\n";

#
# Swapping..
#
print "Swapping values of var1 [$sVar1] and var2 [$sVar2] ..\n";
( $sVar1, $sVar2 ) = ( $sVar2, $sVar1 );
print "New values of var1 [$sVar1] and var2 [$sVar2] ..\n";
