#open DATA, "ps -ef | grep -i java |"   or die "Couldn't execute program: $!";
open DATA, "hacli -cmd \"ps -ef | grep -i java\" |"   or die "Couldn't execute program: $!";
while ( defined( my $line = <DATA> )  ) {
	chomp($line);
	print "$line\n";
}
close DATA;
