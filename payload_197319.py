def rxcompare(incomingStrings):
     rxdata = incomingStrings["rxdata"]
     found = 0
     placeholder = 0
     ratiorx = 0
     checkrx = rxdata[0]
     rxnormrxcuiSCD = 197319
     medicationname = ['ALLOPURINOL 100 MG TABLET']
     fdrxsigs = ['100 MG ONCE DAILY','100 MG 2 TIMES DAILY','200 MG ONCE DAILY','300 MG ONCE DAILY','50 MG ONCE','250 MG ONCE DAILY','100 MG THREE TIMES WEEKLY M/W/F','50 MG ONCE DAILY','100 MG 3 TIMES DAILY','100 MG ONCE DAILY WITH LUNCH','200 MG EVERY OTHER DAY','200 MG ONCE','100 MG','100 MG EVERY OTHER DAY','100 MG EVERY EVENING','100 MG EVERY MORNING','100 MG AT BEDTIME','400 MG AT BEDTIME','100 MG Every MONDAY  WEDNESDAY  and FRIDAY','150 MG ONCE DAILY','10 MG DAILY','100 MG DAILY','100 MG EVERY 12 HOURS SCHEDULED']
     fdrxfreqs = [209,33,71,11,1,1,2,3,2,1,2,1,1,13,2,5,1,1,1,1,1,1,1]
     agerangerx = [75,100]
     totalrx = 365
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