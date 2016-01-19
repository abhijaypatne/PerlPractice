#!/usr/bin/perl
  2
  3 my $animal = "camel";
  4 my $answer = 42;
  5 #print $animal;
  6 #print $answer, "\n";
  7
  8 my @array = ("adf", "adfas", "retrew", "dgf");
  9 #print @array;
 10 #print $#array, "\n";
 11
 12 $array[10] = "abhijay";
 13 #print $array[5], "\t", $array[10], "\n";
 14
 15 my %myhash = (
 16         "abhi" => "comp",
 17         "niks" =>  "it",
 18 );
 19 print $myhash{"niks"};
 20 #print %myhash;
 21
 22 print @ARGV, "\n";
 23
 24 print "yes" if ("abhijay" =~ m/^.+$/);
 25 print "yes" if ("catatcatcat" =~ m/^(c|a|t)+$/);
~
~
~
