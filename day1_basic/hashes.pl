#!/usr/bin/perl -w
#ident "@(#) Working with hashes"

use strict;

my ( $sKey, $sVal, @lsList ) = ();
my %hsHash = ( 'one'   =>   1,  'two'   => 2, 'three' => 3,
               'four'  =>   4,  'five'  => 5  , 'six' => 6,
               'seven' =>   7,  'eight' => 8, 'nine'  => 9,
               'ten'   =>   10 );

#--------------------------
# Printing keys of a hash..
#--------------------------
print "Printing keys in the raw.. ------\n";
foreach $sKey ( keys %hsHash ) {
  print "Key [$sKey] Holds [", $hsHash { $sKey }, "]\n";
}

#--------------------------------
# Printing keys in a sane order..
#--------------------------------
print "Printing keys sorted alphabetically.. ------\n";
foreach $sKey ( sort keys %hsHash ) {
  print "Key [$sKey] Holds [", $hsHash { $sKey }, "]\n";
}

#----------------------------
# Printing values in a hash..
#----------------------------
print "Printing values on the raw.. ----------\n";
foreach $sVal ( sort values %hsHash ) {
  print "Value [$sVal]\n";
}

#----------------------------------
# Printing values in a sane order..
#----------------------------------
print "Printing values sorted numerically.. ----------\n";
foreach $sVal ( sort { $a <=> $b } values %hsHash ) {
  print "Value [$sVal]\n";
}

#-----------------------------
# Assigning a hash to a list..
#-----------------------------
print "Assigning hash to a list.. ----------\n";
@lsList = %hsHash;
foreach $sVal ( @lsList ) {
  print "Value [$sVal]\n";
}

#-----------------
# Taking a slice..
#-----------------
print "Taking a slice of one five and six..\n";

@lsList = @hsHash { qw ( one five six ) };
foreach $sVal ( @lsList ) {
  print "Value [$sVal]\n";
}


#-------------------------------------------
# Creating an anonymous array using a hash..
#-------------------------------------------
print "Taking a slice of one five and six by reference..\n";
my $rhsHash = \%hsHash;

@lsList = @${rhsHash} { qw ( one five six ) }; # Same as @$rhsHash { qw ( one five six ) }

foreach $sVal ( @lsList ) {
  print "Value [$sVal]\n";
}

#---------------------------
# Finding unique in a list..
#---------------------------
@lsList = qw ( one one two three three three four five seven
          seven seven eight eigth eight nine ten ten ten ten );
my ( @lsUniq, %hsUniq ) = ();

print "Creating unique from [", join ( ' ', @lsList ), "]\n";

#-------------
# Using grep..
#-------------
@lsUniq = grep { ! $hsUniq { $_ } ++ } @lsList;
print "Uniques are [", join ( ' ', @lsUniq ), "]\n";

#----------------
# Counting each..
#----------------
print "Uniques from hash are: \n";
foreach $sKey ( keys %hsUniq ) {
  print "Value [$sKey] Count [", $hsUniq { $sKey }, "]\n";
}

#--------------------
# The each function..
#--------------------
print "Accessing the hash with the *each* function..\n";
while ( ( $sKey, $sVal ) = each %hsUniq ) {
  print "Key [$sKey] Value [$sVal]\n";
}

#----------------------
# The delete function..
#----------------------
print "Deleting keys 'three', 'five' and 'seven'\n";
delete $hsUniq { three };
delete $hsUniq { five };
delete $hsUniq { seven };

foreach $sKey ( keys %hsUniq ) {
  print "Value [$sKey] Count [", $hsUniq { $sKey }, "]\n";
}

#-----------------
# Merging hashes..
#-----------------
print "hsHash has..\n";
foreach $sKey ( keys %hsHash ) {
  print "Value [$sKey] Count [", $hsHash { $sKey }, "]\n";
}

print "Doing a slow merge of Hash and Uniq..\n";
%hsHash = ( %hsHash, %hsUniq );
foreach $sKey ( keys %hsHash ) {
  print "Value [$sKey] Count [", $hsHash { $sKey }, "]\n";
}

print "A better way for a merger using a hash slice..\n";
@hsHash { keys %hsUniq } = values %hsUniq;

foreach $sKey ( keys %hsHash ) {
  print "Value [$sKey] Count [", $hsHash { $sKey }, "]\n";
}

#-----------------------------------
# Storing multiple values at a key..
#-----------------------------------
my ( %hsId ) = ();
print "Storing 'Setu', 'Gupta', 'Symantec' at a single location..\n";

push @{ $hsId { one } }, qw ( Setu Gupta Symantec );
print "Now 'one' has [", join ( ' ', @{ $hsId { one } } ), "]\n";
