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
    callback(null, res.rows[0].json_agg[0]);
  })
}

const getRelatedByProductId = (product_id, callback) => {
  const queryStr = `SELECT json_agg(related_product_id) FROM productsschema.related WHERE current_product_id = ${product_id};`;
  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }
    callback(null, res.rows[0].json_agg);
  })
}

module.exports = {
  getAllProducts,
  getProductById,
  getStylesByProductId,
  getRelatedByProductId,
}
