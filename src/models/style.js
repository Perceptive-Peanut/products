const mongoose = require('mongoose');

const styleSchema = mongoose.Schema({
  name: String
});

const Style = mongoose.model('style', styleSchema);

module.exports = Style;
