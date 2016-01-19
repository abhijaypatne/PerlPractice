my @servers = qw ( horizontal_cluster_member5 managed_server3 managed_server4 server3 );
my $sWASHome = "/opt/IBM/WebSphere/AppServer";
my $sRegexWASName = "server3";
my $s;
my @ps, @pid;
my $count = 0;

foreach $sRegexWASName ( @servers ){
#my @op = grep { ( s/\n// || 1) } readpipe ( "hacli -cmd \"ps -ef | grep \"$sWASHome.*java.*com.ibm.ws.runtime.WsServer.*$sRegexWASName\" | grep -v grep\"" );
my @op = readpipe ( "hacli -cmd \"ps -ef | grep  \"$sWASHome.*java.*com.ibm.ws.runtime.WsServer.*$sRegexWASName\" | grep -v grep\"" );
foreach $s (@op){
if( $s =~ /^root/ || $s =~ /^0/ ){
	$count += 1;
}
}
	print "#######\n";
print "$op\n";
}

print "count : $count\n";
=pod
foreach $s (@op){
	print "#######\n";
  @ps = split('\s+', $s);
	push @pid, $ps[1];
	print "$s\n";
#print "#######\n";
}
}
print "pid list: ", join(',', @pid), "\n";
=cut
