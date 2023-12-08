package NumberChecker;

use strict;
use warnings;

use Exporter;

our @ISA = qw(Exporter);
our @EXPORT = qw(check_integer check_other check_grade);

sub check_integer {
    return $_[0] =~ /^[+-]?\d+$/ ? 1 : 0;
}

sub check_other {
    return $_[0] =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([EeQqDd^]([+-]?\d+))?$/ ? 1 : 0;
}

sub process_grade {
    my ($value, $operator, $adjustment) = @_;

    return -1 unless defined $value && $value =~ /^-?\d+\.?\d*$/;

    $value += $adjustment;

    return ($value == 0 || ($value >= 2 && $value <= 5)) ? $value : -1;
}

sub check_grade {
    return -1 unless $_[0] =~ /^[+-]?\d*\.?\d*$/;

    if ($_[0] =~ /^[+]/) {
        my ($value) = split /\+/, $_[0];
        return process_grade($value, '+', 0.25);
    }
    elsif ($_[0] =~ /[-]$/) {
        my ($value) = split /-/, $_[0];
        return process_grade($value, '-', -0.25);
    }
    else {
        $_[0] =~ /(\d+(?:\.\d+)?)/;
        my $value = $1;
        return process_grade($value, '', 0);
    }
}

1;
