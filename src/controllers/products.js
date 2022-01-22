const Product = require('../models/product');

const handleGetAllProducts = async (req, res) => {
  // route/?query
  const queryParams = req.query;

  Product.getAllProducts(queryParams, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

const handleGetProductById = (req, res) => {
  // route/:param1/:param2
  const {product_id} = req.params;
  Product.getProductById(product_id, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

const handleGetStylesByProductId = (req, res) => {
  const {product_id} = req.params;
  Product.getStylesByProductId(product_id, (err, response) => {
    if (err) {
      res.status(500).send(err);
    }
    res.send(response);
  })
};

const handleGetRelatedByProductId = (req, res) => {
  const {product_id} = req.params;
  Product.getRelatedByProductId(product_id, (err, response) => {
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
