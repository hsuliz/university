#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2

use warnings FATAL => 'all';
use strict;
use Cwd qw(abs_path);
use File::Basename qw(dirname);
require './number_checker.pm';

{
    sub change_name {
        my $name = lc($_[0]);
        $name =~ s/(\w+)/\u$1/g;
        return $name;
    }

    sub print_error {
        $_[2] =~ s/^\s+|\s+$//g;
        printf STDERR "ERROR at line %d (%s): '%s'\n", $_[1], $_[0], $_[2];
    }

    my @files = ();

    foreach my $file (@ARGV) {
        if (-e $file) {
            push(@files, $file);
        }
        else {
            print_error("Main script", 0, "File '$file' does not exist.");
        }
    }

    foreach my $file (@files) {
        my $line_nr = 1;
        my %grades = ();

        open my $fh, '<', $file or die "ERROR: Can't open $file: $!";

        while (<$fh>) {
            my @new_line = split(' ', $_);

            if (scalar @new_line < 3) {
                print_error($file, $line_nr, $_);
            }
            else {
                my $name = change_name($new_line[0]) . " " . change_name($new_line[1]);
                my $value = NumberChecker::check_grade($new_line[2]);

                if ($value != -1) {
                    if (exists($grades{$name})) {
                        @{$grades{$name}}[0] += $value;
                        push(@{$grades{$name}}, $new_line[2]);
                    }
                    else {
                        $grades{$name} = [ 0.0 ];
                        push(@{$grades{$name}}, $value);
                        push(@{$grades{$name}}, $new_line[2]);
                    }
                }
                else {
                    print_error($file, $line_nr, $_);
                }
            }

            $line_nr++;
        }

        $file =~ s{\.[^.]+$}{};
        $file = $file . '.oceny';
        my $file_name = $file;

        open my $of_fh, '>', $file_name or die "ERROR: Can't open $file_name: $!";

        my $all_avg = 0;
        foreach my $k (sort keys %grades) {
            printf $of_fh "%-20s: %s\n", $k, join(' ', @{$grades{$k}}[1 .. $#{$grades{$k}}]);
            $all_avg += @{$grades{$k}}[0] / ($#{$grades{$k}} - 1);
        }

        my $keys_count = scalar keys %grades;
        $all_avg = $all_avg / $keys_count;
        $all_avg = sprintf("%.2f", $all_avg);

        printf $of_fh "\nAverage of all: %s\n", $all_avg;

        close($of_fh);
        close($fh);
    }
}
