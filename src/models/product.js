const mongoose = require('mongoose');

const productSchema = {
  name: String,
  campus: String,
  slogan: String,
  description: String,
  category: String,
  default_price: String
};

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
