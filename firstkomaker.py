#
# STARTED WITH:
# KGrid Team Authoring/Executing Knowledge Objects Tool: Knowledge Object Generator
# Created January 31, 2017
# Takes in metadata (json), input rdf (xml), output rdf (xml), and payload (.py) files
# Uses the metadata (json) as the backbone, adding input, output, and payload, and outputting the knowledge object json file
#
#
# Extended by A. Flynn Jan 2018 to process multiple files
#
#
#

import os
import re
import json

#given inputs
def build(metadataFile,inputFile,outputFile,payloadFile,KOFile):
	# open & read files
	try:
		in_file_metadata = open(metadataFile).read()
		in_file_payload = open(payloadFile).read()
		in_file_input = open(inputFile).read()
		in_file_output = open(outputFile).read()
	except IOError:
		print "No such file or directory"
		return None

	# loading in files as json
	try:
		backbone = json.loads(in_file_metadata)
		backbone["inputMessage"] = in_file_input
		backbone["outputMessage"] = in_file_output
		backbone["payload"]["content"] = in_file_payload

	except ValueError as e:
		print ('invalid json: %s' % e)
		return None

	# dump result into new files
        fpath = path3 + "/" + KOFile
	with open(fpath, 'w') as outfile:
	    output = json.dump(backbone, outfile)
	return "*****DONE*****"


# Ask for inputs
def commandInput():
        metadataFile = raw_input("Enter Metadata File: ")
        #inputFile = raw_input("Enter Input File: ")
        #outputFile = raw_input("Enter Output File: ")
        payloadFile = raw_input("Enter Payload File: ")
        KOFile = raw_input("Knowledge Object Output File: ")

        output = build(metadataFile,inputFile,outputFile,payloadFile,KOFile)
        print("Made It")
        return output

#commandInput()

path1 = '/Users/ajf/desktop/DissertationCode/PERL4SN/STEP5KOMAKERf/iCMETADATAS'
path2 = '/Users/ajf/desktop/DissertationCode/PERL4SN/STEP5KOMAKERf/iCPAYLOADS'
path3 = '/Users/ajf/desktop/DissertationCode/PERL4SN/STEP5KOMAKERf/nKOS'

for fn in os.listdir(path1):
     #if os.path.isfile(fn):
        #print (fn)
        rxcui = map(int,re.findall('\d+',fn))
        #print (rxcui)
        if rxcui:
           #print (rxcui[0])
           for fn2 in os.listdir(path2):
               #if os.path.isfile(fn2):
                   rxcui2 = map(int,re.findall('\d+',fn2))
                   if rxcui2[0] == 1987647:
                      if rxcui == rxcui2: 
                           print ("Got it")
                           print (rxcui2[0])
                           print fn,fn2
                           koname = 'coll-' + str(rxcui2[0])
                           metadatafilename = path1 + "/" + fn
                           payloadfilename = path2 + "/" + fn2
                           print koname
                           print metadatafilename
                           print payloadfilename
                           build(metadatafilename,"input.xml","output.xml",payloadfilename,koname)
                           rxcui = 0
                           rxcui2 = 0 
