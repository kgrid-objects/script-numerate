#!/user/bin/perl

#
# THIS PROGRAM "morphs" files from rxcounter2.pl into JSON metadata files to create workable file-specific JSON metadata files
#

#Boot acknowledge
print "metadatamaker Has Started... \n";
print "\n";

# NOTE: the PATH to the files is hard coded here and must be updated for other circumstances.  See @ files = below for path

@files = </Users/ajf/desktop/DissertationCode/PERL4SN/STEP4METADATAMAKERf/InputFilesFolder/*>;

# Declarations
my $path = "CMETADATAS";
my @filelines = ();
my $linecounter = 0;
my $rxcui = "";
my $protorxcui = "";
my $holder = "";
my $filecounter = 0;

# THE FOLLOWING LOOP READS AND ACTS ON FILES IN A FOLDER
foreach $file (@files) {
  $filecounter = $filecounter + 1;
  #print $file . "\n";
  $rxcui = substr $file,86; #STRIPS OFF ALL BUT RXCUI FROM FILE PATH AN FILE NAME
  print $filecounter . "\t" . $rxcui . "\t";
  #OPEN FILE
  open my $idd, $file or die("Could not open file.");   # OPENS EACH FILE TO GET ITS DATA LINE BY LINE AS THE FILE IS PROCESSED
      foreach $line (<$idd>) {
        chomp $line;
        $filelines[$linecounter] = $line;
        $linecounter = $linecounter + 1; 
       }
  $newfilename = "$path/" . $rxcui . "metadata.json";           #JSON METADATA PAYLOAD FILE WRITING
  open (my $fh, '>', $newfilename) or die "Could not open file '$newfilename' $!";

my $description = "One of a collection of prescription frequency knowledge objects with prescription data for inpatients 75 and older at UM Hospitals from 2016";
my $contributors = "DLHS DLKS Knowledge Grid Team 2016-18";
my $keywords = $rxcui . " RXNORM SCD";
$filelines[0] =~ /\'([^']+)\'/;
my $title = $rxcui . " For " . $1;
$filelines[7] =~ /\'([^']+)\'/;
my $owner = $1;

# BEGIN WRITING JSON METADATA TO EACH FILE HERE 

   print $fh "{\"payload\": {" . "\n";     #JSON FOR KNOWLEDGE OBJECTS
   print $fh "   \"content\": \"\"," . "\n";
   print $fh "   \"engineType\": \"Python\"," . "\n";
   print $fh "   \"functionName\": \"rxcompare\"}," . "\n";
   print $fh "\t" . "\"metadata\":" . "\n";
   print $fh "\t" . "{\"title\":\"" . $title . "\"," . "\n";
   print $fh "\t\t" . "\"owner\":\"" . $owner . "\"," . "\n";
   print $fh "\t\t" . "\"description\":\"" . $description  . "\"," . "\n";
   print $fh "\t\t" . "\"contributors\":\"" . $contributors  . "\"," . "\n";
   print $fh "\t\t" . "\"keywords\":\"" . $keywords  . "\"," . "\n";
   print $fh "\t\t" . "\"published\":false," . "\n";
   print $fh "\t\t" . "\"lastModified\":1515942979000," . "\n";
   print $fh "\t\t" . "\"createdOn\":1515942979000," . "\n";
   print $fh "\t\t" . "\"objectType\":null," . "\n";
   print $fh "\t\t" . "\"citations\":[]," . "\n";
   print $fh "\t\t" . "\"license\":" . "\n";
   print $fh "\t\t\t" . "{\"licenseName\":\"\"," . "\n";
   print $fh "\t\t\t" . "\"licenseLink\":\"null\"}" . "\n";
   print $fh "\t" . "}" . "\n";
   print $fh "}" . "\n";

# END WRITING JSON LINES TO FILE

  close $fh;
  print $filelines[0] . "\n";
  close $idd;
  $linecounter = 0;
  }

#End of program acknowledged here
print "\n";
print "End metadatamaker\n";

