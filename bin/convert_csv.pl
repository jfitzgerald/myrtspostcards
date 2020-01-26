#!/usr/bin/perl
#--------------------- Perl Packages --------------------
use strict;
use warnings;
use Data::Dumper;
# Dumper setting to output JSON
$Data::Dumper::Terse = 1;
$Data::Dumper::Useqq = 1;
$Data::Dumper::Sortkeys = 1;
$Data::Dumper::Pair = ' : ';
use JSON::Tiny qw(encode_json);
use Text::CSV;

#-------------------- Globaling Variables --------------------
my $input_file = $ARGV[0] or die "Need to give 1st argument as input.CSV file on the command line\n";
my $output_file = $ARGV[1] or die "Need to give 2nd argument as output.JSON file on the command line\n";
my $file = $input_file;
my $csv = Text::CSV->new ({
  binary    => 1,
  auto_diag => 1,
  sep_char  => ','    # not really needed as this is the default
});
 
#--------------------- Reading CSV --------------------------
my $sum = 0;
my @headers; 
my @rows; 
my $flag_header = 1;
open(my $data, '<:encoding(utf8)', $file) or die "Could not open '$file' $!\n";
while (my $fields = $csv->getline( $data )) {
  #$sum += $fields->[2];
  my @coloumns =();
  if($flag_header == 1){
  foreach(@{ $fields }) {
        my $new = $_;
        push(@headers, $new);
      }
     
  }
  else{
    foreach(@{ $fields }) {
      my $new = $_;
      push(@coloumns, $new);
    }

    my $obj = {};
    for my $iteration (0..$#coloumns){
      my $key  = $headers[$iteration];
      my $data = $coloumns[$iteration];
      $obj->{$key} = $data;
    }
    push @rows, $obj;
  }
  if($flag_header>1){
    #my $json = encode_json $obj;
    #print("$json\n");
  }
  
  $flag_header +=1;
}
close $data;
print("\nTotal rows converted : $flag_header\n");

my $file_location = $output_file;
open my $o_file, '>', $file_location or die $!;
print $o_file Dumper(\@rows);
close $o_file;
