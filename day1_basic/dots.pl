#!/usr/bin/perl -w
#ident "@(#) Use the '..' and '...' operator."

use strict;

open ( DATA, "./data" ) ||
die "Failed to open ./data for read: $!\n";

print "Using .. operator:\n";
while (<DATA>) {
  print if /one/ .. /ten/; # Should print just one line..
}


print "Using ... operator:\n";

seek ( DATA, 0, 0 ); # Rewind..

while (<DATA>) {
  print if /one/ ... /ten/; # Should print just all lines..
}

close ( DATA ) ||
die "Failed to close ./data after read: $!\n";
