Property = require './Property'

A = 'A'.charCodeAt 0

class Range extends Property

  constructor: (range) ->
    super()
    switch typeof range
      when 'string'
        matches = range.match /^([^!]+)!([A-Z]+)(\d+):([A-Z]+)(\d+)$/
        throw new Error "Invalid range: #{range}" unless matches?
        [sheet, startCol, startRow, endCol, endRow] = matches[1..]
        @index =
          startRowIndex:      parseInt startRow - 1
          endRowIndex:        parseInt endRow
          startColumnIndex:   Range.letters2column startCol
          endColumnIndex:     Range.letters2column(endCol) + 1
        if Range.names?
          id = Range.names.get sheet
          @index.sheetId = id if id?
        @sheet = sheet
      when 'object'
        if range instanceof Range
          args = [arguments...]
          [startRow, startColumn, columns] = args[1..]
          # clone the object
          @[k] = v for own k, v of range when k isnt 'index'
          @index = Object.assign {}, range.index
          @index.startRowIndex = startRow if startRow?
          @index.startColumnIndex = startColumn if startColumn?
          @index.endColumnIndex = startColumn + columns if columns
        else # it's just an index
          @index = range
          if Range.sheets?
            @sheet = Range.sheets.get range.sheetId ? 0
          @sheet ?= 'Sheet1'
    @columns = @index.endColumnIndex - @index.startColumnIndex
    @rows    = @index.endRowIndex    - @index.startRowIndex

  @property 'range',
    enumerable: true
    get: ->
      startCol = Range.column2letters @index.startColumnIndex
      endCol   = Range.column2letters @index.endColumnIndex - 1
      startRow = @index.startRowIndex + 1
      endRow   = @index.endRowIndex
      "#{@sheet}!#{startCol}#{startRow}:#{endCol}#{endRow}"

  getBlankRanges: (data, how) ->
    switch how
      when 'COLUMNS'
        cols = data.length
        rows = (row.length for row in data)
        if cols is @columns and rows.every (len) => len is rows[0]
          # then we have a rectangle
          rows = rows[0]
          rowStart = @index.startRowIndex + rows
          if rowStart is @index.endRowIndex
            null
          else
            [ new Range @, @index.startRowIndex + rows ]
        else (
          for col in [0 ... cols]
            len = @index.startRowIndex + rows[col]
            new Range @, len, @index.startColumnIndex + col, 1
        )
      when 'ROWS'
        [ new Range @, @index.startRowIndex + data.length ]
      else
        throw new Error "Must pass either 'COLUMNS' or 'ROWS'"


  @sheetMap = (map) ->
    @sheets = map
    @names  = new Map [map...].reverse()

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
