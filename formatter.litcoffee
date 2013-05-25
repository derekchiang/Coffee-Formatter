# Coffee-Formatter

## Introduction

CoffeeFormatter (abbreviated as CF) is a, guess what, formatter for CoffeeScript.  Let me know if you were actually expecting otherwise lol.

The code is written in Literate CoffeeScript.  Checkout Wikipedia for what "Literate Programming" means.

## Code

### Dependencies

CF relies on the following packages:

* `lazy` for reading files line by line.  An example is given [here](http://stackoverflow.com/questions/6156501/read-a-file-one-line-at-a-time-in-node-js).
* `fs` for file io.
* `optimist` for command line parsing.

Code:

    Lazy = require 'lazy'
    fs = require 'fs'

By default, we use a tab width of 2 and use spaces exclusively.  This is the style most widely used in the community.  For a detailed guide of CoffeeScript style, check out [this](https://github.com/polarmobile/coffeescript-style-guide).

    argv = (require 'optimist')
      .default('tab-width', 2)
      .default('use-space', true)
      .argv

### Constants

We define a set of constants, including:

Two-space operators.  These operators should have one space both before and after.

    TWO_SPACE_OPERATORS = ['=', '+=', '-=', '==', '<=', '>=',
                        '>', "<", '+', '-', '*', '/']

One-space operators.  They should have one space after.

    ONE_SPACE_OPERATORS = [':', '?', '']


### Helper Functions

Given a line and an index, the function determines whether or not the index is inside of a CoffeeScript string.

    notInString = (index, line) ->
      for c, i in line
        if c == "'" or c == '"'
          subLine = line.substr (i + 1)
          for cc, ii in subLine
            if cc == c
              if i <= index <= ii
                return true
              else
                return notInString (index - (ii + 1)), (line.substr (ii + 1))

      return false

`getExtension()` returns the extension of a filename, excluding the dot.

    getExtension = (filename) ->
      i = filename.lastIndexOf '.'
      return if i < 0 then '' else filename.substr (i+1)

`formatBinaryOperator()` takes in an operator and a line.  It assumes that the operator is an element of `BINARY_OPERATORS` and makes sure that there is one and only one space before and after the operator.  Before it inserts spaces, however, it makes sure that the operator in question is not part of a string.

This method is incomplete.

    formatTwoSpaceOperator = (operator, line) ->
      index = line.indexOf(operator)
      if notInString(index, line)
        if line[index - 1] != ' '
          1 + 1

This method shortens consecutive spaces into one single space.

    shortenSpaces = (line) ->
      prevChar = null
      newLine = ''
      for c, i in line
        unless notInString(i, line) and (c == ' ' == prevChar)
          newLine = newLine + c
        prevChar = c

      return newLine

### Body

The body of this module does the following:

1. Parse command line.
2. Read the files specified by the user.
3. Perform formatting.

We loop through `argv._`, which should be a list of filenames given by the user.

    for filename in argv._

Then we check if the extension is "coffee".  Literate CoffeeScript will also be supported at some point.

      if (getExtension filename) isnt 'coffee'
        console.log
        "#{filename} doesn't appear to be a CoffeeScript file. Skipping..."
        console.log "Use --force to format it anyway."

If the extension is "coffee", we proceed to the actual formatting.

Firstly, we read the file line by line:

      else
        file = ''

        new Lazy(fs.createReadStream filename, encoding: 'utf8')
          .lines
          .forEach (line) ->
            newLine = line

`newLine` is used to hold a processed line.  `file` is used to hold the processed file.

Now we add spaces before and after a binary operator, using the helper function:
            
            for operator in TWO_SPACE_OPERATORS
              newLine = formatTwoSpaceOperator operator, newLine

Do the same for single-space operators:

            for operator in ONE_SPACE_OPERATORS
              newLine = formatOneSpaceOperator operator, newLine

Shorten any consecutive spaces into a single space:

            newLine = shortenSpaces newLine
            file += newLine

After the `forEach` completes, we have a file that is formatted line by line.  However, a comprehensive formatter needs to consider the code in a block level.  Specifically:

* Indentation should be formatted according to the parameters specified by the user.

### Exports

    module.exports.shortenSpaces = shortenSpaces