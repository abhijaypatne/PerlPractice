#!/usr/bin/perl


if ($ARGV[0] eq "start"){start(); }
elsif ($ARGV[0] eq "stop"){stop();}
elsif ($ARGV[0] eq "monitor"){monitor();}

sub start
{
	print "starting\n";
	qx/sudo service httpd start/;
}

sub stop
{
	print "Stopping\n";
	qx/sudo service httpd stop/;
}

sub monitor
{
	while (1)
	{
		print "Monitoring\n";
		my @ps_output = qx/ps -eo pid,ppid,user,comm/;
		my $instances = 0;
		my @details = ();
		my $apache_flag = 0;
		foreach $tmp (@ps_output){
			my $i=0;
			if ($tmp =~ m/httpd/){
				if (!($tmp =~ m/(root)/)){
					$instances = $instances + 1;
					$apache_flag = 1;
					push (@details, $tmp);
					@tmp = split(" ", $tmp);
					push (@pid_array , $tmp[0]);
					push (@ppid_array , $tmp[1]);
				}
				else{
					@root_proc = split(" ", $tmp);
				}
			}
			if($ppid_array[$i] = $root_proc[0]){
				if($root_proc = 1){ $apache_flag = 1;}
				else{ $apache_flag = 2;}
			}
			$i = $i + 1;
		}
		print $instances, " instances running\n";
		print @details;
		#print @root_proc;
		#my @pid_array = qx/cut -d " " -f 5 apache/;
		#my $no_of_proc= qx/wc -l apache | cut -d " " -f 1/;

		if ($apache_flag = 0){print "Apache is offline";}
		elsif ($apache_flag = 1){print "Apache running, pid = ", $pid_array[0];}
		elsif ($apache_flag = 2){print "Apache is online";}

		system("ls", "/var/run/httpd/httpd.pid");
		my $output = qx/echo $?/;

		if ($output != 0){
			print "pidfile doesn't exist\n";
		}else{
			print "pidfile exists\n";}
		sleep(5);
	}

}
