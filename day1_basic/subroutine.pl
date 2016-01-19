#!/usr/bin/perl -w
#ident "@(#) Demonstrating subroutines in Perl."

use strict;

#sub PI { 3.1415926536 }
use constant PI => 3.1415926536; # Same as above..

printf ( "Value of PI [%.10f]\n", PI );

print &sub1 ( qw ( one two three four five ) );
sub2 ( 12, 1 .. 10 );
sub2 ( 1 .. 10 ); # See what happens!
sub3 ( 1 .. 10 ); # See what happens now!
sub4 ( [ ( 1 .. 10 ) ], [ ( 20 .. 30 ) ] ); # Okay..

#--------------------------
# Are pass by values safe??
#--------------------------
my ( $iNum, $sSub, @liList, @liRetList ) = ();
@liList = ( 30 .. 40 );
print "Sending List [", join ( ' ', @liList ), "] by value..\n";
@liRetList = &sub5 ( @liList ); # By value..
print "Return list [", join ( ' ', @liRetList ), "]\n";
print "Original list [", join ( ' ', @liList ), "]!\n";

#----------------------
# Calling, if defined..
#----------------------
print "Calling a sub-routine, if defined..\n";

my %hrSubs = ( 'sub6' => \&sub6,
               'sub7' => \&sub7,
               'sub8' => \&sub8,
               'sub9' => \&sub9,
               'sub10' => \&sub10
             );

my %hrData = ( 'sub6' => [ qw ( one two three four five ) ],
               'sub8' => [ ( 1 .. 10 ) ],
               'sub10' => \@liList
             );

my $iRef = 12;
my @liData1 = ( 1 .. 10 );
my @liData2 = ( 11 .. 20 );

@{ $hrData { sub7 } } = ( \$iRef, \@liData2 );   # Take references this way..
@{ $hrData { sub9 } } = \( @liData1, @liData2 ); # Or this is fine too..

#-----------------------------------------------
# Call each sub-routine, with args, if defined..
#-----------------------------------------------
foreach $sSub ( qw ( sub6 sub7 sub8 sub9 sub10 sub11 ) ) {
  if ( $hrSubs { $sSub } ) {
    print "Calling sub-routine [$sSub]..\n";
    $hrSubs { $sSub }->( $hrData { $sSub } );
  }
  else {
    warn "Sub-routine [$sSub] has not been defined!\n";
  }
}

print "\nCalled sub-routine sub1 within a print!\n@{[sub1 ('Hello World')]}\n";

sub sub1 {
  my ( @list ) = @_; # All arguments passed as list..

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Passed [", join ( ' ', @list ), "]\n";
  2; # Should return 2..
}

sub sub2 {
  my ( $iNum, @liList ) = @_;

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got Num [$iNum] List [", @liList, "]\n";
  return 1;
}

sub sub3 {
  my ( @liList, $iNum ) = @_; # Oops!

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got Num [$iNum] List [", @liList, "]\n";
  return 1;
}

sub sub4 {
  my ( $rliList1, $rliList2 ) = @_;

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got List1 [", join ( ' ', @$rliList1 ),
  "] List2 [", join ( ' ', @$rliList2 ), "]\n";

  return 1;
}

sub sub5 {

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

 foreach ( @_ ) {
   ++ $_;
 }

 return @_; # Heh.. heh..
}

sub sub6 {
  my ( $rlist ) = @_; # By reference..

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Passed [", join ( ' ', @$rlist ), "]\n";
  2; # Should return 2..
}

sub sub7 {
  my ( $rhlComp ) = @_;
  my ( $riNum, $rliList ) = @$rhlComp;

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got Num [$$riNum] List [", @$rliList, "]\n";
  return 1;
}

sub sub8 {
  my ( $rliList ) = @_; # Oops!

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

  print "Got List [", @$rliList, "]\n";
  return 1;
}

sub sub9 {
  my ( $rhlComp ) = @_;
  my ( $rliList1, $rliList2 ) = @$rhlComp;

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called with [$rliList1][$rliList2]..\n";

  print "Got List1 [", join ( ' ', @$rliList1 ),
  "] List2 [", join ( ' ', @$rliList2 ), "]\n";

  return 1;
}

sub sub10 {

  my $sName = ( caller 0 )[3];
  print "Subroutine [$sName] called..\n";

 ++ $_ for @_;
 return @_; # Heh.. heh..
}
