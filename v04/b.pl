my @sServerNames = qw( horizontal_cluster_member5 managed_server4 server3);

my ( $ret, $sClusterName, $sWASHome, $sServerProfile, $sServerList, $sCmd, $sCmdArgs, $sActionArgs, $iExitCode,                                          $iRunningMemberCount, $sWASNode, $sMyName, $sServer, @lsFieldNames, $sFilter1, $sFilter2, $sOp, @lsMatchedProcs ) = ();
$iRunningMemberCount = 0;

my @lsOutput = readpipe( "ps -ef | grep -i java" );
if ( $iExitCode = $? >> 8 ){
	print "Command [$sCommandPs $sCommandPsArgs | $sCommandGrep $sCommandGrepArgs] failed with exit code [$iExitCode]";
}

	$sFilter1 = "^".$sWASHome."/.*/bin/.*java.*"."com.ibm.ws.runtime.WsServer".".*"."\\s+".$sRegexWASName."\\s*\$";
	$sFilter2 = "^".$sWASHome."/.*/bin/.*java.*-Dwas.launcher.server=\\w:$sRegexWASName";
	foreach $sOp ( @lsOutput ){
		if ( $sOp =~ /$sFilter1/ || $sOp =~ /$sFilter2/ ){
			push @lsMatchedProcs, $sOp;
		}
	}

my $s = "horizontal_cluster_member5";
my $h = "/opt/IBM/WebSphere/AppServer";
my $op = "root     16623 22056  0 Mar06 ?        00:06:36 /opt/IBM/WebSphere/AppServer/java/bin/java -Declipse.security -Dwas.status.socket=35200 -Dosgi.install.area=/opt/IBM/WebSphere/AppServer -Dosgi.configuration.area=/opt/IBM/WebSphere/AppServer/profiles/AppSrv04/servers/horizontal_cluster_member5/configuration -Djava.awt.headless=true -Dosgi.framework.extensions=com.ibm.cds,com.ibm.ws.eclipse.adaptors -Xshareclasses:name=webspherev85_1.6_64_%g,nonFatal -Xbootclasspath/p:/opt/IBM/WebSphere/AppServer/java/jre/lib/ibmorb.jar -classpath /opt/IBM/WebSphere/AppServer/profiles/AppSrv04/properties:/opt/IBM/WebSphere/AppServer/properties:/opt/IBM/WebSphere/AppServer/lib/startup.jar:/opt/IBM/WebSphere/AppServer/lib/bootstrap.jar:/opt/IBM/WebSphere/AppServer/lib/jsf-nls.jar:/opt/IBM/WebSphere/AppServer/lib/lmproxy.jar:/opt/IBM/WebSphere/AppServer/lib/urlprotocols.jar:/opt/IBM/WebSphere/AppServer/deploytool/itp/batchboot.jar:/opt/IBM/WebSphere/AppServer/deploytool/itp/batch2.jar:/opt/IBM/WebSphere/AppServer/java/lib/tools.jar -Dibm.websphere.internalClassAccessMode=allow -Xms50m -Xmx256m -Xcompressedrefs -Xscmaxaot4M -Xscmx90M -Dws.ext.dirs=/opt/IBM/WebSphere/AppServer/java/lib:/opt/IBM/WebSphere/AppServer/profiles/AppSrv04/classes:/opt/IBM/WebSphere/AppServer/classes:/opt/IBM/WebSphere/AppServer/lib:/opt/IBM/WebSphere/AppServer/installedChannels:/opt/IBM/WebSphere/AppServer/lib/ext:/opt/IBM/WebSphere/AppServer/web/help:/opt/IBM/WebSphere/AppServer/deploytool/itp/plugins/com.ibm.etools.ejbdeploy/runtime -Dderby.system.home=/opt/IBM/WebSphere/AppServer/derby -Dcom.ibm.itp.location=/opt/IBM/WebSphere/AppServer/bin -Djava.util.logging.configureByServer=true -Duser.install.root=/opt/IBM/WebSphere/AppServer/profiles/AppSrv04 -Djava.ext.dirs=/opt/IBM/WebSphere/AppServer/tivoli/tam:/opt/IBM/WebSphere/AppServer/java/jre/lib/ext -Djavax.management.builder.initial=com.ibm.ws.management.PlatformMBeanServerBuilder -Dpython.cachedir=/opt/IBM/WebSphere/AppServer/profiles/AppSrv04/temp/cachedir -Dwas.install.root=/opt/IBM/WebSphere/AppServer -Djava.util.logging.manager=com.ibm.ws.bootstrap.WsLogManager -Dserver.root=/opt/IBM/WebSphere/AppServer/profiles/AppSrv04 -Dcom.ibm.security.jgss.debug=off -Dcom.ibm.security.krb5.Krb5Debug=off -Djava.library.path=/opt/IBM/WebSphere/AppServer/lib/native/linux/x86_64/:/opt/IBM/WebSphere/AppServer/java/jre/lib/amd64/default:/opt/IBM/WebSphere/AppServer/java/jre/lib/amd64:/opt/IBM/WebSphere/AppServer/bin:/usr/lib: -Djava.endorsed.dirs=/opt/IBM/WebSphere/AppServer/endorsed_apis:/opt/IBM/WebSphere/AppServer/java/jre/lib/endorsed:/opt/IBM/WebSphere/AppServer/endorsed_apis:/opt/IBM/WebSphere/AppServer/java/jre/lib/endorsed:/opt/IBM/WebSphere/AppServer/endorsed_apis:/opt/IBM/WebSphere/AppServer/java/jre/lib/endorsed -Djava.security.auth.login.config=/opt/IBM/WebSphere/AppServer/profiles/AppSrv04/properties/wsjaas.conf -Djava.security.policy=/opt/IBM/WebSphere/AppServer/profiles/AppSrv04/properties/server.policy com.ibm.wsspi.bootstrap.WSPreLauncher -nosplash -application com.ibm.ws.bootstrap.WSLauncher com.ibm.ws.runtime.WsServer /opt/IBM/WebSphere/AppServer/profiles/AppSrv04/config Dmgr02-cell AppSrv04-node horizontal_cluster_member5";

my $f = $h."/.*\\s+.*"."\\b".$s."\\b\$";
print "filter: $f\n";

if ( $op =~ /$f/){ print "matched\n"; }
else { print "unable to match\n";};
















