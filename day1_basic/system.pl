#!/usr/bin/perl -w
#ident "@(#) Demonstrate using system call in Perl."

use strict;

my $sCmd = "/bin/ls";
my @lsCmdArgs = qw ( -ltac /etc/passwd /etc/inet/hosts );
my $iExitCode = undef;

system ( $sCmd, @lsCmdArgs ); # Uses a fork/exec call..
$iExitCode = $? >> 8; # Get MSB..

die "System call for cmd [$sCmd] failed: $!\n" if $iExitCode;
