const Product = require('../models/product');

const getAllProducts = (req, res) => {
  const products = Product.find({})
    .then(function(product) {
      res.json(product);
    })
      .catch(function(err) {
        res.json(err);
      })
  ;
};

const createProduct = (req, res) => {
  const products = Product.create(req.body)
  .then(function(product) {
    // If we were able to successfully create a Product, send it back to the client
    res.json(product);
  })
  .catch(function(err) {
    // If an error occurred, send it to the client
    res.json(err);
  });
};

module.exports = {getAllProducts, createProduct};
