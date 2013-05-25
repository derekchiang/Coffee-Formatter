# Test

## Foreword

The test suite runs on top of [mocha](https://github.com/visionmedia/mocha/).

To run the test suite:

1. Install mocha.
2. run `mocha` in the base directory.

## Code

### Dependencies

    formatter = require '../formatter'
    assert = require 'assert'

### Body

    describe 'formatter', ->
      describe '#shortenSpaces()', ->
        it 'should shorten all consecutive spaces into one', ->
          originalLine = 'hello   derek how is  it going?'
          formattedLine = formatter.shortenSpaces originalLine
          assert.strictEqual 'hello derek how is it going?',
            formattedLine

        it 'should work with strings', ->
          originalLine = 'for c, i in "Hello  World!"'
          formattedLine = formatter.shortenSpaces originalLine
          assert.strictEqual 'for c, i in "Hello  World!"',
            formattedLine

      describe '#formatTwoSpaceOperator()', ->
        it 'should make it so that there is only
          one space before and after a binary operator', ->
          originalLine = 'k = 1+1-  2>=3<=  4>5   <6'
          formattedLine = formatter.formatTwoSpaceOperator originalLine
          assert.strictEqual 'k = 1 + 1 - 2 >= 3 <= 4 > 5 < 6',
            formattedLine

