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

function rxsigs(inputs){
  var checkrx=inputs.rxcui
  var output = {}
  output.rxcui = inputs.rxcui
  output.total = totalrx
  output.sigs = []

  fdrxsigs.forEach(function(sig, index){
    var countrx=  fdrxfreqs[index]
    var ratiorx = (countrx/totalrx).toFixed(2)
    var out = {}
    out.sig=sig
    out.frequency = ratiorx
    if (ratiorx>0.05) {
      out.pattern = 'COMMON'
    }else {
      out.pattern = 'RARE'
    }
    output.sigs.push(out)

  })
  return JSON.stringify(output)
}
