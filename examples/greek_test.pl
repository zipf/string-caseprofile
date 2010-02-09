#!/usr/bin/perl -w
use strict;
use String::CaseProfile qw(:all);
use utf8;

binmode STDOUT, ':utf8';

my $string = 'Δεν είναι δυνατή η ανάγνωση του αρχείου';
print "Source string: $string\n";

# string already encoded as UTF-8
my %profile = get_profile( $string );

print "$profile{string_type}\n";

print "Target string: ", set_profile( $string, ( string_type => 'all_uc' ) );
print "\n";

my $str = "Λίστα των συγγραφέων του προγράμματος";
print "Target string: ", set_profile( $str, ( string_type => 'all_lc' ) );
print "\n";

my %profile1 = ( custom => { 'all_lc' => '1st_uc' } );

print set_profile('Список авторов программы', %profile1);

