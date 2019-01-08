var rxnormrxcuiSCD = 106346
var medicationname = ['MUPIROCIN 2 % TOPICAL OINTMENT']
var fdrxsigs = ['1 APPLICATION 2 TIMES DAILY','1 APPLICATION 3 TIMES DAILY','1 APPLICATION AT BEDTIME','1 APPLICATION ONCE','1 APPLICATION DAILY','2 TIMES DAILY','1 APPLICATION 2 TIMES DAILY PRN','1 APPLICATION EVERY MORNING','1 APPLICATION 4 TIMES DAILY','1 APPLICATION 3 TIMES DAILY PRN']
var fdrxfreqs = [61,12,2,16,5,1,1,1,1,2]
var agerangerx = [75,94]
var totalrx = 102

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
