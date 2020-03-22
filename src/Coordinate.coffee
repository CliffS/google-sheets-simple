# A coordinate is a single grid square such as A1
#
Property = require './Property'
Range = require './Range'

A = 'A'.charCodeAt 0

class Coordinate extends Property

  constructor: (loc, tabs) ->
    super()
    matches = loc.match /^([^!]+)!([A-Z]+)(\d+)/
    unless matches?
      throw new Error "Invalid coordinate: #{loc}"
    [sheet, col, row] = matches[1..]
    @gridCoordinate =
      rowIndex: parseInt row - 1
      columnIndex: Range.letters2column col
    id = k for [k, v] from tabs when v is sheet
    @gridCoordinate.sheetId = id if id?
    @sheet = sheet

  @property 'loc',
    enumerable: true
    get: ->
      col = Range.column2letters @gridCoordinate.columnIndex
      row = @gridCoordinate.rowIndex + 1
      "#{@sheet}!#{col}#{row}"


module.exports = Coordinate
