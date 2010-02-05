#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 11;

use String::CaseProfile qw(get_profile set_profile copy_profile);
use Encode;

my @strings = (
                'conexión a Internet',
                'An Internet-based application',
                'THE ABS MODULE',
                'Yes, I think so',
                "this is what I'm used to",
              );

# encode strings as utf-8
my @samples = map { decode('iso-8859-1', $_) } @strings;

my $new_string;


# EXAMPLE 1

# Get the profile of a string excluding the word 'Internet'
my %profile = get_profile($samples[0], ['Internet']);

is($profile{string_type}, 'all_lc', 'All words are lowercase');
is($profile{words}[2]->{word}, 'Internet', 'Third word is Internet');
is($profile{words}[2]->{type}, 'excluded', 'The type of the 2nd word is excluded');

# Set this profile to $samples[1], excluding the compound word 'Internet-based'
$profile{exclude} = ['Internet'];
$new_string = set_profile($samples[1], %profile);

is($new_string, 'an Internet-based application',
                'All non-excluded words are lowercase');


# EXAMPLE 2

# Set the profile of a string containing an '1st_uc' excluded word to 'all_uc'
%profile = ( string_type => 'all_uc', exclude => ['Internet'] );
$new_string = set_profile($samples[0], %profile);

is($new_string, 'CONEXIÓN A INTERNET',
                'All words are uppercase, even the excluded ones');


# Set the profile of a string containing an 'all_uc' excluded word to 'all_lc'
%profile = ( string_type => 'all_lc', exclude => ['ABS'] );
$new_string = set_profile($samples[2], %profile);

is($new_string, 'the ABS module',
                'All words are lowercase, except the excluded ones');


# EXAMPLE 3

# Get the profile of a string containing the word 'I'
%profile = get_profile($samples[3], ['I']);

is($profile{string_type}, '1st_uc', '1st_uc type string');
is($profile{words}[1]->{word}, 'I', 'Second word is I');
is($profile{words}[1]->{type}, 'excluded', 'The type of the 2nd word is excluded');

# Set this profile to $samples[4], excluding the compound word 'I'm'
# using the copy_profile function
$new_string = copy_profile(
                           from => $samples[3],
                           to   => $samples[4],
                           exclude => ['I'],
                          );

is($new_string, "This is what I'm used to",
                "Fourth word case is not changed");



# EXAMPLE 4: Change a string using a custom profile
%profile = (
            custom  => {
                        default => '1st_uc',
                        index   => { '1'  => 'all_lc' }, # 2nd word
                        },
            exclude => ['ABS'],
            );

$new_string = set_profile($samples[2], %profile);
is($new_string, 'The ABS Module', 'Custom profile worked right');
    
