var rewire = require('rewire');

//Get load in the js
var javascript = rewire('../collection/99999-104208/v0.0.2/rxcompare.js');

//Load in the function
var rxcompare = javascript.__get__("rxcompare");

// noinspection BadExpressionStatementJS
test('positive numbers', () => {
  expect( rxcompare({"rxdata": "100 MCG DAILY"})).toBe("RESULT:RARE --SUMMARY: 100 MCG DAILY is rare within 130 presriptions on file ---FREQUENCY = 0.01");
});
