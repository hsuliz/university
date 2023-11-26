#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2


use strict;
use warnings;
use Getopt::Std;
use Cwd qw(abs_path);
use File::Basename qw(dirname);

require './number_checker.pm';

my %opts;
getopts('diehvLm', \%opts);

sub usage {
    print "Usage: $0 [-d|-i] [-e] file1 [file2 ...]\n";
    print "  -d    Count all numbers, including exponential formats\n";
    print "  -i    Count only integers\n";
    print "  -e    Exclude lines starting with # from processing\n";
}

if ($opts{h}) {
    usage();
    exit 0;
}

my $number_checker = NumberChecker->new();

my $number_option = '';
if ($opts{d}) {
    $number_option = '-d';
} elsif ($opts{i}) {
    $number_option = '-i';
}

my $exclude_comments = $opts{e} ? 1 : 0;

sub count_numbers {
    my ($file) = @_;
    open my $fh, '<', $file or die "Cannot open file '$file': $!";
    my $lines = 0;
    my $words = 0;
    my $chars = 0;
    my $integers = 0;
    my $all_numbers = 0;

    while (<$fh>) {
        chomp;
        next if ($exclude_comments && /^\s*#/);
        my @words_in_line = split /\s+/, $_;

        $lines++;
        $chars += length($_);

        foreach my $word (@words_in_line) {
            $words++;
            if ($number_option eq '-i' && $number_checker->is_integer($word)) {
                $integers++;
                $all_numbers++;
            } elsif ($number_option eq '-d' && $number_checker->is_real_number($word)) {
                $all_numbers++;
            } elsif ($number_option eq '' && ($number_checker->is_integer($word) || $number_checker->is_real_number($word))) {
                $all_numbers++;
            }
        }
    }

    close $fh;

    return {
        lines     => $lines,
        words     => $words,
        chars     => $chars,
        integers  => $integers,
        all_numbers => $all_numbers
    };
}

my $total_lines = 0;
my $total_words = 0;
my $total_chars = 0;
my $total_integers = 0;
my $total_all_numbers = 0;

foreach my $file (@ARGV) {
    if (-e $file) {
        my $stats = count_numbers($file);

        $total_lines += $stats->{lines};
        $total_words += $stats->{words};
        $total_chars += $stats->{chars};
        $total_integers += $stats->{integers};
        $total_all_numbers += $stats->{all_numbers};

        print "\nFile: $file -- lines: $stats->{lines}, words: $stats->{words}, characters: $stats->{chars}";
        print ", integers: $stats->{integers}" if $opts{i};
        print ", all numbers: $stats->{all_numbers}" if $opts{d};
        print "\n";
    } else {
        print "File '$file' does not exist.\n";
    }
}

if (@ARGV > 1) {
    print "\nALL FILES -- lines: $total_lines, words: $total_words, characters: $total_chars";
    print ", integers: $total_integers" if $opts{i};
    print ", all numbers: $total_all_numbers" if $opts{d};
    print "\n\n";
} else {
    print "\n";
}