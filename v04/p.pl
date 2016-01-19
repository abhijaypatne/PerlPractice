my @array = qw ( one two three three one );
my %hash   = map { $_, 1 } @array;
# or a hash slice: @hash{ @array } = ();
# or a foreach: $hash{$_} = 1 foreach ( @array );

my @unique = keys %hash;

print "original: ", join(', ', @array), "\n";
print "unique: ", join(', ', @unique), "\n";
