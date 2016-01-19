my @sServerNames = qw( horizontal_cluster_member5 managed_server4 managed_server3 server3);

my ( @liPids, $ret, $sClusterName, $sWASHome, $sServerProfile, $sServerList, $sCmd, $sCmdArgs, $sActionArgs, $iExitCode,                                          $iRunningMemberCount, $sWASNode, $sMyName, $sServer, @lsFieldNames, $sFilter1, $sFilter2, $sOp, @lsMatchedProcs ) = ();
$iRunningMemberCount = 0;

my @lsOutput = readpipe( "ps -ef | grep -i java" );
if ( $iExitCode = $? >> 8 ){
	  print "Command [$sCommandPs $sCommandPsArgs | $sCommandGrep $sCommandGrepArgs] failed with exit code [$iExitCode]";
}

$sWASHome = "/opt/IBM/WebSphere/AppServer"; 
foreach $sServer (@sServerNames){
	    #--------------------------------------
##  # Form the filter to match WAS process
##    #--------------------------------------
#	my $sRegexWASName = WebSphere::GetServerNameRegex($sServer);
  $iNumberOfMatches = 0;
	@lsMatchedProcs = ();
	my $sRegexWASName = ($sServer);
	$sRegexWASName =~ s/\s+/\\s+/g;
	$sFilter1 = $sWASHome."/.*/bin/.*java.*"."com.ibm.ws.runtime.WsServer".".*"."\\s+".$sRegexWASName."\\s*\$";
	$sFilter2 = $sWASHome."/.*/bin/.*java.*-Dwas.launcher.server=\\w:$sRegexWASName";
	foreach $sOp ( @lsOutput ){
		if ( $sOp =~ /$sFilter1/ || $sOp =~ /$sFilter2/ ){
			@lsMatchedProcs = split( '\s+', $sOp );
			push @liPids, $lsMatchedProcs[1];
			$iNumberOfMatches += 1;
		}
	}
		if ( $iNumberOfMatches ){ $iRunningMemberCount += 1; }
}

print "\nProcess ids: [[", join (",",@liPids), "]]\n";
print "Running count: [[$iRunningMemberCount]]\n";
