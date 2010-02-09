#!/usr/bin/perl -w
use strict;
use String::CaseProfile qw(get_profile set_profile copy_profile);
use utf8;

# Samples using other alphabets

binmode STDOUT, ':utf8';


my @samples = ( 
                'Ծրագրի հեղինակների ցանկը', # Armenian
                'Λίστα των συγγραφέων του προγράμματος', # Greek
                'Список авторов программы', # Russian
              );

my $new_string;


# EXAMPLE 9: Get the profile of a string

my %profile = get_profile( $samples[0] );

print "$profile{string_type}\n";   # prints '1st_uc'


# EXAMPLE 10: Change a string using a custom profile

%profile = ( string_type  => 'all_uc');

$new_string = set_profile($samples[0], %profile);

print "$new_string\n"; # prints 'ԾՐԱԳՐԻ ՀԵՂԻՆԱԿՆԵՐԻ ՑԱՆԿԸ'


# EXAMPLE 11: Get the profile of a string and apply it to another string

print set_profile($samples[1], get_profile($new_string)); # prints 'ΛΊΣΤΑ ΤΩΝ ΣΥΓΓΡΑΦΈΩΝ ΤΟΥ ΠΡΟΓΡΆΜΜΑΤΟΣ'
print "\n";


# EXAMPLE 12: More custom profiles

my %profile1 = (
            custom  => {
                        default => 'all_lc',
                        index   => { '1'  => 'all_uc' }, # 2nd word
                       }
            );
            
my %profile2 = ( custom => { 'all_lc' => '1st_uc' } );

print set_profile($samples[2], %profile1); # prints 'список АВТОРОВ программы'
print "\n";

print set_profile($samples[2], %profile2); # prints 'Список Авторов Программы'
print "\n";


