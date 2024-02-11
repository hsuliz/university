#!/usr/bin/perl
# Hlib-Oleksandr Suliz, Script Language, group no.2
use strict;
use warnings;

my $memory_file = ".memory";

if (@ARGV < 1) {
    print_usage();
    exit;
}

if ($ARGV[0] eq '--add') {
    add_expense(@ARGV[1 .. $#ARGV]);
}
elsif ($ARGV[0] eq '--remove') {
    remove_expense($ARGV[1]);
}
elsif ($ARGV[0] eq '--list') {
    list_expenses();
}
elsif ($ARGV[0] eq '--file') {
    export_to_csv();
}
elsif ($ARGV[0] eq '--help' || $ARGV[0] eq '--h') {
    print_help();
}
else {
    print "Invalid command.\n";
    print_usage();
}

sub print_usage {
    print "Usage:\n";
    print "  --add <name> <amount>  Add a new expense with a name and amount.\n";
    print "  --remove <id>          Remove an expense by its ID (line number in the .memory file).\n";
    print "  --list                 List all current expenses with their IDs.\n";
    print "  --file                 Export all expenses to a CSV file named 'expenses.csv'.\n";
    print "  --help, -h             Show this help message.\n";
}

sub print_help {
    print "Expense Tracker\n";
    print "----------------\n";
    print "This program is a simple Perl script designed to help you manage your expenses.\n";
    print "You can use it to add, remove, list, and export expenses to a CSV file.\n";
    print "\n";
    print "Usage:\n";
    print "  --add <name> <amount>  Add a new expense with a name and amount.\n";
    print "  --remove <id>          Remove an expense by its ID (line number in the .memory file).\n";
    print "  --list                 List all current expenses with their IDs.\n";
    print "  --file                 Export all expenses to a CSV file named 'expenses.csv'.\n";
    print "  --help, -h             Show this help message.\n";
}

sub add_expense {
    my ($name, $amount, @extra_args) = @_;
    if (scalar @extra_args > 0) {
        print "Invalid input. Usage: $0 --add <name> <amount>\n";
        return;
    }
    unless (defined $name && defined $amount && $amount =~ /^[0-9]+(\.[0-9]{1,2})?$/) {
        print "Invalid input. Usage: $0 --add <name> <amount>\n";
        return;
    }
    open my $fh, '>>', $memory_file or die "Could not open file '$memory_file' $!";
    print $fh "$name,$amount\n";
    close $fh;
    print "Expense added.\n";
}

sub remove_expense {
    my $id = shift;
    unless (defined $id && $id =~ /^\d+$/) {
        print "Invalid id. Usage: $0 --remove <id>\n";
        return;
    }
    my @expenses;
    open my $fh, '<', $memory_file or die "Could not open file '$memory_file' $!";
    while (my $line = <$fh>) {
        push @expenses, $line;
    }
    close $fh;

    if ($id > 0 && $id <= scalar @expenses) {
        splice @expenses, $id - 1, 1;
        open my $fh, '>', $memory_file or die "Could not open file '$memory_file' $!";
        print $fh $_ for @expenses;
        close $fh;
        print "Expense removed.\n";
    }
    else {
        print "Invalid id.\n";
    }
}

sub list_expenses {
    open my $fh, '<', $memory_file or die "Could not open file '$memory_file' $!";
    my $id = 1;
    while (my $line = <$fh>) {
        print $id++ . ". $line";
    }
    close $fh;
}

sub export_to_csv {
    open my $in, '<', $memory_file or die "Could not open file '$memory_file' $!";
    open my $out, '>', 'expenses.csv' or die "Could not open file 'expenses.csv' $!";
    while (my $line = <$in>) {
        print $out $line;
    }
    close $in;
    close $out;
    print "Expenses exported to expenses.csv\n";
}
