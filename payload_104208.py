def rxcompare(incomingStrings):
     rxdata = incomingStrings["rxdata"]
     found = 0
     placeholder = 0
     ratiorx = 0
     checkrx = rxdata[0]
     rxnormrxcuiSCD = 104208
     medicationname = ['DIGOXIN 250 MCG/ML INJECTION SOLUTION']
     fdrxsigs = ['250 MCG EVERY 2 HOURS PRN','250 MCG ONCE','125 MCG DAILY','100 MCG DAILY','250 MCG DAILY','500 MCG ONCE','125 MCG ONCE','100 MCG EVERY OTHER DAY','250 MCG EVERY 12 HOURS SCHEDULED','250 MCG EVERY 6 HOURS SCHEDULED','50 MCG ONCE','25 MCG EVERY 6 HOURS SCHEDULED','125 MCG EVERY 12 HOURS SCHEDULED','125 MCG EVERY 6 HOURS SCHEDULED','125 MCG EVERY OTHER DAY','500 MCG ONCE PRN','250 MCG EVERY 12 WEEKS','200 MCG DAILY','125 MCG EVERY 48 HOURS','500 MCG EVERY 12 HOURS SCHEDULED','150 MCG ONCE','250 MCG EVERY 6 HOURS','62.5 MCG EVERY 6 HOURS SCHEDULED']
     fdrxfreqs = [1,46,10,1,1,19,19,1,7,5,1,2,2,3,1,1,1,1,3,1,2,1,1]
     agerangerx = [75,91]
     totalrx = 130
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