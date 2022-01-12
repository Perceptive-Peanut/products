const mongoose = require('mongoose');

const productSchema = mongoose.Schema({
    name: String,
    campus: String,
    slogan: String,
    description: String,
    category: String,
    default_price: String
  },
  {
    timestamps: true
  }
);

const Product = mongoose.model('Product', productSchema);

module.exports = Product;
