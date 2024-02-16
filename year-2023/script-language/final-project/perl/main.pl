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
elsif ($ARGV[0] eq '--export') {
    if (!defined $ARGV[1]) {
        print "Usage: $0 --export <file_path> [--encrypt <key>]\n";
        exit;
    }
    my $csv_file_path = $ARGV[1];

    my $encrypt = 0;
    my $key;
    if (defined $ARGV[2] && $ARGV[2] eq '--encrypt') {
        $encrypt = 1;
        $key = $ARGV[3];
        if (!defined $key) {
            die "Usage: $0 --export <file_path> --encrypt <key>\n";
        }
    }

    export_to_csv($encrypt, $key, $csv_file_path);
}
elsif ($ARGV[0] eq '--help' || $ARGV[0] eq '--h') {
    print_help();
}
elsif ($ARGV[0] eq '--import') {
    if (!defined $ARGV[1]) {
        die "Usage: $0 --import <file_path> [--decrypt <key>]\n";
    }
    my $file_path = $ARGV[1];
    my $decrypt = defined $ARGV[2] && $ARGV[2] eq '--decrypt';
    my $key = $decrypt ? $ARGV[3] : undef;

    import_from_csv($decrypt, $key, $file_path);
}
else {
    print "Invalid command.\n";
    print_usage();
}

sub print_usage {
    print "Usage:\n";
    print "  --add <name> <amount>     Add a new expense with a name and amount.\n";
    print "  --remove <id>             Remove an expense by its ID (line number in the .memory file).\n";
    print "  --list                    List all current expenses with their IDs.\n";
    print "  --export <file_path>  Export all expenses to a specified CSV file. Automatically appends '.csv' if not present.\n";
    print "  --export <file_path> --encrypt <key>  Export and encrypt all expenses to a specified CSV file with a user-specified key. The '.enc' extension is added to the file.\n";
    print "  --import <file_path>      Import expenses from a CSV file. Automatically detects '.csv' or '.enc' files based on the provided path.\n";
    print "  --import <file_path> --decrypt <key>  Import and decrypt expenses from an encrypted CSV file using a specified key.\n";
    print "  --help, --h               Show this help message.\n";
}

sub print_help {
    print "Expense Tracker\n";
    print "----------------\n";
    print "This program is a simple Perl script designed to help you manage your expenses.\n";
    print "You can use it to add, remove, list, export, and import expenses.\n";
    print "It supports exporting expenses to both non-encrypted and encrypted CSV files,\n";
    print "using AES-256 encryption for the latter, by providing a user-specified encryption key.\n";
    print "\nFor encrypted exports, the '.enc' extension is automatically added to the filename.\n";
    print "For imports, the script can automatically handle both encrypted and non-encrypted files,\n";
    print "with necessary decryption performed using the provided key.\n";
    print "\n";
    print_usage();
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
    unless (-e $memory_file) {
        open my $fh, '>', $memory_file or die "Could not open file '$memory_file' $!";
        close $fh;
    }
    open my $fh, '>>', $memory_file or die "Could not open file '$memory_file' $!";
    print $fh "$name,$amount\n";
    close $fh;
    print "Expense added.\n";
}

sub remove_expense {
    my $id = shift;

    unless (-e $memory_file) {
        print "No expenses recorded yet. There's nothing to remove.\n";
        return;
    }

    unless (defined $id && $id =~ /^\d+$/) {
        print "Invalid id. Usage: $0 --remove <id>\n";
        return;
    }

    my @expenses;
    open my $fh, '<', $memory_file or die "Could not open file '$memory_file': $!";
    @expenses = <$fh>;
    close $fh;

    if ($id > 0 && $id <= scalar @expenses) {
        splice @expenses, $id - 1, 1;
        open $fh, '>', $memory_file or die "Could not open file '$memory_file' for writing: $!";
        print $fh $_ for @expenses;
        close $fh;
        print "Expense #$id removed.\n";
    }
    else {
        print "Invalid id. No expense found with ID $id.\n";
    }
}

sub list_expenses {
    unless (-e $memory_file) {
        print "No expenses recorded yet.\n";
        return;
    }
    open my $fh, '<', $memory_file or die "Could not open file '$memory_file' $!";
    my $id = 1;
    while (my $line = <$fh>) {
        print $id++ . ". $line";
    }
    close $fh;
}

sub export_to_csv {
    my ($encrypt, $key, $csv_file_path) = @_;

    $csv_file_path .= ".csv" unless $csv_file_path =~ /\.csv$/i;

    unless (-e $memory_file) {
        print "No expenses recorded yet. Nothing to export.\n";
        return;
    }

    if ($encrypt && !defined $key) {
        die "Encryption key is required for encrypted exports.\n";
    }
    elsif ($encrypt && defined $key) {
        my $encrypted_file_path = $csv_file_path =~ s/\.csv$/.enc/r;
        open my $in, '<', $memory_file or die "Could not open file '$memory_file': $!";
        open my $out, '|-', "openssl enc -aes-256-cbc -salt -pbkdf2 -iter 10000 -out '$encrypted_file_path' -pass pass:$key" or die "Could not open openssl for writing: $!";
        while (my $line = <$in>) {
            print $out $line;
        }
        close $in;
        close $out;
        print "Expenses encrypted and exported to $encrypted_file_path\n";
    }
    else {
        open my $in, '<', $memory_file or die "Could not open file '$memory_file': $!";
        open my $out, '>', $csv_file_path or die "Could not open file '$csv_file_path': $!";
        while (my $line = <$in>) {
            print $out $line;
        }
        close $in;
        close $out;
        print "Expenses exported to $csv_file_path\n";
    }
}

use File::Temp qw(tempfile);

sub import_from_csv {
    my ($decrypt, $key, $path) = @_;

    unless (-e $path) {
        die "File '$path' does not exist.\n";
    }

    if ($decrypt) {
        die "Decryption key is required." unless defined $key;

        my ($fh, $temp_filename) = tempfile();

        my $decrypt_command = "openssl enc -aes-256-cbc -d -salt -pbkdf2 -iter 10000 -in '$path' -out '$temp_filename' -pass pass:$key 2>/dev/null";
        my $decrypt_status = system($decrypt_command);

        if ($decrypt_status != 0) {
            unlink $temp_filename;
            die "Decryption failed. Please check the decryption key.\n";
        }

        seek($fh, 0, 0);
        while (my $line = <$fh>) {
            process_expense_line($line);
        }
        close $fh;
        unlink $temp_filename;
    }
    else {
        open my $in, '<', $path or die "Could not open file '$path' for reading: $!";
        while (my $line = <$in>) {
            process_expense_line($line);
        }
        close $in;
    }

    print "Expenses imported from $path\n";
}

sub process_expense_line {
    my $line = shift;
    chomp $line;
    my ($name, $amount) = split /,/, $line, 2;
    unless (defined $name && defined $amount && $amount =~ /^[0-9]+(?:\.[0-9]{1,2})?$/) {
        warn "Invalid record format in file: $line\n";
        return;
    }
    add_expense($name, $amount);
}
