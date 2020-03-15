[googleapis]: https://www.npmjs.com/package/googleapis
[service]: https://www.npmjs.com/package/googleapis#service-to-service-authentication
[range]: https://support.google.com/docs/answer/63175?co=GENIE.Platform%3DDesktop&hl=en

# google-sheets-simple

A simple way to access Google Sheets with named and unnamed ranges

## Please note

This is an early version, an `alpha` version really.  It should not
be used in earnest yet.

It is a simplified interface to the [Google APIs Node.js Client][googleapis]
and currently only uses the [Service to Service Authentication][service]
method.

## Usage

The design behind this module is that you wish to get or put a
particular range of cells.  It works best with a [named range] but
equally will work with a range described by `Sheet1!A1:D15`.  You
can get all the cells in the range or set some of the cells, clearing
out the rest of the range.

## Installation

```
npm install google-sheets-simple
```

## example

```javascript
// This assumes you have set the environment variable
//  GOOGLE_APPLICATION_CREDENTIALS to point at a service account file

const Sheets = require('google-sheets-simple');

const sheet = new Sheets(<sheet_id>);
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
