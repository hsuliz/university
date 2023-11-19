#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2


use strict;
use warnings;

if (@ARGV < 2) {
    die "Usage: $0 <separator> <start_field_number> <end_field_number> [files...]\n";
}

my $separator = shift;
my $start = shift;
my $end = shift;

while (<>) {
    chomp;
    my @fields = split /$separator/, $_;
    my $output = "";

    foreach my $i ($start - 1 .. $end - 1) {
        if (defined $fields[$i]) {
            $output .= $fields[$i] . " ";
        }
    }

    $output =~ s/^\s+|\s+$//g;
    print "$output\n";
}

foreach my $file (@ARGV) {
    open my $fh, '<', $file or warn "Cannot open file $file: $!";
    close $fh;
}
