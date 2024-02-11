#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use POSIX qw(strftime);

my $data_dir = '.memory';
my $report_base_dir = 'expense_reports';

# Ensure base directories exist
mkdir $data_dir unless -d $data_dir;
mkdir $report_base_dir unless -d $report_base_dir;

# Command-line options
my ($add, $list, $remove, $file, $description, $price, $date_input, $all);

GetOptions(
    'add' => \$add,
    'list' => \$list,
    'remove=i' => \$remove,
    'file' => \$file,
    'description=s' => \$description,
    'price=f' => \$price,
    'date=s' => \$date_input,
    'all' => \$all,
);

sub add_expense {
    my $date = $date_input || strftime "%Y-%m", localtime;
    my $data_file = "$data_dir/expenses_$date.txt";

    open my $fh, '>>', $data_file or die "Could not open $data_file: $!";
    print $fh strftime("%Y-%m-%d", localtime) . ",$description,$price\n";
    close $fh;
    print "Expense added.\n";
}

sub list_expenses {
    my @files;
    if ($all) {
        @files = glob("$data_dir/expenses_*.txt");
    } elsif (defined $date_input) {
        @files = glob("$data_dir/expenses_$date_input*.txt");
    } else {
        my $current_month = strftime "%Y-%m", localtime;
        @files = glob("$data_dir/expenses_$current_month*.txt");
    }

    print "Listing expenses:\n";
    foreach my $file (@files) {
        open my $fh, '<', $file or die "Could not open file: $!";
        while (my $line = <$fh>) {
            print $line;
        }
        close $fh;
    }
}

sub remove_expense {
    my ($index) = @_;
    my $date = $date_input || strftime "%Y-%m", localtime;
    my $data_file = "$data_dir/expenses_$date.txt";

    unless (-e $data_file) {
        print "No expenses recorded for $date.\n";
        return;
    }

    open my $fh, '<', $data_file or die "Could not open $data_file: $!";
    my @lines = <$fh>;
    close $fh;

    if ($index > 0 && $index <= scalar @lines) {
        splice(@lines, $index - 1, 1);
        open $fh, '>', $data_file or die "Could not write to $data_file: $!";
        print $fh @lines;
        close $fh;
        print "Expense removed.\n";
    } else {
        print "Invalid expense number.\n";
    }
}

sub generate_csv {
    my $year = defined $date_input ? substr($date_input, 0, 4) : strftime "%Y", localtime;
    my $report_dir = "$report_base_dir/$year";
    mkdir $report_dir unless -d $report_dir;

    my $filename = $all ? "expenses_report_all_$year.csv" : defined $date_input ? "expenses_report_$date_input.csv" : "expenses_report_$year.csv";
    my $output_file = "$report_dir/$filename";

    my @files = $all ? glob("$data_dir/expenses_*.txt") : defined $date_input ? glob("$data_dir/expenses_$date_input*.txt") : glob("$data_dir/expenses_$year*.txt");

    open my $out, '>', $output_file or die "Could not open $output_file: $!";
    foreach my $file (@files) {
        open my $fh, '<', $file or die "Could not open $file: $!";
        while (my $line = <$fh>) {
            print $out $line;
        }
        close $fh;
    }
    close $out;
    print "Report generated: $output_file\n";
}

# Main program logic
if ($add) {
    die "Description and price are required to add an expense.\n" unless defined $description && defined $price;
    add_expense();
} elsif ($list) {
    list_expenses();
} elsif (defined $remove) {
    die "A date is required to remove an expense.\n" unless defined $date_input;
    remove_expense($remove);
} elsif ($file) {
    generate_csv();
} else {
    print STDERR "Invalid or missing command. Use --add, --list, --remove, or --file.\n";
}
