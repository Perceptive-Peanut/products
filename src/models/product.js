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
  const queryStr = `SELECT json_build_object(
    'product_id', 1,
    'results', (SELECT json_agg(row_to_json(styles)) FROM (
      SELECT
        styles.id,
        styles.name,
        styles.original_price,
        styles.sale_price,
        (select json_agg(photos)
          from (
            SELECT thumbnail_url, url FROM productsschema.photos WHERE styleid = styles.id
          ) as photos
        ) as photos,
        (SELECT
          json_object_agg(
            skus.id,
            json_build_object(
              'quantity', skus.quantity,
              'size', skus.size
            )
          ) AS skus from productsschema.skus WHERE skus.styleid = styles.id
        ) as skus
        FROM productsschema.styles AS styles WHERE productid = ${product_id}
    ) as styles)
  )`;

  db.query(queryStr, (err, res) => {
    if (err) {
      callback(err);
    }

    callback(null, res.rows[0].json_build_object);
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
