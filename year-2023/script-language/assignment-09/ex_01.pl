use strict;
use warnings;

my %data_base;

my $filename = './test.txt';
open(FH, '<', $filename) or die $!;
while (<FH>) {
    my ($first_name, $second_name, $grade) = split(/ /, $_);
    #print($first_name, $second_name, $grade);
    if (!exists $data_base{$first_name}) {
        @data_base{$first_name} = [];
    }
    print(@data_base{$first_name})
}
close(FH);

