package NumberChecker;

use strict;
use warnings;

sub new {
    my $class = shift;
    return bless {}, $class;
}

sub is_integer {
    my ($self, $number) = @_;
    if ($number =~ /^\d+$/) {
        return "Integer: $number";
    }
    else {
        return "Invalid integer: $number";
    }
}

sub is_real_number {
    my ($self, $number) = @_;
    if ($number =~ /^[+-]?(\d+(\.\d*)?|\.\d+)([eEdDqQ^][+-]?\d+)?$/) {
        return "Real number: $number";
    }
    else {
        return "Invalid real number: $number";
    }
}

1;
