#!/user/bin/perl

#
# THIS PROGRAM ADDS RXNORM Semantic Clinical Drug RXCUIs and Semantic Clinical Drug strings to existing data files
# 
# Using this program, the operator of the program gets help locating potential RXNORM RXCUI IDs for Semantic Clinical Drugs (SCDs) using RxNorm APIs HOWEVER, the operator
# manually selects the SCD to use for every product in an incoming drug file.   This program only partially automates SCD assignment to prescription data. 
#
# Version 0.1 of January 6, 2018
#
# Written By:  Allen Flynn
#

use JSON::Parse 'parse_json';
use JSON qw( decode_json );
use Data::Dumper;
use XML::Parser;

#Boot acknowledge
print "The SCD Adder Has Started... \n";
print "\n";

#RXNORM system check
system("curl","-H","Accept:application/json","https://rxnav.nlm.nih.gov/REST/version");
print "\n";

#OPEN existing data file as the "input file"
open my $idd, 'hpi1980STUDYDATA1.txt' or die("Could not open file.");

#RESET RENEW an "output" file called scdOutputFinished 
$now_string = localtime;    # Write the Local Time at the Top of this File Each Time it is Created 
open (my $fh1,'>','scdOutputFinished.csv');
print $fh1 $now_string . " \n";
close $fh1;

my $chosenSCD = 123;       # Placeholder. Default value = 123

#LOOP through file line by line
    $drugNameOld = "MEDICATION_NAME";  # Default value = MEDICATION_NAME permits skip of processing first line
    $firstLineFlag = 1;    # To process the first line differently from all others 
    foreach $line (<$idd>) {
            if ($firstLineFlag == 1) {
                 open (my $fh1,'>>','scdOutputFinished.csv');
                 print $fh1  "RXNORM_SCD" . "," . $line;
                 close $fh1;
                 $firstLineFlag = 0;
                 } # This conditional writes the first line of the input file to the output file
            @words = split(',',$line);  # CREATE ARRAY FROM INCOMING LINE FROM COMMA DELIMITED INPUT FILE
            $drugNameNew = $words[2];   # SEE THE INPUT FILES USED TO MAP THE ARRAY ELEMENTS TO SPECIFIC DATA ELEMENTS
            if ($drugNameNew ne $drugNameOld) {
              print "\n" . "This is what you're looking for: " . $words[2] . "\n";
              my @searchterms = split('/',$words[3]);    # THIS HANDLES COMPOUND DRUG NAMES BY ONLY USING THE FIRST NAME BEFORE /
              print "\n Search term used: " . $searchterms[0] . "\n";
              $url2 = "https://rxnav.nlm.nih.gov/REST/rxcui?name=" . $searchterms[0];
              print $url2 . "\n";
              my $result = `curl -H Accept:application/json -s $url2`;
              $result =~ s/\D//g;  #remove all but numeric digits from $result
              print $result . "\n"; 
              if ($result > 0) {
                   $url3 = "https://rxnav.nlm.nih.gov/REST/rxcui/". $result . "/related?tty=SCD";
                   my $SCDresult = `curl -H Accept:application/json  -s $url3`;
                   #print $SCDresult;
		   my $decoded = parse_json($SCDresult);
                   my @mega = [];
                   my $countz = 0;
                   my $countzer = 0;
                   my $check4content = $SCDresult =~ /conceptProperties/g;
                   #print "\n This is the Check For Content: " . $check4content . "\n";
                   if ($check4content ne "") {
                     for $kmega (keys %$decoded->{relatedGroup}->{conceptGroup}[0]->{conceptProperties}) {
                        my $cuigoodMega = $decoded->{relatedGroup}->{conceptGroup}[0]->{conceptProperties}[$countzer]->{rxcui};
                        my $namegoodMega = $decoded->{relatedGroup}->{conceptGroup}[0]->{conceptProperties}[$countzer]->{name};
                        @mega[$countz]=$countzer + 1;
                        @mega[$countz+1]=$cuigoodMega;
                        @mega[$countz+2]=$namegoodMega;
                        $countz = $countz + 3;
                        $countzer = $countzer + 1;
                      }                   
                     my $count2 = 0;   #USES DEPRECATED BUT FUNCTIONAL WAY TO MOVE THROUGH JSON HASH COMING FROM RXNORM
                     for $kc (keys %$decoded->{relatedGroup}->{conceptGroup}[0]->{conceptProperties}) {
                        my $cuigood2 = $decoded->{relatedGroup}->{conceptGroup}[0]->{conceptProperties}[$count2]->{rxcui};
                        my $namegood2 = $decoded->{relatedGroup}->{conceptGroup}[0]->{conceptProperties}[$count2]->{name};
                        print $count2 + 1 . " ";
                        print $cuigood2;
                        print "\t";
                        print $namegood2;
                        print "\n";
                        $count2 = $count2 + 1;
                      }
                      } else {
                        print "\n" . "NO SCD's FOUND!" . "\n";
                        }
                  print "\n" . "This is what you're looking for: " . $words[2] . "\n"; 
                  print "\n" . "Enter your choice: ";   #GET USERS CHOICE HERE 
                  $chosenSCD = <STDIN>;
                  chomp $chosenSCD;
                  print "\n" . "You chose: $chosenSCD";
                  open (my $fh1,'>>','scdOutputFinished.csv');   #WRITE THE FIRST LINE FOR A NEW SEMANTIC CLINICAL DRUG IN THE FILE
                  chomp $line;
                  print $fh1  $chosenSCD . "," . $line;
                  close $fh1;
                 } else {
                        print "\n" . "This is what you're looking for: " . $words[2] . "\n";
                        print "\n" . "PROBLEM WITH AUTO-LOOKUP! RESULT FOUND: " . $result . "\n";
                        print $url2 . "\n";
                        print $url3 . "\n";
                        print "\n" . "MANUAL SCD LOOKUP REQUIRED. Enter your choice: ";   #GET USERS CHOICE HERE
                        $chosenSCD = <STDIN>;
                        chomp $chosenSCD;
                        print "\n" . "You chose: $chosenSCD";
                        open (my $fh1,'>>','scdOutputFinished.csv');   #WRITE THE FIRST LINE FOR A NEW SEMANTIC CLINICAL DRUG IN THE FILE
                        chomp $line;
                        print $fh1  $chosenSCD . "," . $line;
                        close $fh1;
                   }
              } else {
                 open (my $fh1,'>>','scdOutputFinished.csv');    #WRITE THE 2nd-Nth LINES FOR THE SAME SEMANTIC CLINICAL DRUG IN THE FILES
                 chomp $line;
                 print $fh1  $chosenSCD . "," . $line;
                 close $fh1;
                 }
            $drugNameOld = $drugNameNew;
       }
close $idd;


#End of program acknowledged here
print "\n";
print "End.\n";


