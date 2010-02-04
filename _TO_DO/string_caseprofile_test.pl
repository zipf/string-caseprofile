#!/usr/bin/perl -w
use strict;
use String::CaseProfile qw(get_profile);
use Encode;
use utf8;

my $string = 'Δεν είναι δυνατή η ανάγνωση του αρχείου';

my %profile = get_profile(decode('iso-8859-1', $string));

print $profile{string_type};

print set_profile( $string, { string_type => 'all_uc'} );


