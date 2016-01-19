#!/usr/bin/perl -w
#ident "@(#) Simple operations on arrays."

my @lsArr = qw ( one two three );
print "Arr [", join ( ' ', @lsArr ), "]\n";

#
# Assigning an array from a list..
#
my @lsArr1 = ( @lsArr, "four", "five", "six" );
print "Arr1 [", join ( ' ', @lsArr1 ), "]\n";

#
# Adding an element at the end..
#
print "Adding seven at the end..\n";
@lsArr1 = ( @lsArr1, "seven" );
print "Arr1 [", join ( ' ', @lsArr1 ), "]\n";

#
# Pushing it in, instead..
#
print "Pushing eight now..\n";
push ( @lsArr1, "eight" );
print "Arr1 [", join ( ' ', @lsArr1 ), "]\n";

print "Accessing the last index [", $#Arr1, "] Value [", $lsArr1 [$#Arr1], "]\n";

#
# Unshift adds at the beginning..
#
print "Unshifting zero now..\n";
unshift ( @lsArr1, "zero" );
print "Arr1 [", join ( ' ', @lsArr1 ), "]\n";

#
# Pop, takes it off from the end..
#
print "Popping off eight now..\n";
my $iNum = pop @lsArr1;
print "Num [$iNum] Arr1 [", join ( ' ', @lsArr1 ), "]\n";

#
# Shift, from the beginning..
#
print "Shifting off zero now..\n";
$iNum = shift @lsArr1;
print "Num [$iNum] Arr1 [", join ( ' ', @lsArr1 ), "]\n";

#
# Splice to add an element in between..
#
print "Splicing [$iNum] at third postion\n";
splice ( @lsArr1, 3, 0, $iNum );
print "Arr1 [", join ( ' ', @lsArr1 ), "]\n";

#
# Accessing multiple elements of a list..
#
print "Elements 2 - 4 are [", join ( ' ', @lsArr1 [2 .. 4] ), "]\n";

#
# Splicing of [n] elements, destructively..
#

my ( $iVar1, $iVar2 ) = ();

while ( ( $iVar1, $iVar2 ) = splice ( @lsArr1, 0, 2 ) ) {
  print "Var1 [$iVar1] Var2 [$iVar2] Arr1 [", join ( ' ', @lsArr1 ), "]\n";
}


#
# Searching an array within an array..
#
@lsArr = qw ( one two three four five six seven
              eight nine ten );

print "Arr has [", join ( ' ', @lsArr ), "]\n";
print "Using grep to search for one, two and ten\n";

@lsArr1 = grep { /one|two|ten/ } @lsArr;
print "Arr1 has [", join ( ' ', @lsArr1 ), "]\n";
