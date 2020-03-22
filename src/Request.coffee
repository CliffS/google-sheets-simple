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

  constructor: (@sheet) ->

  @baseclass: class
    constructor: (@properties..., @fields = '*') ->


  @updateSpreadsheetProperties: class extends @baseclass
    constructor: (@properties, @fields = '*') ->
      super arguments...

  updateSheetProperties: class extends @baseclass
    constructor: (sheetName, properties) ->
      super arguments...

  updateDimensionProperties: class extends @baseclass
    constructor: () ->
      super arguments...

  updateNamedRange: class extends @baseclass
    constructor: () ->
      super arguments...

  repeatCell: class extends @baseclass
    constructor: () ->
      super arguments...

  addNamedRange: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteNamedRange: class extends @baseclass
    constructor: () ->
      super arguments...

  addSheet: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteSheet: class extends @baseclass
    constructor: () ->
      super arguments...

  autoFill: class extends @baseclass
    constructor: () ->
      super arguments...

  cutPaste: class extends @baseclass
    constructor: () ->
      super arguments...

  copyPaste: class extends @baseclass
    constructor: () ->
      super arguments...

  mergeCells: class extends @baseclass
    constructor: () ->
      super arguments...

  unmergeCells: class extends @baseclass
    constructor: () ->
      super arguments...

  updateBorders: class extends @baseclass
    constructor: () ->
      super arguments...

  updateCells: class extends @baseclass
    constructor: () ->
      super arguments...

  addFilterView: class extends @baseclass
    constructor: () ->
      super arguments...

  appendCells: class extends @baseclass
    constructor: () ->
      super arguments...

  clearBasicFilter: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteDimension: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteEmbeddedObject: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteFilterView: class extends @baseclass
    constructor: () ->
      super arguments...

  duplicateFilterView: class extends @baseclass
    constructor: () ->
      super arguments...

  duplicateSheet: class extends @baseclass
    constructor: () ->
      super arguments...

  findReplace: class extends @baseclass
    constructor: () ->
      super arguments...

  insertDimension: class extends @baseclass
    constructor: () ->
      super arguments...

  insertRange: class extends @baseclass
    constructor: () ->
      super arguments...

  moveDimension: class extends @baseclass
    constructor: () ->
      super arguments...

  updateEmbeddedObjectPosition: class extends @baseclass
    constructor: () ->
      super arguments...

  pasteData: class extends @baseclass
    constructor: () ->
      super arguments...

  textToColumns: class extends @baseclass
    constructor: () ->
      super arguments...

  updateFilterView: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteRange: class extends @baseclass
    constructor: () ->
      super arguments...

  appendDimension: class extends @baseclass
    constructor: () ->
      super arguments...

  addConditionalFormatRule: class extends @baseclass
    constructor: () ->
      super arguments...

  updateConditionalFormatRule: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteConditionalFormatRule: class extends @baseclass
    constructor: () ->
      super arguments...

  sortRange: class extends @baseclass
    constructor: () ->
      super arguments...

  setDataValidation: class extends @baseclass
    constructor: () ->
      super arguments...

  setBasicFilter: class extends @baseclass
    constructor: () ->
      super arguments...

  addProtectedRange: class extends @baseclass
    constructor: () ->
      super arguments...

  updateProtectedRange: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteProtectedRange: class extends @baseclass
    constructor: () ->
      super arguments...

  autoResizeDimensions: class extends @baseclass
    constructor: () ->
      super arguments...

  addChart: class extends @baseclass
    constructor: () ->
      super arguments...

  updateChartSpec: class extends @baseclass
    constructor: () ->
      super arguments...

  updateBanding: class extends @baseclass
    constructor: () ->
      super arguments...

  addBanding: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteBanding: class extends @baseclass
    constructor: () ->
      super arguments...

  createDeveloperMetadata: class extends @baseclass
    constructor: () ->
      super arguments...

  updateDeveloperMetadata: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteDeveloperMetadata: class extends @baseclass
    constructor: () ->
      super arguments...

  randomizeRange: class extends @baseclass
    constructor: () ->
      super arguments...

  addDimensionGroup: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteDimensionGroup: class extends @baseclass
    constructor: () ->
      super arguments...

  updateDimensionGroup: class extends @baseclass
    constructor: () ->
      super arguments...

  trimWhitespace: class extends @baseclass
    constructor: () ->
      super arguments...

  deleteDuplicates: class extends @baseclass
    constructor: () ->
      super arguments...

  addSlicer: class extends @baseclass
    constructor: () ->
      super arguments...

  updateSlicerSpec: class extends @baseclass
    constructor: () ->
      super arguments...
  ###
