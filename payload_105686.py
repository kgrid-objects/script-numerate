def rxcompare(incomingStrings):
     rxdata = incomingStrings["rxdata"]
     found = 0
     placeholder = 0
     ratiorx = 0
     checkrx = rxdata[0]
     rxnormrxcuiSCD = 105686
     medicationname = ['CYANOCOBALAMIN (VIT B-12) 500 MCG TABLET']
     fdrxsigs = ['500 MCG ONCE DAILY','1000 MCG 2 TIMES DAILY','1000 MCG ONCE DAILY','2000 MCG ONCE DAILY','1500 MCG ONCE DAILY','1000 MCG EVERY MORNING','1000 MCG Every MONDAY  WEDNESDAY  FRIDAY  and SUNDAY','250 MCG ONCE DAILY','2500 MCG EVERY MORNING','1000 MCG DAILY','250 MCG EVERY 7 DAYS','5000 MCG ONCE DAILY','1000 MCG EVERY OTHER DAY','2000 MCG 2 TIMES DAILY']
     fdrxfreqs = [72,5,203,7,2,1,1,2,1,1,1,1,2,2]
     agerangerx = [75,99]
     totalrx = 301
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