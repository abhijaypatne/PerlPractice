#!/usr/bin/perl -w
#ident "@(#) Creating defuncts and waiting."

use strict;

my ( $iCnt, $iPid, $iExitCode, @liPids ) = ();
my $iSleepChld = 5;
my $iSleepPar = 60;

++ $|; # Set auto-flush;

#------------------------
# Fork off ten children..
#------------------------
for ( $iCnt = 1; $iCnt <= 10; ++ $iCnt ) {
  if ( ( $iPid = fork () ) > 0 ) { # Parent..
    print "Parent here: [$$] Forking child no. [$iCnt]\n";
    push ( @liPids, $iPid ); # Store..
  }
  elsif ( 0 == $iPid ) { # Child..
    print "Child no. [$iCnt] here.. Sleeping for [$iSleepChld] sec.\n";
    sleep $iSleepChld;
    exit $iCnt; # Exit child no..
  }
  else { # Oops!
    die "Fork error for child no. [$iCnt]! [$!]\n";
  }
}

#------------------------
# Now the parent sleeps..
#------------------------
print "Parent sleeping for [$iSleepPar] secs..\n";
sleep $iSleepPar;

#-----------
# Now reap..
#-----------
foreach $iPid ( @liPids ) {
  print "Waiting for child PID [$iPid]\n";

  if ( -1 == waitpid ( $iPid, 0 ) ) {
    warn "Wait error for PID [$iPid]\n"
  }
  else {
    $iExitCode = $? >> 8; # Get upper nibble.. 
    print "Child PID [$iPid] Exit Code [$iExitCode]\n";
  }
} 

exit 0;
