#!/user/bin/perl

#
# THIS IS A SECOND TRIAL FOR USING PERL TO ENGAGE THE KGRID ACTIVATOR
#
#
#

use LWP::UserAgent;
use JSON::Parse 'parse_json';

print "Started ... \n";
print "\n";


#OPEN existing data file
open my $idd, 'rxcuiList' or die("Could not open file.");

my $ua = LWP::UserAgent->new;

my $counthits = 0;

#LOOP through file line by line
    foreach $line (<$idd>) {
        chomp $line;
        my $rxcuinow = $line;
        my $server_endpoint = "http://localhost:8080/knowledgeObject/ark:/coll/" . $rxcuinow . "/result";
        #print $server_endpoint . "\n";
        #
        #set header fields
        #
        my $req = HTTP::Request->new(POST => $server_endpoint);
        $req->header('content-type' => 'application/json');
        $req->header('accept' => 'application/json');
        #
        # add POST data to HTTP request body
        my $post_data = '{"rxdata":["1300 MG EVERY 6 HOURS"]}';
        $req->content($post_data);

        my $resp = $ua->request($req);
        if ($resp->is_success) {
           my $message = $resp->decoded_content;
           #print "Received reply: $message\n";
           my $decoded = parse_json($message);
           print "\n";
           print $decoded->{metadata}->{title} . "\n";
           print $decoded->{result} . "\n";
       }
       else {
           print "HTTP POST error code: ", $resp->code, "\n";
           print "HTTP POST error message: ", $resp->message, "\n";
      }
   $counthits = $counthits + 1;
   print $counthits . "\n";
   #sleep(1);  # PAUSE FOR 1 SECOND BETWEEN CYCLES OF THIS LOOP 
   } 
print "\n";
print "Finished! \n";
#end
