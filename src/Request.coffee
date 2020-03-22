REQUESTS = [
  "updateSpreadsheetProperties"
  "updateSheetProperties"
  "updateDimensionProperties"
  "updateNamedRange"
  "repeatCell"
  "addNamedRange"
  "deleteNamedRange"
  "addSheet"
  "deleteSheet"
  "autoFill"
  "cutPaste"
  "copyPaste"
  "mergeCells"
  "unmergeCells"
  "updateBorders"
  "updateCells"
  "addFilterView"
  "appendCells"
  "clearBasicFilter"
  "deleteDimension"
  "deleteEmbeddedObject"
  "deleteFilterView"
  "duplicateFilterView"
  "duplicateSheet"
  "findReplace"
  "insertDimension"
  "insertRange"
  "moveDimension"
  "updateEmbeddedObjectPosition"
  "pasteData"
  "textToColumns"
  "updateFilterView"
  "deleteRange"
  "appendDimension"
  "addConditionalFormatRule"
  "updateConditionalFormatRule"
  "deleteConditionalFormatRule"
  "sortRange"
  "setDataValidation"
  "setBasicFilter"
  "addProtectedRange"
  "updateProtectedRange"
  "deleteProtectedRange"
  "autoResizeDimensions"
  "addChart"
  "updateChartSpec"
  "updateBanding"
  "addBanding"
  "deleteBanding"
  "createDeveloperMetadata"
  "updateDeveloperMetadata"
  "deleteDeveloperMetadata"
  "randomizeRange"
  "addDimensionGroup"
  "deleteDimensionGroup"
  "updateDimensionGroup"
  "trimWhitespace"
  "deleteDuplicates"
  "addSlicer"
  "updateSlicerSpec"
]

class Request

  constructor: (@tabs, @ranges) ->

  baseClass: class
    constructor: (@name, @properties, @fields = '*') ->

  updateSpreadsheetProperties: (properties, fields) ->
    new @baseClass 'updateSpreadsheetProperties', properties, fields

  updateSheetProperties: (sheetName, properties, fields) ->
      properties.sheetId = if @tabs.has sheetName
        @tabs.get sheetName
      else sheetName # in case it's the ID
      new @baseClass 'updateSheetProperties', properties, fields

  (properties, fields) ->
    new @baseClass 'updateDimensionProperties', properties, fields

  (properties, fields) ->
    new @baseClass 'updateNamedRange', properties, fields

  (properties, fields) ->
    new @baseClass 'repeatCell', properties, fields

  (properties, fields) ->
    new @baseClass 'addNamedRange', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteNamedRange', properties, fields

  (properties, fields) ->
    new @baseClass 'addSheet', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteSheet', properties, fields

  (properties, fields) ->
    new @baseClass 'autoFill', properties, fields

  (properties, fields) ->
    new @baseClass 'cutPaste', properties, fields

  (properties, fields) ->
    new @baseClass 'copyPaste', properties, fields

  (properties, fields) ->
    new @baseClass 'mergeCells', properties, fields

  (properties, fields) ->
    new @baseClass 'unmergeCells', properties, fields

  (properties, fields) ->
    new @baseClass 'updateBorders', properties, fields

  (properties, fields) ->
    new @baseClass 'updateCells', properties, fields

  (properties, fields) ->
    new @baseClass 'addFilterView', properties, fields

  (properties, fields) ->
    new @baseClass 'appendCells', properties, fields

  (properties, fields) ->
    new @baseClass 'clearBasicFilter', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteDimension', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteEmbeddedObject', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteFilterView', properties, fields

  (properties, fields) ->
    new @baseClass 'duplicateFilterView', properties, fields

  (properties, fields) ->
    new @baseClass 'duplicateSheet', properties, fields

  (properties, fields) ->
    new @baseClass 'findReplace', properties, fields

  (properties, fields) ->
    new @baseClass 'insertDimension', properties, fields

  (properties, fields) ->
    new @baseClass 'insertRange', properties, fields

  (properties, fields) ->
    new @baseClass 'moveDimension', properties, fields

  (properties, fields) ->
    new @baseClass 'updateEmbeddedObjectPosition', properties, fields

  (properties, fields) ->
    new @baseClass 'pasteData', properties, fields

  (properties, fields) ->
    new @baseClass 'textToColumns', properties, fields

  (properties, fields) ->
    new @baseClass 'updateFilterView', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteRange', properties, fields

  (properties, fields) ->
    new @baseClass 'appendDimension', properties, fields

  (properties, fields) ->
    new @baseClass 'addConditionalFormatRule', properties, fields

  (properties, fields) ->
    new @baseClass 'updateConditionalFormatRule', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteConditionalFormatRule', properties, fields

  (properties, fields) ->
    new @baseClass 'sortRange', properties, fields

  (properties, fields) ->
    new @baseClass 'setDataValidation', properties, fields

  (properties, fields) ->
    new @baseClass 'setBasicFilter', properties, fields

  (properties, fields) ->
    new @baseClass 'addProtectedRange', properties, fields

  (properties, fields) ->
    new @baseClass 'updateProtectedRange', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteProtectedRange', properties, fields

  (properties, fields) ->
    new @baseClass 'autoResizeDimensions', properties, fields

  (properties, fields) ->
    new @baseClass 'addChart', properties, fields

  (properties, fields) ->
    new @baseClass 'updateChartSpec', properties, fields

  (properties, fields) ->
    new @baseClass 'updateBanding', properties, fields

  (properties, fields) ->
    new @baseClass 'addBanding', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteBanding', properties, fields

  (properties, fields) ->
    new @baseClass 'createDeveloperMetadata', properties, fields

  (properties, fields) ->
    new @baseClass 'updateDeveloperMetadata', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteDeveloperMetadata', properties, fields

  (properties, fields) ->
    new @baseClass 'randomizeRange', properties, fields

  (properties, fields) ->
    new @baseClass 'addDimensionGroup', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteDimensionGroup', properties, fields

  (properties, fields) ->
    new @baseClass 'updateDimensionGroup', properties, fields

  (properties, fields) ->
    new @baseClass 'trimWhitespace', properties, fields

  (properties, fields) ->
    new @baseClass 'deleteDuplicates', properties, fields

  (properties, fields) ->
    new @baseClass 'addSlicer', properties, fields

  (properties, fields) ->
    new @baseClass 'updateSlicerSpec', properties, fields

module.exports = Request
