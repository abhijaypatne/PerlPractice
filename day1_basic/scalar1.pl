#!/usr/bin/perl -w
#ident "@(#) Scalar example 2"

use strict;

#
# Initialising new variables..
#
my ( $sString, $iDigit ) = (); # Initialise with undefs;

$sString = "Setu Gupta";
$iDigit = 21;

print "String [$sString] Digit [$iDigit]\n";

#
# Assigning values as a list..
#
( $sString, $iDigit ) = ( "New string $sString", ++ $iDigit );
print "New String [$sString] Digit [$iDigit]\n";
