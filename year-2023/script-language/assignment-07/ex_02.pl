#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2


use strict;
use warnings;

if (@ARGV < 2) {
    die "Usage: $0 <word_number1> <word_number2> [files...]\n";
}

my $num1 = shift;
my $num2 = shift;

while (<>) {
    chomp;
    my @words = split;

    if (defined $words[$num1 - 1] and defined $words[$num2 - 1]) {
        print "$words[$num1 - 1] $words[$num2 - 1]\n";
    }
    else {
        warn "Skipping line $. in file $ARGV: Missing data for word numbers $num1 and $num2\n";
    }
}

foreach my $file (@ARGV) {
    open my $fh, '<', $file or warn "Cannot open file $file: $!";
    close $fh;
}