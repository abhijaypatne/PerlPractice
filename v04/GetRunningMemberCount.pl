#------------------------------------------------------------------
# $Copyright: Copyright (c) 2015 Symantec Corporation.
# All rights reserved.
#
# THIS SOFTWARE CONTAINS CONFIDENTIAL INFORMATION AND TRADE SECRETS OF
# SYMANTEC CORPORATION.  USE, DISCLOSURE OR REPRODUCTION IS PROHIBITED
# WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF SYMANTEC CORPORATION.
#
# The Licensed Software and Documentation are deemed to be commercial
# computer software as defined in FAR 12.212 and subject to restricted
# rights as defined in FAR Section 52.227-19 "Commercial Computer
# Software - Restricted Rights" and DFARS 227.7202, "Rights in
# Commercial Computer Software or Commercial Computer Software
# Documentation", as applicable, and any successor regulations. Any use,
# modification, reproduction release, performance, display or disclosure
# of the Licensed Software and Documentation by the U.S. Government
# shall be solely in accordance with the terms of this Agreement.  $
#
# $Header: /project/isv-agent/VProAgents/SAPHDB/actions/GetReplicationStatusInfo,v 1.2 2014/12/05 11:44:57 avaidya Exp $
#
# $Author: apatne $
# $Date: $
# $Revision: $
#
# Provides:                            WebSphere 
# Author:                              apatne 
# crAgent Build:                       1.88 2008/10/13 08:28:02
# crAgent Run Date:                    13 Oct, 2008
# Modification History:
# Known bugs/caveats:
#------------------------------------------------------------------
eval 'exec /opt/VRTSperl/bin/perl -Sw $0 ${1+"$@"}'
  if 0;
 
#---------------------------------------------------------
# Define the exact order to look for our agent framework..
#---------------------------------------------------------
BEGIN {
	my $sVCSperl = undef;
	my $sVCSagntfwHome = "/opt/VRTS/.ACCLib";
	( my $sDirName = $ARGV[0] ) =~ s#(.*)/.*$#$1#;

	if ( $ENV { CLUSTER_HOME } ){ # VCSOne/VCS5.0
		$sVCSperl = "$ENV{CLUSTER_HOME}/lib";
	}
	else { # VCS..
		$sVCSperl = "/opt/VRTSperl/lib/site_perl";
	}
  $ENV { VCS_LOG_AGENT_NAME } ||= "WebSphere";  # export Agent name for action GetReplicationStatusInfo logging..

	unshift ( @INC, $sVCSperl, 
			            "$sVCSagntfwHome/vcs",
              		"$sVCSagntfwHome/system",
			            "$sVCSagntfwHome/network",
			            $sDirName );
}

#------------
# Be strict..
#------------
use strict 'refs';
use strict 'vars';

#-------------------------------------
# Include required framework modules..
#-------------------------------------
use ag_i18n_inc;
use Sys;            # For call to RunCmdArgsAsUser
use Proc;						# For call to FilterProcs
use Version;        # ACC Library version display generator
use VCSagentFW;     # Primary Agent Interface to the ACC Library
use VCSDefines;     # This contains constants that VCS uses
use WebSphere;      # To call agent subroutines
use Sys::Hostname;  # To query current hostname

#-----------------------------------------------------------------------
# Add our version number to the version hash and check if versions are
# requested..
#-----------------------------------------------------------------------
my $sVer = "\$Id: GetRunningMemberCount ,v 1.1 2015/02/25 12:34:56 apatne Exp $::ETVHeader";
Version::TellVersion ( $sVer );

#----------------------------------------------------------------------
# If versions are requested, print all of the framework module versions 
# to stdout, then exit 0..
#----------------------------------------------------------------------
if ( 1 == Version::CheckForVersionRequest ( $ARGV [0] ) ) {
  #------------------------------------------------------------------
  # Found the request to display all versions -- did that, now quit..
  #------------------------------------------------------------------
  exit 0;
}

my $ResName = $ARGV[0]; shift;
VCSAG_SET_ENVS ($ResName);
my $sCurrentHost = Sys::Hostname::hostname();

my ( @liPids, $ret, $sClusterName, $sWASHome, $sServerProfile, $sServerList, $sCmd, $sCmdArgs, $sActionArgs, $iExitCode,                                          $iRunningMemberCount, $sWASNode, $sMyName, $sServer, @lsFieldNames, $sFilter1, $sFilter2, $sOp, @lsMatchedProcs ) = ();
$iRunningMemberCount = 0;

# *****************************  VCSAG_GET_ATTR_VAL ************
($ret, $sWASHome) = VCSAG_GET_ATTR_VALUE ("WAS_HOME", -1, 1, @ARGV );
exit 1 if ($ret != $VCSAG_SUCCESS);
($sWASHome) = VCSAG_SQUEEZE_SPACES ($sWASHome);
($ret, $sWASNode) = VCSAG_GET_ATTR_VALUE ("WAS_NODE", -1, 1, @ARGV );
exit 1 if ($ret != $VCSAG_SUCCESS);
($sWASNode) = VCSAG_SQUEEZE_SPACES ($sWASNode);
($ret, $sActionArgs) = VCSAG_GET_ATTR_VALUE ("ACTION_ARGS", -1, 1, @ARGV );
exit 1 if ($ret != $VCSAG_SUCCESS);
#print "Action args: $sActionArgs\n";

my @sServerNames = split(/,/, $sActionArgs);

my $iNumberOfMatches = 0;
my $sCommandPs     = "/bin/ps";
my $sCommandPsArgs = "axww";
my $sCommandGrep   = "/bin/grep";
my $sCommandGrepArgs = "-i java";
my $bOSType        = Arch::GetOSType();
#--------------------------------------
# from 'man ps' exit values are:
# 0     Successful completion.
# >0    An error occurred.
#--------------------------------------

if ( Arch::SUN_OS == $bOSType ) {
	$sCommandPs = "/usr/ucb/ps";
}
elsif ( Arch::HPUX_OS == $bOSType ) {
	$sCommandPsArgs = "-e -xxo uid,pid,ppid,args";
}
elsif ( Arch::LINUX_OS == $bOSType ) {
	$sCommandPsArgs = "ww -eo uid,pid,ppid,args";
}
elsif ( Arch::AIX_OS == $bOSType ){
	$sCommandPsArgs = "-e -o 'uid,pid,ppid,args'";
}

my @lsOutput = readpipe( "$sCommandPs $sCommandPsArgs | $sCommandGrep $sCommandGrepArgs" );
if ( $iExitCode = $? >> 8 ){
print "Command [$sCommandPs $sCommandPsArgs | $sCommandGrep $sCommandGrepArgs] failed with exit code [$iExitCode]";
}

	my $sOSType = Arch::GetOSType();
foreach $sServer (@sServerNames){
  #--------------------------------------
  # Form the filter to match WAS process
  #--------------------------------------
	my $sRegexWASName = WebSphere::GetServerNameRegex($sServer);
	$sRegexWASName =~ s/\s+/\\s+/g;
	$iNumberOfMatches = 0;
	@lsMatchedProcs = ();
	$sFilter1 = $sWASHome."/.*/bin/.*java.*"."com.ibm.ws.runtime.WsServer".".*"."\\s+".$sRegexWASName."\\s*\$";
	$sFilter2 = $sWASHome."/.*/bin/.*java.*-Dwas.launcher.server=\\w:$sRegexWASName";
	my $sOSType = Arch::GetOSType();
	if ( Arch::HPUX_OS == $sOSType )
	{
		$sFilter1 = "^".$sWASHome.".*/bin/.*java.*";
	}
foreach $sOp ( @lsOutput ){
		if ( $sOp =~ /$sFilter1/ || $sOp =~ /$sFilter2/ ){
			@lsMatchedProcs = split( '\s+', $sOp );
			push @liPids, $lsMatchedProcs[2];
			$iNumberOfMatches += 1;
		}
	}
	if ( $iNumberOfMatches ){ $iRunningMemberCount += 1; }
}

print "\nProcess ids: [[", join (",",@liPids), "]]\n";
print "Running count: [[$iRunningMemberCount]]\n";
