#!/usr/bin/perl -w
use strict;
use String::CaseProfile qw(:all);
use Encode;
use utf8;

my $string = 'Δεν είναι δυνατή η ανάγνωση του αρχείου';

binmode STDOUT, ':utf8';

# string already encoded as UTF-8
my %profile = get_profile( $string );

print $profile{string_type};

print set_profile( $string, ( string_type => 'all_uc' ) );


