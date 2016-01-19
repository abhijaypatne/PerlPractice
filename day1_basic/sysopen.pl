#!/usr/bin/perl -w

use Fcntl;

$sPidFile = "./pidfile";

if ( sysopen ( PIDFILE, $sPidFile, O_WRONLY|O_SYNC|O_CREAT|O_TRUNC, 0644 ) ) {
  print "Pidfile $sPidFile opened for writing PID [$$]\n";
  print PIDFILE "$$\n";

  close ( PIDFILE ) ||
  die "Failed to close $sPidFile after write: $!\n";
}
else {
  die "Failed to open $sPidFile for write: $!\n";
}
