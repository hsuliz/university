#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2


use strict;
use warnings;
use File::Find;
use Encode;

sub count_pattern_occurrences {
    my ($directory, $patterns) = @_;
    my %pattern_counts;
    my @error_files;

    find(
        sub {
            return unless -f;
            my $file_path = $File::Find::name;
            eval {
                open my $file, '<:raw', $file_path or die $!;
                my $content = do {
                    local $/;
                    <$file>
                };
                close $file;
                $content = decode('utf-8', $content, Encode::FB_CROAK);
                for my $pattern (@$patterns) {
                    my $count = () = $content =~ /$pattern/g;
                    if ($count > 0) {
                        $pattern_counts{$file_path}{$pattern} = $count;
                    }
                }
            };
        },
        $directory
    );

    return \%pattern_counts;
}

sub main {
    my @directories;
    my @patterns;

    my $i = 0;
    while ($i < scalar(@ARGV)) {
        if ($ARGV[$i] eq "-d") {
            $i++;
            if ($i < scalar(@ARGV)) {
                push @directories, $ARGV[$i];
            }
            else {
                print "Missing directory argument after -d option.\n";
                return;
            }
        }
        else {
            push @patterns, $ARGV[$i];
        }
        $i++;
    }

    if (!@directories) {
        print "No directories specified. Use -d option to specify at least one directory.\n";
        return;
    }

    for my $directory (@directories) {
        my $pattern_counts = count_pattern_occurrences($directory, \@patterns);

        if (%$pattern_counts) {
            for my $file_path (sort keys %$pattern_counts) {
                for my $pattern (sort keys %{$pattern_counts->{$file_path}}) {
                    my $count = $pattern_counts->{$file_path}{$pattern};
                    print "$file_path: $count $pattern occurrences\n";
                }
            }
        }
    }
}

main();
