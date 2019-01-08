var rxnormrxcuiSCD = 197319
var medicationname = ['ALLOPURINOL 100 MG TABLET']
var fdrxsigs = ['100 MG ONCE DAILY','100 MG 2 TIMES DAILY','200 MG ONCE DAILY','300 MG ONCE DAILY','50 MG ONCE','250 MG ONCE DAILY','100 MG THREE TIMES WEEKLY M/W/F','50 MG ONCE DAILY','100 MG 3 TIMES DAILY','100 MG ONCE DAILY WITH LUNCH','200 MG EVERY OTHER DAY','200 MG ONCE','100 MG','100 MG EVERY OTHER DAY','100 MG EVERY EVENING','100 MG EVERY MORNING','100 MG AT BEDTIME','400 MG AT BEDTIME','100 MG Every MONDAY  WEDNESDAY  and FRIDAY','150 MG ONCE DAILY','10 MG DAILY','100 MG DAILY','100 MG EVERY 12 HOURS SCHEDULED']
var fdrxfreqs = [209,33,71,11,1,1,2,3,2,1,2,1,1,13,2,5,1,1,1,1,1,1,1]
var agerangerx = [75,100]
var totalrx = 365

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
