const highlight = require('highlight.js')

module.exports = function (code) {
  return highlight.highlightAuto(code).value
}
