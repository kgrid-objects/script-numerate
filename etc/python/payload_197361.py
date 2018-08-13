def rxcompare(incomingStrings):
     rxdata = incomingStrings["rxdata"]
     found = 0
     placeholder = 0
     ratiorx = 0
     checkrx = rxdata[0]
     rxnormrxcuiSCD = 197361
     medicationname = ['AMLODIPINE 5 MG TABLET']
     fdrxsigs = ['5 MG ONCE','5 MG ONCE DAILY','10 MG ONCE DAILY','2.5 MG ONCE DAILY','5 MG DAILY','5 MG 2 TIMES DAILY','2.5 MG 2 TIMES DAILY','5 MG AT BEDTIME','5 MG EVERY MORNING','5 MG EVERY EVENING','10 MG EVERY MORNING','2.5 MG ONCE','2.5-5 MG ONCE DAILY','2.5-5 MG DAILY PRN','2.5 MG EVERY EVENING','5 MG USER SPECIFIED','7.5 MG ONCE DAILY','5 MG EVERY 12 HOURS','5 MG DAILY PRN']
     fdrxfreqs = [61,678,16,15,2,23,2,11,5,3,1,3,1,1,1,1,1,1,1]
     agerangerx = [75,101]
     totalrx = 827
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