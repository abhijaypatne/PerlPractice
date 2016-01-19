#!/usr/bin/perl -w
#ident "@(#) Basic file manipulation."

use strict;

sub usage {
  die "usage: $0 <file>\n";
}

&usage () unless scalar @ARGV;

my ( $sFile, $sLine, @lsData ) = ();
$sFile = shift;

&usage () unless -f $sFile;

#---------------------
# Open file for read..
#---------------------
open ( FILDES, $sFile ) ||
die "Failed to open $sFile for read: $!\n";

#--------------
# Using while..
#--------------
while ( $sLine = <FILDES> ) {
  chomp $sLine;
  print "$sLine\n";
}

=pod
#--------------------
# Using for/foreach..
#--------------------
foreach $sLine ( <FILDES> ) {
  chomp $sLine;
  print "$sLine\n";
}
=cut

=pod
#-------------
# Slurp mode..
#-------------
@lsData = <FILDES>;
foreach $sLine ( @lsData ) {
  chomp $sLine;
  print "$sLine\n";
}
=cut

=pod
#-----------------------------------
# Accessing a file handle directly..
#-----------------------------------
print <FILDES>;
=cut

close ( FILDES ) ||
die "Failed to close $sFile after read: $!\n";
