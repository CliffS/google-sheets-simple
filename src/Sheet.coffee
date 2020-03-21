Google  = require('googleapis').google
Compute = Google.compute 'v1'
util = require 'util'
fs = require 'fs'

Range = require './Range'

Log = (items...) ->
  items = (
    for item in items
      util.inspect item,
        depth: null
        colors: true
  )
  console.log items...      # noqa

class Sheet

  constructor: (@id) ->
    @sheets = Google.sheets 'v4'

  ranges: new Map
  tabs:   new Map

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
      # pass the tabs to the static Range
      Range.sheetMap @tabs
      @ranges.set range.name, new Range range.range for range in spreadsheet.namedRanges
      spreadsheet

  save: (where, what, how = 'ROWS') ->      # or 'COLUMNS'
    unless how in ['ROWS', 'COLUMNS']
      throw new Error "'ROWS' or 'COLUMNS' are the only possible values"
    range = if where.indexOf('!') is -1 then @ranges.get where else new Range where
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
