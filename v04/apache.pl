 /bin/bash: 2: command not found
  2 my @ps_output = qx/ps -eo user,pid,ppid,user,comm/;
  3 my $instances = 0;
  4 my @details = ();
  5 foreach $tmp (@ps_output){
  6         if ($tmp =~ m/httpd/){
  7                 unless ($tmp =~ m/^(root)/){
  8                         $instances = $instances + 1;
  9                         push (@details, $tmp);
 10                 }
 11         }
 12 }
 13 print $instances, "\n";
 14 print @details;
 15
 16 my @pid_array = qx/cut -d " " -f 5 apache/;
 17 my $no_of_proc= qx/wc -l apache | cut -d " " -f 1/;
 18
 19 if ($instances < 1){
 20         print "Apache not running";
 21 }else{
 22         print "Apache running, pid = ", $pid_array[2];}
 23
 24 system("ls", "/var/run/httpd/httpd.pid");
 25 my $output = qx/echo $?/;
 26
 27 if ($output != 0){
 28         print "pidfile doesn't exist\n";
 29 }else{
 30         print "pidfile exists\n";}
 31
 32
