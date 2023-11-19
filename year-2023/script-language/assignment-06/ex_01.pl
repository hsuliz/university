#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2

use strict;
use warnings;

my ($number_lines, $exclude_comments, $print_lines, $separate_lines) = (0, 0, 0, 0);

while (@ARGV && $ARGV[0] =~ /^-/) {
    my $option = shift @ARGV;
    if ($option eq '-c') {
        $number_lines = 1;
    } elsif ($option eq '-N') {
        $exclude_comments = 1;
    } elsif ($option eq '-n') {
        $print_lines = 1;
    } elsif ($option eq '-p') {
        $separate_lines = 1;
    } else {
        die "Unknown option: $option\n";
    }
}

my $file_number = 1;
my $line_number = 1;

while (<>) {
    if ($exclude_comments && /^#/) {
        next;
    }

    if ($separate_lines) {
        printf "%6d  %s", $line_number++, $_;
    } elsif ($number_lines) {
        printf "%6d  %s", $line_number++, $_ if $print_lines;
    } else {
        print;
    }
}

continue {
    if (eof) {
        if ($separate_lines) {
            print "     \n" if $line_number > 1;
        }
        $file_number++;
        $line_number = 1 if $separate_lines;
    }
}