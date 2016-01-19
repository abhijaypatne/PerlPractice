my @output = readpipe("/mnt/was/Dmgr04-shared/bin/wsadmin.sh -lang jython -conntype SOAP -host 10.209.78.78 -port 8899 -c \"node = AdminConfig.getid('/Node:Dmgr04-shared-node/'); AdminConfig.showAttribute(node, 'hostName');\"");
print "before", join(',', @output);
shift @output;
print "after", join(',', @output);
my $returncode = readpipe("echo $?");
if ($returncode == 0){
print "before", join(',', @output);
shift @output;
print "after", join(',', @output);
}
else{
	print "some error occured", $returncode;
}
