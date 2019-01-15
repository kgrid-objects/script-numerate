var rxnormrxcuiSCD = 197311
var medicationname = ['ACYCLOVIR 400 MG TABLET']
var fdrxsigs = ['400 MG 2 TIMES DAILY','400 MG ONCE DAILY','400 MG 5 TIMES DAILY','400 MG EVERY 12 HOURS','400 MG 3 TIMES DAILY','800 MG ONCE DAILY']
var fdrxfreqs = [123,8,3,2,4,1]
var agerangerx = [75,92]
var totalrx = 141

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
