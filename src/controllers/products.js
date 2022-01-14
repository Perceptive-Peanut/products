const Product = require('../models/product');

const handleGetAllProducts = (req, res) => {
  Product.getAllProducts(null, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

const handleGetProductById = (req, res) => {
  Product.getProductById(null, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

const handleGetStylesByProductId = (req, res) => {
  Product.getStylesByProductId(null, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

const handleGetRelatedByProductId = (req, res) => {
  Product.getRelatedByProductId(null, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

module.exports = {
  handleGetAllProducts,
  handleGetProductById,
  handleGetStylesByProductId,
  handleGetRelatedByProductId
};
