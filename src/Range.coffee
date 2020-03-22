Property = require './Property'

A = 'A'.charCodeAt 0

class Range extends Property

  constructor: (range, tabs) ->
    super()
    switch typeof range
      when 'string'
        matches = range.match /^([^!]+)!([A-Z]+)(\d+):([A-Z]+)(\d+)$/
        unless matches?
          named = ranges.get range
          throw new Error "Invalid range: #{range}" unless named?
        [sheet, startCol, startRow, endCol, endRow] = matches[1..]
        @gridRange =
          startRowIndex:      parseInt startRow - 1
          endRowIndex:        parseInt endRow
          startColumnIndex:   Range.letters2column startCol
          endColumnIndex:     Range.letters2column(endCol) + 1
        id = k for [k, v] from tabs when v is sheet
        @gridRange.sheetId = id if id?
        @sheet = sheet
      when 'object'
        if range instanceof Range   # should only happen internally
          args = [arguments...]
          [startRow, startColumn, columns] = args[1..]
          # clone the object
          @[k] = v for own k, v of range when k isnt 'gridRange'
          @gridRange = Object.assign {}, range.gridRange
          @gridRange.startRowIndex = startRow if startRow?
          @gridRange.startColumnIndex = startColumn if startColumn?
          @gridRange.endColumnIndex = startColumn + columns if columns
        else # it's just a gridRange
          @gridRange = range
          @sheet = tabs.get range.sheetId ? 0
    @columns = @gridRange.endColumnIndex - @gridRange.startColumnIndex
    @rows    = @gridRange.endRowIndex    - @gridRange.startRowIndex
    throw new Error "Invalid range: #{range}" if @columns < 1 or @rows < 1

  @property 'range',
    enumerable: true
    get: ->
      startCol = Range.column2letters @gridRange.startColumnIndex
      endCol   = Range.column2letters @gridRange.endColumnIndex - 1
      startRow = @gridRange.startRowIndex + 1
      endRow   = @gridRange.endRowIndex
      "#{@sheet}!#{startCol}#{startRow}:#{endCol}#{endRow}"

  getBlankRanges: (data, how) ->
    switch how
      when 'COLUMNS'
        cols = data.length
        rows = (row.length for row in data)
        if cols is @columns and rows.every (len) => len is rows[0]
          # then we have a rectangle
          rows = rows[0]
          rowStart = @gridRange.startRowIndex + rows
          if rowStart is @gridRange.endRowIndex
            null
          else
            [ new Range @, @gridRange.startRowIndex + rows ]
        else (
          for col in [0 ... cols]
            len = @gridRange.startRowIndex + rows[col]
            new Range @, len, @gridRange.startColumnIndex + col, 1
        )
      when 'ROWS'
        [ new Range @, @gridRange.startRowIndex + data.length ]
      else
        throw new Error "Must pass either 'COLUMNS' or 'ROWS'"

  @column2letters: (index) ->
    throw new Error "Invalid column: #{index}" unless "#{index}".match /^\d+$/
    first = index // 26
    second = index % 26
    first = if first then String.fromCharCode A + first - 1 else ''
    second = String.fromCharCode A + second
    first + second

  @letters2column: (letters) ->
    throw new Error "Invalid column: #{letters}" unless letters.match /^[A-Z]{1,2}$/
    if letters.length is 2
      first = letters.charCodeAt(0) - A + 1
      second = letters.charCodeAt(1) - A
    else
      first = 0
      second = letters.charCodeAt(0) - A
    first * 26 + second


module.exports = Range
