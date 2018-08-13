def rxcompare(incomingStrings):
     rxdata = incomingStrings["rxdata"]
     found = 0
     placeholder = 0
     ratiorx = 0
     checkrx = rxdata[0]
     rxnormrxcuiSCD = 106346
     medicationname = ['MUPIROCIN 2 % TOPICAL OINTMENT']
     fdrxsigs = ['1 APPLICATION 2 TIMES DAILY','1 APPLICATION 3 TIMES DAILY','1 APPLICATION AT BEDTIME','1 APPLICATION ONCE','1 APPLICATION DAILY','2 TIMES DAILY','1 APPLICATION 2 TIMES DAILY PRN','1 APPLICATION EVERY MORNING','1 APPLICATION 4 TIMES DAILY','1 APPLICATION 3 TIMES DAILY PRN']
     fdrxfreqs = [61,12,2,16,5,1,1,1,1,2]
     agerangerx = [75,94]
     totalrx = 102
     rxdatasettitle = ['hpi1980GREATERTHAN50GOLDF']
     daterangerx = ['2016-01-01','2016-12-31']
     rxorganization = ['Michigan Medicine']
     rxlocation = ['University of Michigan Hospitals']
     rxpopulation = ['Inpatients of age 75 years or older']

     for targetsig in fdrxsigs:
        if checkrx == targetsig:
           countrx = fdrxfreqs[placeholder]
           ratiorx = round(float(countrx) / float(totalrx),2)
           found = 1
           break
        placeholder = placeholder + 1
     if found == 0:
        answerSentence = 'RESULT: UNPRECEDENTED ' + '--SUMMARY: ' + str(checkrx) + ' is unprecedented within ' + str(totalrx) + ' prescriptions on file ' + '---FREQUENCY = ' + str(ratiorx)
     elif found == 1 and ratiorx > 0.05:
        answerSentence = 'RESULT:COMMON ' + '--SUMMARY: ' + str(checkrx) + ' is common within ' + str(totalrx) + ' prescriptions on file '+ '---FREQUENCY= ' + str(ratiorx)
     else:
        answerSentence = 'RESULT:RARE ' + '--SUMMARY: ' + str(checkrx) + ' is rare within ' + str(totalrx) + ' presriptions on file ' + '---FREQUENCY = ' + str(ratiorx)
     return answerSentence