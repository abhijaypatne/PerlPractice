#!/usr/bin/perl -w
#ident "@(#) Try out different regex."

use strict;

#------------------------------------
# Replacement of the split function..
#------------------------------------
my $sStr = "String|Delimited|by|pipes";
my @lsFlds = $sStr =~ /[^|]+/g; # Same as split ( '|', $sStr );
print "Str [$sStr] Array [", join ( ' ', @lsFlds ), "]\n";

$sStr = "String         Delimited by       spaces";
@lsFlds = $sStr =~ /[\S]+/g; # Same as split ( /\s+/, $sStr );
print "Str [$sStr] Array [", join ( ' ', @lsFlds ), "]\n";

$sStr = "String,        Delimited,by       , spaces,or,commas ";
@lsFlds = $sStr =~ /([^(,|\s)]+)/g; # Same as split ( /([^(,|\s)]+)/, $sStr );
print "Str [$sStr] Array [", join ( ' ', @lsFlds ), "]\n";

$sStr = "One Two Three";
$sStr =~ /(\w+)\s(\w+)\s(\w+)/g;
print "First [$1] Second [$2] Third [$3] Matched [$#+]\n";

$sStr = "Alphabets   123  - 23:10  XXX";

#-------------------------------------
# Extending legibility of your regex..
#-------------------------------------
if ( $sStr =~ m/^\w+\s+\d+\s+-\s+(\d+:\d+).*/ ) {
  print "Time [$1]\n";
}

if ( $sStr =~ m/^\w+      # Starting with a word..
                \s+       # Followed by one or more space..
                \d+       # Followed by one or more digit..
                \s+       # Followed by one or more space..
                -         # Followed by a hyphen..
                \s+       # Followed by one or more space..
                (\d+:\d+) # Mark the colon separated time..
               .*         # Followed by anything..
               /x ) {
  print "Time with extended regex [$1]\n";
}

#--------------
# Another way..
#--------------
if ( $sStr =~ m{(?x)^\w+      # Starting with a word..
                    \s+       # Followed by one or more space..
                    \d+       # Followed by one or more digit..
                    \s+       # Followed by one or more space..
                    -         # Followed by a hyphen..
                    \s+       # Followed by one or more space..
                    (\d+:\d+) # Mark the colon separated time..
                   .*         # Followed by anything..
              } ) {
  print "Time with extended free-form regex [$1]\n";
}
