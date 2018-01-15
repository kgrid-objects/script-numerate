#!/user/bin/perl

#
# THIS PROGRAM "wraps" files from rxcounter2.pl in additional python code to create workable defined functions that can be used as Knowledge Object payloads
#

#Boot acknowledge
print "payloadmaker Has Started... \n";
print "\n";

# NOTE: the PATH to the files is hard coded here and must be updated for other circumstances.  See @ files = below for path

@files = </Users/ajf/desktop/DissertationCode/PERL4SN/STEP3PAYLOADMAKERf/InputFilesFolder/*>;

# Declarations
my $path = "CPAYLOADS";
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
  $rxcui = substr $file,85;
  print $filecounter . "\t" . $rxcui . "\t";
  #OPEN FILE
  open my $idd, $file or die("Could not open file.");   # OPENS EACH FILE TO GET ITS DATA LINE BY LINE AS THE FILE IS PROCESSED
      foreach $line (<$idd>) {
        chomp $line;
        $filelines[$linecounter] = $line;
        $linecounter = $linecounter + 1; 
       }
  $newfilename = "$path/payload" . "_" . $rxcui . ".py";           #PYTHON PAYLOAD FILE WRITING
  open (my $fh, '>', $newfilename) or die "Could not open file '$newfilename' $!";

# BEGIN WRITING PYTHON CODE TO EACH FILE HERE 

   print $fh "def rxcompare(incomingStrings):" . "\n";     #DEFINES PYTHON SUBROUTINE CALLED RXCOMPARE
   print $fh "     rxdata = incomingStrings[\"rxdata\"]" . "\n";
   print $fh "     found = 0" . "\n";
   print $fh "     placeholder = 0" . "\n";
   print $fh "     ratiorx = 0" . "\n";
   print $fh "     checkrx = rxdata[0]" . "\n";
   print $fh "     rxnormrxcuiSCD = " . $rxcui . "\n";

   #THE FOLLOWING LINES WRITE DATA FROM INCOMING FILES MADE BY RXCOUNTER2.PL  IN PART TO COMPLETE A PYTHON SUBROUTINE CALLED RXCOMPARE 
   print $fh "     " . $filelines[0] . "\n";   #WRITES MEDICATION NAME LINE
   print $fh "     " . $filelines[1] . "\n";   #WRITES SIGS LINE (A PYTHON ARRAY)
   print $fh "     " . $filelines[2] . "\n";   #WRITES FREQUENCIES PER SIG LINE (A PYTHON ARRAY)
   print $fh "     " . $filelines[3] . "\n";   #WRITES AGE RANGE FOR DATA LINE (A PYTHON ARRAY)
   print $fh "     " . $filelines[4] . "\n";   #WRITES THE TOTAL NUMBER OF PRESCRIPTIONS COMPRISING THE ANALYZED DATA SET FOR ONE PRESCRIPTION ITEM (DRUG PRODUCT, RXNORM SCD)
   print $fh "     " . $filelines[5] . "\n";   #WRITES THE DATA SET TITLE 
   print $fh "     " . $filelines[6] . "\n";   #WRITES THE DATE SET DATE RANGE (A PYTHON ARRAY)
   print $fh "     " . $filelines[7] . "\n";   #WRITES THE ORGANIZATION NAME
   print $fh "     " . $filelines[8] . "\n";   #WRITES THE LOCATION OR SCOPE OR PLACE WITHIN AN ORGANZATION FROM WHICH THE DATA CAME
   print $fh "     " . $filelines[9] . "\n";   #WRITES THE POPULATION DESCRIPTION 
   print $fh "\n";     

   #THE FOLLOWING LINES PROVIDE THE LOGIC FOR THE PYTHON SUBROUTINE RXCOMPARE 
   print $fh "     for targetsig in fdrxsigs:" . "\n";
   print $fh "        if checkrx == targetsig:" . "\n";
   print $fh "           countrx = fdrxfreqs[placeholder]" . "\n";
   print $fh "           ratiorx = round(float(countrx) / float(totalrx),2)" . "\n";
   print $fh "           found = 1" . "\n";
   print $fh "           break" . "\n";
   print $fh "        placeholder = placeholder + 1" . "\n";
   print $fh "     if found == 0:" . "\n";
   print $fh "        answerSentence = 'RESULT: UNPRECEDENTED ' + '--SUMMMARY: ' + str(checkrx) + ' is unprecedented within ' + str(totalrx) + ' prescriptions on file ' + '---FREQUENCY = ' + str(ratiorx)" . "\n";
   print $fh "     elif found == 1 and ratiorx > 0.1:" . "\n";
   print $fh "        answerSentence = 'RESULT:COMMON ' + '--SUMMARY: ' + str(checkrx) + ' is common within ' + str(totalrx) + ' prescriptions on file '+ '---FREQUENCY= ' + str(ratiorx)" . "\n";
   print $fh "     else:" . "\n";
   print $fh "        answerSentence = 'RESULT:RARE ' + '--SUMMARY: ' + str(checkrx) + ' is rare within ' + str(totalrx) + ' presriptions on file ' + '---FREQUENCY = ' + str(ratiorx)" . "\n";
   print $fh "     return answerSentence";  

# END WRITING PYTHON CODE TO FILE

  close $fh;
  print $filelines[0] . "\n";
  close $idd;
  $linecounter = 0;
  }

#End of program acknowledged here
print "\n";
print "End payloadmaker\n";

