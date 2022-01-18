const db = require('../db/postgres');

const getAllProducts = (params, callback) => {

  const page = params.page || 1;
  const count = params.count || 5;
  const offset = (page - 1) * count;

  const queryStr = `SELECT * FROM productsschema.products OFFSET ${offset} FETCH NEXT ${count} ROWS ONLY`;

  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res.rows);
  })
}

const getProductById = (product_id, callback) => {
  const queryStr = `SELECT * FROM productsschema.products WHERE id = ${product_id};`;
  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res.rows[0]);
  })
}

const getStylesByProductId = (product_id, callback) => {
  // const queryStr = `SELECT * FROM productsschema.styles where productid = ${product_id};`;

  const queryStr = `SELECT json_agg(row_to_json(styles)) FROM (
    SELECT
      s.id,
      s.name,
      s.original_price,
      s.sale_price,
      (select json_agg(photos)
          from (
          SELECT thumbnail_url, url FROM productsschema.photos WHERE styleid = s.id
        ) as photos
      ) as photos,
      (select json_agg(skus)
          from (
          SELECT id, size  FROM productsschema.skus WHERE styleid = s.id
        ) as skus
      ) as skus
      FROM productsschema.styles as s
      WHERE productid = ${product_id}
  ) as styles;`

  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    // const response = {
    //   product_id: product_id,
    //   results: res.rows.map(row => ({
    //     ...row,
    //     photos: [],
    //     sku: [],
    //   }))
    // }
    callback(null, res.rows);
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
