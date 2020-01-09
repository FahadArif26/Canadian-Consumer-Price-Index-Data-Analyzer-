#!/usr/bin/perl
#
#   Packages and modules
#
use strict;
use warnings;
use version;   our $VERSION = qv('5.16.0');   # This is the version of Perl to be used
use Text::CSV  1.32;   # We will be using the CSV module (version 1.32 or higher)
# to parse each line

#
#   Variables to be used
#
my $EMPTY = q{};
my $SPACE = q{ };
my $COMMA = q{,};

my $filename     = $EMPTY;
my @records;
my $record_count = -1;
my @date;
my @location;
my @value;
my @catagory;
my $csv          = Text::CSV->new({ sep_char => $COMMA });
my @ONHealth;
#
my $file = "processedCPIData.csv";#file name to write processed CPI data to

#
#   Check that you have the right number of parameters
#
$filename = "18100004.csv";#file name to read from
#
# #   Open the input file and load the contents into records array
open my $names_fh, '<:encoding(UTF-8)', $filename
or die "Unable to open names file: $filename\n";

@records = <$names_fh>;

close $names_fh or
die "Unable to close:\n";   # Close the input file

#
#   Parse each line and store the information in arrays
#   representing each field
#
#   Extract each field from each name record as delimited by a comma
#

foreach my $data_record ( @records ) {

  print $data_record;#print out records to show processing
  if ( $csv->parse($data_record) ) {
    my @master_fields = $csv->fields();

    $record_count++;
    $date[$record_count] = $master_fields[0];
    $location[$record_count]     = $master_fields[1];
    $catagory[$record_count]     = $master_fields[3];
    $value[$record_count]     = $master_fields[10];

  } else {
    warn "Line/record could not be parsed: $records[$record_count]\n";
  }
}


#   Open/create file to print out the cpi records
unless(open FILE, '>'.$file) {
  # Die with error message
  # if we can't open it.
  die "\nUnable to create $file\n";
}

#FUnction calls for each province for health care costs
process( 'Newfoundland and Labrador', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Prince Edward Island', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Nova Scotia', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'New Brunswick', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Quebec', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Ontario', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Manitoba', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Saskatchewan', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Alberta', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);
process( 'British Columbia', 'Health care', $record_count, \@date, \@location, \@catagory, \@value);

#FUnction calls for each province for education costs
process( 'Newfoundland and Labrador', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Prince Edward Island', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Nova Scotia', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'New Brunswick', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Quebec', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Ontario', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Manitoba', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Saskatchewan', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'Alberta', 'Education', $record_count, \@date, \@location, \@catagory, \@value);
process( 'British Columbia', 'Education', $record_count, \@date, \@location, \@catagory, \@value);

#FUnction calls for each province for men's clothing costs
process( 'Newfoundland and Labrador', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Prince Edward Island', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Nova Scotia', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'New Brunswick', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Quebec', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Ontario', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Manitoba', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Saskatchewan', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Alberta', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'British Columbia', "Men's clothing", $record_count, \@date, \@location, \@catagory, \@value);

#FUnction calls for each province for women's clothing costs
process( 'Newfoundland and Labrador', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Prince Edward Island', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Nova Scotia', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'New Brunswick', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Quebec', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Ontario', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Manitoba', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Saskatchewan', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Alberta', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);
process( 'British Columbia', "Women's clothing", $record_count, \@date, \@location, \@catagory, \@value);

#FUnction calls for each province for alchoholic beverages costs
process( 'Newfoundland and Labrador', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Prince Edward Island', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Nova Scotia', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'New Brunswick', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Quebec', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Ontario', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Manitoba', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Saskatchewan', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Alberta', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);
process( 'British Columbia', "Alcoholic beverages", $record_count, \@date, \@location, \@catagory, \@value);

#FUnction calls for each province for Cigarettes costs
process( 'Newfoundland and Labrador', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Prince Edward Island', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Nova Scotia', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'New Brunswick', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Quebec', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Ontario', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Manitoba', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Saskatchewan', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'Alberta', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);
process( 'British Columbia', "Cigarettes", $record_count, \@date, \@location, \@catagory, \@value);

# close the  writing records to.
close FILE;

#
#OPEN AND PROCESS CENSUS DATA
#
$filename = "98-401-X2016055_English_CSV_data.csv";
#open census data file
open my $census_fh, '<:encoding(UTF-8)', $filename
or die "Unable to open names file: $filename\n";

my @recordsCensus = <$census_fh>;

close $census_fh or
die "Unable to close:\n";   # Close the input file

$record_count = -1;
# Parse each line and store the information in arrays
# representing each field
#
# Extract each field from each name record as delimited by a comma
foreach my $census_record ( @recordsCensus ) {

  print $census_record;#print out records to show processing
  if ( $csv->parse($census_record) ) {
    my @master_fields = $csv->fields();

    $record_count++;
    $date[$record_count] = $master_fields[0];
    $location[$record_count]     = $master_fields[3];
    $catagory[$record_count]     = $master_fields[10];
    $value[$record_count]     = $master_fields[12];

  } else {
    warn "Line/record could not be parsed: $recordsCensus[$record_count]\n";
  }
}

#
#OPEN FILE TO WRITE CENSUS DATA TO
#
$file = "processedCensusData.csv";
unless(open FILE, '>'.$file) {
  # Die with error message
  # if we can't open it.
  die "\nUnable to create $file\n";
}

print FILE "Year,Location,Category,Population\n";#print out header names to file for data organization

#Sub routine calles to print record for each province to file for health care occupations
processCensus( 'Newfoundland and Labrador', 1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Prince Edward Island',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Nova Scotia',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'New Brunswick',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Quebec',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Ontario',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Manitoba',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Saskatchewan',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'Alberta',  1890, $record_count, \@date, \@location, \@catagory, \@value);
processCensus( 'British Columbia', 1890, $record_count, \@date, \@location, \@catagory, \@value);

#close file writing to
close FILE;

#Sub routine to process CPI data and write to the file
sub process{
  #parameters
  my( $province, $data, $record_count, $date_ref, $location_ref, $catagory_ref, $value_ref) = @_;

  #dereferencing arrays being sent in
  my @date = @{ $date_ref };
  my @location = @{ $location_ref };
  my @catagory = @{ $catagory_ref };
  my @value = @{ $value_ref };

  my $year = 1998;#year to start data collection from
  my $month = 1;
  my $cmpMonth;# = sprintf("%02d",$month);
  my $index = 0;
  my $temp;

  #cycle through records
  for my $j (0..$record_count){

    $cmpMonth = sprintf("%02d",$month);#correct format of month when need to compare

    #check if date is same as required one
    if($date[$j] eq $year.'-'.$cmpMonth){
      #check if province of record is same as required one from function call
      if($location[$j] eq $province){
        #check if category of record is same as required one from function call
        if($catagory[$j] eq $data){
          $temp += $value[$j];#sum up all costs for each month of the same year
          $month++;

          #if month is 13 means done for the current year
          if($month == 13){
            $temp = $temp/12;
            #write to file average cost for the year
            print FILE $year.','.$location[$j].','.$catagory[$j].','.$temp."\n";
            $month = 1;
            $year++;
            $temp = 0;
          }
          #if end year exit
          if($year == 2019){
            return;
          }
        }
      }
    }
  }#

}#function end

#Sub routine to process census data and write to the file
sub processCensus{
  #parameters
  my( $province, $data, $record_count, $date_ref, $location_ref, $catagory_ref, $value_ref) = @_;

  #dereference arrays being sent in
  my @date = @{ $date_ref };
  my @location = @{ $location_ref };
  my @catagory = @{ $catagory_ref };
  my @value = @{ $value_ref };

  #cycle through records
  for my $j (0..$record_count){

    print $location[$j].$catagory[$j]."\n";#print each to show processing

    #CHeck if location of current record is same as required one from function call
    if($location[$j] eq $province){
      #CHeck if category of current record is same as required one from function call
      if($catagory[$j] eq $data){
        #print out record to file
        print FILE $date[$j].','.$location[$j].",Health occupations".','.$value[$j]."\n";
      }
    }
  }

}#function end

#
#   End of Script
#
