const mongoose = require('mongoose');

const skuSchema = mongoose.Schema({
  quantity: String,
  size: String
});

const Sku = mongoose.model('sku', skuSchema);

module.exports = Sku;
