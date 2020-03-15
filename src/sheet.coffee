Google  = require('googleapis').google
Compute = Google.compute 'v1'
util = require 'util'
fs = require 'fs'

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

  range2A1: (range) ->
    A = 'A'.charCodeAt 0
    A1 = "#{String.fromCharCode A + range.startColumnIndex}\
          #{range.startRowIndex + 1}:\
          #{String.fromCharCode A + range.endColumnIndex - 1}\
          #{range.endRowIndex}"
    sheet = @tabs.get range.sheetId ? 0
    sheet + '!' + A1

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
      @ranges.set range.name, @range2A1 range.range for range in spreadsheet.namedRanges
      spreadsheet

  save: (where, what, how = 'ROWS') ->      # or 'COLUMNS'
    where = @ranges.get where if where.indexOf('!') is -1
    [..., start, end] = where.match /(\d+):[A-Z]+(\d+)$/
    start = parseInt start
    end = parseInt end
    clearfrom = what.length + start
    clear = if clearfrom <= end then where.replace /\d+(?=:)/, clearfrom
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
        if clear?
          @sheets.spreadsheets.values.clear
            auth: @auth
            spreadsheetId: @id
            range: clear
    ]
    .then =>
      @

  get: (where, how = 'ROWS') ->
    where = @ranges.get where if where.indexOf('!') is -1
    new Promise (resolve, reject) =>
      @sheets.spreadsheets.values.get
        auth: @auth
        spreadsheetId: @id
        range: where
        majorDimension: how
        valueRenderOption: 'UNFORMATTED_VALUE'
      , (err, response) ->
        return reject err if err
        resolve response.data.values

  append: (where, what, how = 'ROWS') ->
    where = @ranges.get where if where.indexOf('!') is -1
    new Promise (resolve, reject) =>
      @sheets.spreadsheets.values.append
        auth: @auth
        spreadsheetId: @id
        range: where
        valueInputOption: 'USER_ENTERED'
        insertDataOption: 'INSERT_ROWS'
        resource:
          majorDimension: how
          values: what
      , (err, response) ->
        return reject err if err
        resolve response



module.exports = Sheet
