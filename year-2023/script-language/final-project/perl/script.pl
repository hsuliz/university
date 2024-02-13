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
        print "Usage: $0 --export <csv_file_path> [--encrypt <key>]\n";
        exit;
    }
    my $csv_file_path = $ARGV[1];

    my $encrypt = 0;
    my $key;
    if (defined $ARGV[2] && $ARGV[2] eq '--encrypt') {
        $encrypt = 1;
        $key = $ARGV[3];
        if (!defined $key) {
            die "Usage: $0 --export <csv_file_path> --encrypt <key>\n";
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
    print "  -- export <csv_file_path>    Export all expenses to a specified CSV file.\n";
    print "  -- export <csv_file_path> --encrypt <key>    Export and encrypt all expenses to a specified CSV file with a user-specified key.\n";
    print "  --import                  Import expenses from a CSV file named 'expenses.csv'.\n";
    print "  --import --decrypt <key>  Import and decrypt expenses from a CSV file using a specified key.\n";
    print "  --help, --h               Show this help message.\n";
}

sub print_help {
    print "Expense Tracker\n";
    print "----------------\n";
    print "This program is a simple Perl script designed to help you manage your expenses.\n";
    print "You can use it to add, remove, list, export, and import expenses.\n";
    print "It supports exporting expenses to both non-encrypted and encrypted CSV files,\n";
    print "using AES-256 encryption for the latter, by providing a user-specified encryption key.\n";
    print "\n";
    print "Newly introduced functions allow you to import expenses from a CSV file,\n";
    print "with the option to decrypt an encrypted file using the appropriate key.\n";
    print "This ensures your data can be securely managed and transferred.\n";
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
    my ($encrypt, $key, $csv_file) = @_;

    unless (-e $memory_file) {
        print "No expenses recorded yet. Nothing to export.\n";
        return;
    }

    if ($encrypt) {
        die "Encryption key is required." unless defined $key;
        my $encrypted_file = $csv_file . '.enc';
        open my $in, '<', $memory_file or die "Could not open file '$memory_file': $!";
        open my $out, '|-', "openssl enc -aes-256-cbc -salt -pbkdf2 -iter 10000 -out '$encrypted_file' -pass pass:$key" or die "Could not open openssl for writing: $!";
        while (my $line = <$in>) {
            print $out $line;
        }
        close $in;
        close $out;
        print "Expenses encrypted and exported to $encrypted_file\n";
    }
    else {
        open my $in, '<', $memory_file or die "Could not open file '$memory_file': $!";
        open my $out, '>', "$csv_file.csv" or die "Could not open file '$csv_file': $!";
        while (my $line = <$in>) {
            print $out $line;
        }
        close $in;
        close $out;
        print "Expenses exported to $csv_file.csv\n";
    }
}

sub import_from_csv {
    my ($decrypt, $key, $path) = @_;

    # Correctly declare $in within the scope of the subroutine
    my $in; # Declare $in here

    if ($decrypt) {
        die "Decryption key is required." unless defined $key;
        # Open a pipe to OpenSSL for decryption and assign it to $in
        open $in, '-|', "openssl enc -aes-256-cbc -d -salt -pbkdf2 -iter 10000 -in '$path' -out - -pass pass:$key" or die "Failed to open openssl for decryption: $!";
    } else {
        # Open the file normally for reading and assign it to $in
        open $in, '<', $path or die "Could not open file '$path' for reading: $!";
    }

    while (my $line = <$in>) {
        chomp $line;
        my ($name, $amount) = split /,/, $line, 2;
        unless (defined $name && defined $amount && $amount =~ /^[0-9]+(?:\.[0-9]{1,2})?$/) {
            warn "Invalid record format in file: $line\n";
            next;
        }
        add_expense($name, $amount);
    }
    close $in;

    print "Expenses imported from $path\n";

    # No need for unlink here since no temporary file is created
}
