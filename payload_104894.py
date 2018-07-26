def rxcompare(incomingStrings):
     rxdata = incomingStrings["rxdata"]
     found = 0
     placeholder = 0
     ratiorx = 0
     checkrx = rxdata[0]
     rxnormrxcuiSCD = 104894
     medicationname = ['ONDANSETRON 4 MG DISINTEGRATING TABLET']
     fdrxsigs = ['4 MG EVERY 6 HOURS PRN','4-8 MG EVERY 8 HOURS PRN','8 MG ONCE','8 MG EVERY 6 HOURS PRN','4 MG EVERY 4 HOURS PRN','4 MG ONCE PRN','4 MG EVERY 12 HOURS PRN','4 MG ONCE','8 MG EVERY 8 HOURS PRN','4 MG EVERY 8 HOURS PRN','8 MG ONCE PRN','4-8 MG EVERY 6 HOURS PRN','4 MG 2 TIMES DAILY','4 MG PRN','4 MG EVERY 6 TO 8 HOURS WHILE AWAKE','4-6 MG EVERY 6 HOURS PRN','4-8 MG EVERY 4 HOURS PRN','4 MG 3 TIMES DAILY BEFORE MEALS','4 MG DAILY PRN','4 MG EVERY 4 HOURS','4 MG EVERY 8 HOURS','4 MG 4 TIMES DAILY','4 MG EVERY 6 HOURS','4 MG 2 TIMES DAILY PRN','8 MG EVERY 8 HOURS','8 MG 2 TIMES DAILY','4 MG 2 TIMES DAILY BEFORE MEALS','8 MG 3 TIMES DAILY BEFORE MEALS','4-8 MG EVERY 8 HOURS','8 MG 3 TIMES DAILY','4 MG EVERY 12 HOURS','8 MG 3 TIMES DAILY PRN']
     fdrxfreqs = [186,168,4,4,46,5,1,52,13,50,25,8,1,2,2,1,4,6,1,1,1,2,10,2,1,1,2,1,1,2,1,1]
     agerangerx = [75,95]
     totalrx = 605
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