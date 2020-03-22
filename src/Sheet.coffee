Google  = require('googleapis').google
Compute = Google.compute 'v1'
util = require 'util'
fs = require 'fs'

Property = require './Property'
Range = require './Range'
Coordinate = require './Coordinate'
RequestFactory = require './RequestFactory'

Log = (items...) ->
  items = (
    for item in items
      util.inspect item,
        depth: null
        colors: true
  )
  console.log items...      # noqa

class Sheet extends Property

  constructor: (@id) ->
    super()
    @sheets = Google.sheets 'v4'

  ranges: new Map
  tabs:   new Map

  getRange: (range) ->
    if @ranges.has range
      @ranges.get range
    else
      new Range range, @tabs

  getCoordinate: (loc) ->
    new Coordinate loc, @tabs

  @property 'Request',
    get: ->
      new RequestFactory @, @tabs, @ranges

  initialize: ->
    initialise()

  initialise: ->
    auth = new Google.auth.GoogleAuth
      scopes: [
        'https://www.googleapis.com/auth/spreadsheets'
      ]
    Promise.all [
      auth.getClient()
      auth.getProjectId()
    ]
    .then (results) =>
      [ @auth, project ] = results
      @sheets.spreadsheets.get
        auth: @auth
        spreadsheetId: @id
        ranges: []
    .then (result) =>
      spreadsheet = result.data
      @tabs.set sheet.properties.sheetId, sheet.properties.title for sheet in spreadsheet.sheets
      console.log spreadsheet.namedRanges
      for range in spreadsheet.namedRanges
        current = @getRange range.range
        current.id = range.namedRangeId
        @ranges.set range.name, current
      spreadsheet

  save: (where, what, how = 'ROWS') ->      # or 'COLUMNS'
    unless how in ['ROWS', 'COLUMNS']
      throw new Error "'ROWS' or 'COLUMNS' are the only possible values"
    range = if where.indexOf('!') is -1 then @ranges.get where else @getRange where
    where = range.range
    blank = range.getBlankRanges what, how
    Promise.all [
      @sheets.spreadsheets.values.update
        auth: @auth
        spreadsheetId: @id
        range: where
        valueInputOption: 'USER_ENTERED'
        resource:
          majorDimension: how
          values: what
    ,
      Promise.resolve()
      .then =>
        if blank?
          @sheets.spreadsheets.values.batchClear
            auth: @auth
            spreadsheetId: @id
            ranges: (block.range for block in blank)
    ]
    .then (responses) =>
      responses[0].data

  get: (where, how = 'ROWS') ->
    unless how in ['ROWS', 'COLUMNS']
      throw new Error "'ROWS' or 'COLUMNS' are the only possible values"
    where = @ranges.get(where).range if where.indexOf('!') is -1
    @sheets.spreadsheets.values.get
      auth: @auth
      spreadsheetId: @id
      range: where
      majorDimension: how
      valueRenderOption: 'UNFORMATTED_VALUE'
    .then (response) =>
      response.data.values

  clear: (where) ->
    where = @ranges.get(where).range if where.indexOf('!') is -1
    @sheets.spreadsheets.values.clear
      auth: @auth
      spreadsheetId: @id
      range: where
    .then (response) =>
      if response.data.error then throw response.data.error
      response.data


  append: (where, what, how = 'ROWS') ->
    unless how in ['ROWS', 'COLUMNS']
      throw new Error "'ROWS' or 'COLUMNS' are the only possible values"
    where = @ranges.get(where).range if where.indexOf('!') is -1
    @sheets.spreadsheets.values.append
      auth: @auth
      spreadsheetId: @id
      range: where
      valueInputOption: 'USER_ENTERED'
      insertDataOption: 'INSERT_ROWS'
      resource:
        majorDimension: how
        values: what
    .then (response) =>
      if response.data.error then throw response.data.error
      response.data




module.exports = Sheet
