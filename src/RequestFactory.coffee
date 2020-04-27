Request = require './Request'

class RequestFactory

  constructor: (@sheet, @tabs, @ranges) ->          # noqa

  updateSpreadsheetProperties: (properties, fields = '*') ->
    new Request 'updateSpreadsheetProperties', properties, fields

  updateSheetProperties: (sheetName, properties, fields = '*') ->
    properties.sheetId = if @tabs.has sheetName
      @tabs.get sheetName
    else sheetName # in case it's the ID
    new Request 'updateSheetProperties', properties, fields

  updateDimensionProperties: (properties, fields = '*') ->
    throw new Error "Not written yet"
    new Request 'updateDimensionProperties', properties, fields

  updateNamedRange: (name, newRange, fields = '*') ->
    range = @ranges.get name
    throw new Error "Named range #{name} not found" unless range?
    gRange = @sheet.getRange newRange
    properties =
      namedRangeId: range.id
      name: name        # can't currently change the name
      range: gRange.gridRange
    new Request 'updateNamedRange', properties, fields

  repeatCell: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'repeatCell', properties, fields

  addNamedRange: (name, newRange, fields) ->
    gRange = @sheet.getRange newRange
    properties =
      name: name        # can't currently set the id
      range: gRange.gridRange
    new Request 'addNamedRange', properties, fields

  deleteNamedRange: (name) ->
    range = @ranges.get name
    throw new Error "Named range #{name} not found" unless range?
    new Request 'deleteNamedRange', namedRangeId: range.id, null

  addSheet: (properties) ->
    new Request 'addSheet', properties, null

  deleteSheet: (sheetName, fields) ->
    sheetId = k for [k, v] from @tabs when v is sheetName
    throw new Error "Sheet name #{name} not found" unless sheetId?
    new Request 'deleteSheet', sheetId: sheetId, null

  autoFill: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'autoFill', properties, fields

  cutPaste: (range, coordinate, pasteType = 'PASTE_NORMAL') ->
    range = @sheet.get range
    unless coordinate.indexOf '!' > 0
      coordinate = "#{range.sheet}!#{coordinate}"
    coordinate = sheet.getCoordinate
    new Request 'cutPaste',
      source: range.gridRange
      destination: coordinate.gridCoordinate
      pasteType: pasteType

  copyPaste: (range, coordinate, pasteType = 'PASTE_NORMAL', orientation = 'NORMAL') ->
    range = @sheet.get range
    unless coordinate.indexOf '!' > 0
      coordinate = "#{range.sheet}!#{coordinate}"
    coordinate = sheet.getCoordinate
    new Request 'copyPaste',
      source: range.gridRange
      destination: coordinate.gridCoordinate
      pasteType: pasteType
      orientation: orientation

  mergeCells: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'mergeCells', properties, fields

  unmergeCells: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'unmergeCells', properties, fields

  updateBorders: (range, properties) ->
    range = @sheet.getRange range
    properties.range = range.gridRange
    new Request 'updateBorders', properties

  updateCells: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateCells', properties, fields

  addFilterView: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addFilterView', properties, fields

  appendCells: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'appendCells', properties, fields

  clearBasicFilter: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'clearBasicFilter', properties, fields

  deleteDimension: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteDimension', properties, fields

  deleteEmbeddedObject: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteEmbeddedObject', properties, fields

  deleteFilterView: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteFilterView', properties, fields

  duplicateFilterView: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'duplicateFilterView', properties, fields

  duplicateSheet: (source, newName, index) ->
    sourceSheetId = k for [k, v] from @tabs when v is source
    properties =
      sourceSheetId: sourceSheetId
      newSheetName: newName
    properties.insertSheetIndex = index if index?
    new Request 'duplicateSheet', properties

  findReplace: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'findReplace', properties, fields

  insertDimension: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'insertDimension', properties, fields

  insertRange: (range, direction = 'ROWS') ->
    range = @sheet.getRange range
    new Request 'insertRange',
      range: range.gridRange
      shiftDimension: direction

  moveDimension: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'moveDimension', properties, fields

  updateEmbeddedObjectPosition: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateEmbeddedObjectPosition', properties, fields

  pasteData: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'pasteData', properties, fields

  textToColumns: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'textToColumns', properties, fields

  updateFilterView: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateFilterView', properties, fields

  deleteRange: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteRange', properties, fields

  appendDimension: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'appendDimension', properties, fields

  addConditionalFormatRule: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addConditionalFormatRule', properties, fields

  updateConditionalFormatRule: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateConditionalFormatRule', properties, fields

  deleteConditionalFormatRule: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteConditionalFormatRule', properties, fields

  sortRange: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'sortRange', properties, fields

  setDataValidation: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'setDataValidation', properties, fields

  setBasicFilter: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'setBasicFilter', properties, fields

  addProtectedRange: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addProtectedRange', properties, fields

  updateProtectedRange: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateProtectedRange', properties, fields

  deleteProtectedRange: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteProtectedRange', properties, fields

  autoResizeDimensions: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'autoResizeDimensions', properties, fields

  addChart: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addChart', properties, fields

  updateChartSpec: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateChartSpec', properties, fields

  updateBanding: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateBanding', properties, fields

  addBanding: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addBanding', properties, fields

  deleteBanding: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteBanding', properties, fields

  createDeveloperMetadata: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'createDeveloperMetadata', properties, fields

  updateDeveloperMetadata: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateDeveloperMetadata', properties, fields

  deleteDeveloperMetadata: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteDeveloperMetadata', properties, fields

  randomizeRange: (range) ->
    range = @sheet.getRange range
    new Request 'randomizeRange', range: range.gridRange

  addDimensionGroup: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addDimensionGroup', properties, fields

  deleteDimensionGroup: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteDimensionGroup', properties, fields

  updateDimensionGroup: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateDimensionGroup', properties, fields

  trimWhitespace: (range) ->
    range = @sheet.getRange range
    new Request 'trimWhitespace', range: range.gridRange

  deleteDuplicates: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'deleteDuplicates', properties, fields

  addSlicer: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'addSlicer', properties, fields

  updateSlicerSpec: (properties, fields) ->
    throw new Error "Not written yet"
    new Request 'updateSlicerSpec', properties, fields

module.exports = RequestFactory
