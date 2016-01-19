my @a = grep { (s/\n// || 1) } `ls`;
sleep(2);
print "sleeping \n";
print join(',', @a);
