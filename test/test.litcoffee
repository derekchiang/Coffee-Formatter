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

