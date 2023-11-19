#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2

use strict;
use warnings;

if (@ARGV < 2) {
    die "Usage: $0 <start_word_number> <end_word_number> [files...]\n";
}

my $start = shift;
my $end = shift;

while (<>) {
    chomp;
    my @words = split;
    my $output = "";

    foreach my $i ($start-1..$end-1) {
        if (defined $words[$i]) {
            $output .= $words[$i] . " ";
        }
    }

    $output =~ s/^\s+|\s+$//g;
    print "$output\n";
}

foreach my $file (@ARGV) {
    open my $fh, '<', $file or warn "Cannot open file $file: $!";
    close $fh;
}