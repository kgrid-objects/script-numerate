var rxnormrxcuiSCD = 104208
var medicationname = ['DIGOXIN 250 MCG/ML INJECTION SOLUTION']
var fdrxsigs = ['250 MCG EVERY 2 HOURS PRN','250 MCG ONCE','125 MCG DAILY','100 MCG DAILY','250 MCG DAILY','500 MCG ONCE','125 MCG ONCE','100 MCG EVERY OTHER DAY','250 MCG EVERY 12 HOURS SCHEDULED','250 MCG EVERY 6 HOURS SCHEDULED','50 MCG ONCE','25 MCG EVERY 6 HOURS SCHEDULED','125 MCG EVERY 12 HOURS SCHEDULED','125 MCG EVERY 6 HOURS SCHEDULED','125 MCG EVERY OTHER DAY','500 MCG ONCE PRN','250 MCG EVERY 12 WEEKS','200 MCG DAILY','125 MCG EVERY 48 HOURS','500 MCG EVERY 12 HOURS SCHEDULED','150 MCG ONCE','250 MCG EVERY 6 HOURS','62.5 MCG EVERY 6 HOURS SCHEDULED']
var fdrxfreqs = [1,46,10,1,1,19,19,1,7,5,1,2,2,3,1,1,1,1,3,1,2,1,1]
var agerangerx = [75,91]
var totalrx = 130

var rxdatasettitle = ['hpi1980GREATERTHAN50GOLDF']
var daterangerx = ['2016-01-01','2016-12-31']
var rxorganization = ['Michigan Medicine']
var rxlocation = ['University of Michigan Hospitals']
var rxpopulation = ['Inpatients of age 75 years or older']

function rxcompare(inputs){
  var checkrx=inputs.rxdata
  var sigindex = fdrxsigs.indexOf(checkrx)
  var answerSentence = ""
  if (sigindex==-1) {
    answerSentence = 'RESULT: UNPRECEDENTED ' + '--SUMMARY: ' + checkrx + ' is unprecedented within ' + totalrx + ' prescriptions on file ' + '---FREQUENCY = 0'
  } else {
    var countrx=  fdrxfreqs[sigindex]
    ratiorx = (countrx/totalrx).toFixed(2)
    if (ratiorx>0.05) {
      answerSentence = 'RESULT:COMMON ' + '--SUMMARY: ' + checkrx + ' is common within ' + totalrx + ' prescriptions on file '+ '---FREQUENCY= ' + ratiorx
    }else {
      answerSentence = 'RESULT:RARE ' + '--SUMMARY: ' + checkrx + ' is rare within ' + totalrx + ' presriptions on file ' + '---FREQUENCY = ' + ratiorx
    }
  }
  return answerSentence
}
