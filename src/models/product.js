const db = require('../db/postgres');

const getAllProducts = (params, callback) => {
  const queryStr = 'SELECT * FROM productsschema.products WHERE id < 10';
  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res);
  })
}

const getProductById = (params, callback) => {
  const queryStr = 'SELECT * FROM productsschema.products WHERE id < 10';
  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res);
  })
}

const getStylesByProductId = (params, callback) => {
  const queryStr = 'SELECT * FROM productsschema.products WHERE id < 10';
  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res);
  })
}

const getRelatedByProductId = (params, callback) => {
  const queryStr = 'SELECT * FROM productsschema.products WHERE id < 10';
  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res);
  })
}

module.exports = {
  getAllProducts,
  getProductById,
  getStylesByProductId,
  getRelatedByProductId,
}