#!/usr/bin/perl
use strict;

use JSON::Parse;
use Data::Dumper;

# Dumper setting to output JSON
$Data::Dumper::Terse = 1;
$Data::Dumper::Useqq = 1;
$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Pair = ' : ';

my $json_ads = '/Users/justin/Code/myrtspostcards/data/cards.json';
my $new_file = '/Users/justin/Code/myrtspostcards/data/new_cards.json';
my $ads = JSON::Parse::json_file_to_perl($json_ads);
my $base_path = '/Users/justin/Code/myrtspostcards/content/cards/';

my @new_cards;
my $weight = 1;
foreach my $o (sort {
    $a->{date} cmp $b->{date} ||
    $a->{year} cmp $b->{year} ||
    $a->{image_front} cmp $b->{image_front}
} @$ads) {
    $o->{weight} = $weight++;
    push @new_cards, $o;
}
open my $fh, '>', $new_file or die $!;
print $fh Dumper(\@new_cards);
