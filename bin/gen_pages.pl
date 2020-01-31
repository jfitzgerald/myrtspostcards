#!/usr/bin/perl
use strict;

use JSON::Parse;
use Data::Dumper;

# Dumper setting to output JSON
$Data::Dumper::Terse = 1;
$Data::Dumper::Useqq = 1;
$Data::Dumper::Pair = ' : ';

#my $json_ads = '/Users/justin/Code/myrtspostcards/data/cards.json';
my $json = $ARGV[0] or die "Missing input JSON file\n";
my $ads = JSON::Parse::json_file_to_perl($json);
#print Dumper($ads);

# {
#     'title' => 'sun laze - san diego california club',
#     'image' => 'images/ads/SCN_0052.jpg',
#     'details' => [
#                    'images/ads/SCN_0052_1.jpg',
#                    'images/ads/SCN_0052_2.jpg',
#                    'images/ads/SCN_0052_3.jpg',
#                    'images/ads/SCN_0052_4.jpg',
#                    'images/ads/SCN_0052_5.jpg'
#                  ],
#     'thumb' => 'images/ads/SCN_0052_thumb.jpg',
#     'description' => 'Sun laze in the winter mildness of San Diego.',
#     'tags' => [
#                 'all-year club'
#               ],
#     'slug' => 'sun-laze-san-diego-california',
#     'detail_thumbs' => [
#                          'images/ads/SCN_0052_1_thumb.jpg',
#                          'images/ads/SCN_0052_2_thumb.jpg',
#                          'images/ads/SCN_0052_3_thumb.jpg',
#                          'images/ads/SCN_0052_4_thumb.jpg',
#                          'images/ads/SCN_0052_5_thumb.jpg'
#                        ]
# }
my $base_path = '/Users/justin/Code/myrtspostcards/content/cards/';

foreach my $o (@$ads) {
    my $new_file = $base_path . $o->{slug} . ".md";
    print STDERR "$new_file\n";
    open my $fh, '>', $new_file or die $!;
    print $fh Dumper($o);
}
