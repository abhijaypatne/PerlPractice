#!/usr/bin/perl -w
#ident "@(#) Demonstrate scoped declarations."

use strict;

our $iCnt = 10; # Defines a global number..
                # Cannot be 'my'..
print "Cnt [$iCnt] before first scope..\n";

{
  my $iCnt = 4;
  our $iCnt = 12; # Assigns the global with 12..
#  local $test= 44;
  print "Cnt [$iCnt] inside first scope.. test is\n"; # Refer to the global one..
}
print "Cnt [$iCnt] after first scope..\n";

print "Cnt [$iCnt] before second scope..\n";

{
  local $iCnt = 10; # Hide the global for this scope..
  print "Cnt [$iCnt] inside second scope..\n";
}
print "Cnt [$iCnt] after second scope..\n";

print "Cnt [$iCnt] before third scope..\n";

{
  my $iCnt = 18; # Re-define another variable with same name..
  print "Cnt [$iCnt] inside third scope..\n";
}
print "Cnt [$iCnt] after third scope..\n";
