[googleapis]: https://www.npmjs.com/package/googleapis
[service]: https://www.npmjs.com/package/googleapis#service-to-service-authentication
[range]: https://support.google.com/docs/answer/63175?co=GENIE.Platform%3DDesktop&hl=en
[github]: https://github.com/CliffS/google-sheets-simple/issues
[API]: https://developers.google.com/sheets/api/reference/rest
[npm-image]:https://img.shields.io/npm/v/google-sheets-simple.svg
[npm-url]:http://npmjs.org/package/google-sheets-simple
[travis-image]:https://travis-ci.org/glicht/google-sheets-simple.svg?branch=master
[travis-url]:https://travis-ci.org/glicht/google-sheets-simple
[david-image]:https://david-dm.org/glicht/google-sheets-simple/status.svg
[david-url]:https://david-dm.org/glicht/google-sheets-simple
[coveralls-image]:https://coveralls.io/repos/github/glicht/google-sheets-simple/badge.svg?branch=master
[coveralls-url]:https://coveralls.io/github/glicht/google-sheets-simple?branch=master

# google-sheets-simple

[![npm package][npm-image]][npm-url] 
[![Build Status][travis-image]][travis-url] 
[![Coverage Status][coveralls-image]][coveralls-url] 
[![Dependencies Status][david-image]][david-url]

A simple way to access Google Sheets with named and unnamed ranges

## Breaking changes

Version v0.3.0 onwards use a different syntax for the `require`:

```javascript
const { Sheet, Range } = require('google-sheets-simple');
```

## Please note

This library is a simplified interface
to the [Google APIs Node.js Client][googleapis]
and currently only uses the [Service to Service Authentication][service]
method.

The full API can be found [here][API].  This library currently only supports
the basic essentials.

## Usage

The design behind this module is that you wish to get or put a
particular range of cells.  It works best with a [named range][range] but
equally will work with a range described by `Sheet1!A1:D15`.  You
can get all the cells in the range or set some of the cells, clearing
out the rest of the range.

All methods return promises.

## Installation

```
npm install google-sheets-simple
```

## Example

```javascript
// This assumes you have set the environment variable
//  GOOGLE_APPLICATION_CREDENTIALS to point at a service account file

const { Sheet } = require('google-sheets-simple');

const sheet = new Sheet(<sheet_id>);
sheet.initialise()
.then(() => {
  const data = <some two-dimensional array>;
  sheet.save(<named range>, data);
  })
.then(() => {
  sheet.get(<another range>);
  })
.then((array) => {
  // array contains a two-dimensional array of the cell values
  });
```

## Constructor

This is simply called with the id of the spreadsheet.  The id can
be obtained from the URL in a browser.  It is the part between `/d/` and
`/edit`.

This library assumes that you have set up `GOOGLE_APPLICATION_CREDENTIALS`
correctly and that the service account has access to the
spreadsheet. The scope used is `https://www.googleapis.com/auth/spreadsheets`.

```javascript
const { Sheet } = require('google-sheets-simple');

const sheet = new Sheet(<sheet_id>);
```

## Methods

### initialise (or initialize)

This is required before any other method is called.  It sets up the
authentication and populates spreadsheet information into the class.
It returns a promise and you should wait for the promise to resolve
before making any other calls.  The promise resolves with the full
spreadsheet data from the API.  This can usually be ignored.

```javascript
await sheet.initialise();
```

### get

This should be passed a range.  All ranges may be passed either as a
named range (`Data ⇒ Named ranges`) or in the format `Sheet1!A1:C20`.
Please note that when using A1 ranges, the sheet name is currently
required, even if there is only one sheet.  Using named ranges is
highly recommended.

The second parameter is optional and defaults to `ROWS`.  The alternative
is `COLUMNS` and describes how the data should be retreived. The data
returned will be a two-dimensional array.

```javascript
data = await sheet.get('named_range', 'ROWS');
```

### save

This should be passed a range, as in `get()` above.  The second
parameter is the data as a two-dimensional array and the optional
third defaults to 'ROWS' (see above).

If the data does not fill the range given, the remaining rows will
be cleared.  If `ROWS` is passed, the cleared space is everything
from the last row provided to the bottom of the range.  If `COLUMNS`
is provided, each column is cleared from the bottom of the data in
that column to the bottom of the range.

The response is the raw response data from the API.

```javascript
await sheet.save('named_range', dataArray, 'ROWS');
```

### clear

This should be passed a range, as in `get()` above.  The range
will be cleared.

The response is the raw response data from the API.

```javascript
await sheet.clear('Sheet2!A3:J50');
```

### append

This should be passed a range, a two-dimensional array is in `save()`
above and a third parameter defaulting to 'ROWS'.  The range should describe
the top part of a table.

The data passed will be appended to the table, even though the table
extends below the range.  It is usual with `append()` only to pass
a single row of data to be appended but please remember that it still
needs to be a two-dimensional array.

```javascript
await sheet.append('named_range', [ rowDataArray ]);
```

# Any issues

Please report any issues or comments at [Github][github] issues. PRs and
suggestions are very welcome.
