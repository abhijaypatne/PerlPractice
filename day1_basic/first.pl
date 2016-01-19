#!/usr/bin/perl

my $animal = "9camel";
my $answer = "2";
my $answer1 = "43";
#print $animal;
#print $answer, "\n";

print $answer*$animal, "\n";
my @array = ("adf", "adfas", "retrew", "dgf");
#print @array;
#print $#array, "\n";
$array[10] = "abhijay";
#print $array[5], "\t", $array[10], "\n";

my %myhash = (
	"abhi" => "comp", 
	"niks" =>  "it",
);
print $myhash{"niks"};
#print %myhash;

print @ARGV, "\n";
print "yes" if ("abhijay" =~ m/^.+$/);
print "yes" if ("catatcatcat" =~ m/^(c|a|t)+$/);

my $myarray = "22656 30190 apache   httpd";
my @split_array = split(" ", $myarray);
print $split_array[0], " ", $split_array[1];
