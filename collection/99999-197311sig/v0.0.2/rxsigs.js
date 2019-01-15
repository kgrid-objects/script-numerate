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
