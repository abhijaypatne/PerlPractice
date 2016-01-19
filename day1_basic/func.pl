#!/usr/bin/perl

sub myfunc
{
	my $val = $_[0];
	print "in myfunc()\n"; //test comment
	$val = 1;
}

my $ret = myfunc(89);
print $ret;
