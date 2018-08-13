#!/user/bin/perl

#
# THIS PROGRAM counts and creates frequency tables for prescriptions by Semantic Clinical Drug (i.e., "type of product")
#

#Boot acknowledge
print "Rxcounter Has Started... \n";
print "\n";

#OPEN existing data file
open my $idd, 'TEST.txt' or die("Could not open file.");

#STARTING DECLARATIONS
$lc = 0;
@words = ();
$lowage = 0;
$highage = 0;
@fdrxsigs = ();
@fdrxfreqs = ();
$rxcount = 0;
$filenumber = -1;
$idHolder = "start";
$filescreated = 0;
$activelinecount = 0;
$medicationname = "";

#USER INTERACTIONS
print "Organization? ";
my $organization = <STDIN>;
chomp $organization;
print "\n";
print "Specific Location? ";
my $location = <STDIN>;
chomp $location;
print "\n";
print "Population? ";
my $population = <STDIN>;
chomp $population;
print "\n";
print "Data Set Name or ID? ";
my $datasetID = <STDIN>;
chomp $datasetID;
print "\n";
print "Data Set Start Date: (Year-Month-Day,e.g., 2016-01-01) ";
my $startDate = <STDIN>;
chomp $startDate;
print "\n";
print "Data Set End Date: (Year-Month-Day, e.g., 2016-12-31) ";
my $endDate = <STDIN>;
chomp $endDate;
print "\n";

my $path = "CFILES2";

#
#  This code accepts as input a TAB DELIMITED file with the following column headings 
#  AGE AT ENCOUNTER, MEDICATION_ID, MEDICATION_NAME, SIMPLE_GENERIC_NAME, STRENGTH, FORM, ROUTE, THERA_CLASS_NAME, PHARM_SUBCLASS_NAME, SYNTHETIC_SIG, 
#  MEDICATION ID is the UNIQUE ORGANIZING FIELD FOR EACH FILE GENERATED 
#
#
#
#


#LOOP through file line by line
    foreach $line (<$idd>) {
            chomp ($line);                                                                   #TAKE AWAY <CR>
            #print $line . "\n";
            if ( $lc > 1 ) {                                                                 #START WRITING FILES AFTER HEADER
               $filename = "$path/file" . "_" . $words[10];                                         #FILE WRITING 
               open (my $fh, '>', $filename) or die "Could not open file '$filename' $!";
               print $fh "medicationname = " . "['" . $medicationname . "']" . "\n";
               #print "medicationname = " . "['" . $medicationname . "']" . "\n";
               print $fh "fdrxsigs = " . "['" . join("','",@fdrxsigs) . "']" . "\n";
               print $fh "fdrxfreqs = " . "[" . join(',',@fdrxfreqs) . "]" . "\n";
               print $fh "agerangerx = " . "[" . $lowage . "," . $highage . "]" . "\n";
               print $fh "totalrx = " . $rxcount . "\n";
               print $fh "rxdatasettitle = " . "['" . $datasetID . "']" . "\n";
               print $fh "daterangerx = " . "['" . $startDate . "','" . $endDate . "']" . "\n";
               print $fh "rxorganization = " . "['" . $organization . "']" . "\n";
               print $fh "rxlocation = " . "['" . $location . "']" . "\n";
               print $fh "rxpopulation = " . "['" . $population . "']" . "\n";
               close $fh;
               }
            @words = split(/\t/,$line);                                                      #SPLIT LINE BY TABS
            #print $words[10];                                        
            if ( $lc > 0 ) {                                                                 #SKIP HEADER LINE
               if (($idHolder != $words[10]) && ($filescreated > 0)) {                       #2ND TO N FIRST LINES WHERE NEW MEDS ARE FOUND
                   print "\n 1st " . $words[2] ."\n";
                   @fdrxsigs = ();
		   @fdrxfreqs = ();
                   $fdrxsigs[0] = $words[9];
                   $fdrxfreqs[0] = 1;
                   $lowage = $words[0];
                   $highage = $words[0];
                   $rxcount = 1;
                   $words[2] =~ s/^"(.*)"$/$1/;
                   $medicationname = $words[2];
                   $activelinecount = 1;
               }
               if (($idHolder != $words[10]) && ($filescreated == 0)) {                       #1ST FIRST LINE WHERE NEW MED IS FOUND
                   print "\n first " . $words[2] . "\n";
                   @fdrxsigs = ();
                   @fdrxfreqs = ();
                   $fdrxsigs[0] = $words[9];
                   $fdrxfreqs[0] = 1;
                   $lowage = $words[0];
                   $highage = $words[0];
                   $rxcount = 1;
                   $words[2] =~ s/^"(.*)"$/$1/;
                   $medicationname = $words[2];
                   $filescreated = 1;
                   $activelinecount = 1;
               }
               if ($idHolder == $words[10]) {                                                #2ND TO N NON-FIRST LINES
                   #print "not";
                   $localcount = 0;
                   $found = 0;
                   foreach (@fdrxsigs) {
                      if ($words[9] eq $_) {
                         $fdrxfreqs[$localcount] = $fdrxfreqs[$localcount] + 1;
                         #print " " . ($fdrxfreqs[$localcount]) . " " . $words[9];
                         $found = 1;
                      }
                   $localcount = $localcount + 1;
                   }
                   if ($found == 0) {
                      push @fdrxsigs, $words[9];
                      push @fdrxfreqs, 1;
                      #print " " . ($fdrxfreqs[$localcount]) . " " . $words[9];
                   }
                   #print "\n";
                   if ($lowage >= $words[0]) {$lowage = $words[0]};
                   if ($highage <= $words[0]) {$highage = $words[0]};
                   $rxcount = $rxcount + 1;
                   $words[2] =~ s/^"(.*)"$/$1/;
                   $medicationname = $words[2];
                   $activelinecount = $activelinecount + 1;
               }
            $idHolder = $words[10];
            }
        $lc = $lc + 1;
        #print $lc;                   
     }

#WRITE THE FINAL FILE HERE AFTER THE FOR LOOP ENDS
$filename = "$path/file" . "_" . $words[10];
open (my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "medicationname = " . "['" . $medicationname . "']" . "\n";
#print "medicationname = " . "['" . $medicationname . "']" . "\n";
print $fh "fdrxsigs = " . "['" . join("','",@fdrxsigs) . "']" . "\n";
print $fh "fdrxfreqs = " . "[" . join(',',@fdrxfreqs) . "]" . "\n";
print $fh "agerangerx = " . "[" . $lowage . "," . $highage . "]" . "\n";
print $fh "totalrx = " . $rxcount . "\n";
print $fh "rxdatasettitle = " . "['" . $datasetID . "']" . "\n";
print $fh "daterangerx = " . "['" . $startDate . "','" . $endDate . "']" . "\n";
print $fh "rxorganization = " . "['" . $organization . "']" . "\n";
print $fh "rxlocation = " . "['" . $location . "']" . "\n";
print $fh "rxpopulation = " . "['" . $population . "']" . "\n";
#print $fh (@fdrxsigs);
#print $fh (@fdrxfreqs);
close $fh;

#CLOSE INPUT FILE
close $idd;

#End of program acknowledged here
print "\n";
print "End Rxcounter\n";
