const postgresClient = require('../db/postgres');
const redisClient = require('../db/redis');

const DEFAULT_EXPIRATION = 60;

const getAllProducts = (params, callback) => {
  const page = params.page || 1;
  const count = params.count || 5;
  const offset = (page - 1) * count;
  const queryStr = `SELECT * FROM productsschema.products OFFSET ${offset} FETCH NEXT ${count} ROWS ONLY`;
  const cacheKey = `/products?page=${page}&count=${count}`;

  redisClient.get(cacheKey)
    .then(response => {
      if (response != null) {
        // Using cached data"
        callback(null, JSON.parse(response));
      } else {
        // Set cache data
        postgresClient.query(queryStr, (err, res) => {
          if (err) callback(err);
          const result = res.rows;
          redisClient.set(cacheKey, JSON.stringify(result));
          redisClient.expire(cacheKey, DEFAULT_EXPIRATION);
          callback(null, result);
        })
      }
    })
    .catch(error => {
      console.log('error', error);
      callback(error);
    })
}

const getProductById = (product_id, callback) => {
  const queryStr = `SELECT * FROM productsschema.products WHERE id = ${product_id};`;
  const cacheKey = `/products/${product_id}`;

  redisClient.get(cacheKey)
    .then(product => {
      if (product != null) {
        // Using cached data"
        callback(null, JSON.parse(product));
      } else {
        postgresClient.query(queryStr, (err, res) => {
          if (err) callback(err);
          const response = res.rows[0];
          redisClient.set(cacheKey, JSON.stringify(response));
          redisClient.expire(cacheKey, DEFAULT_EXPIRATION);
          callback(null, response);
        })
      }
    })
    .catch(err => {
      console.log('err', err);
      callback(error);
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
  const cacheKey = `/products/${product_id}/styles`;

  redisClient.get(cacheKey)
    .then(response => {
      if (response != null) {
        // Using cached data
        callback(null, JSON.parse(response));
      } else {
        // Set cache data
        postgresClient.query(queryStr, (err, res) => {
          if (err) callback(err);
          const result = res.rows[0].json_build_object;
          redisClient.set(cacheKey, JSON.stringify(result));
          redisClient.expire(cacheKey, DEFAULT_EXPIRATION);
          callback(null, result);
        })
      }
    })
    .catch(error => {
      console.log('error', error);
      callback(error);
    })
}

const getRelatedByProductId = (product_id, callback) => {
  const queryStr = `SELECT json_agg(related_product_id) FROM productsschema.related WHERE current_product_id = ${product_id};`;
  const cacheKey = `/products/${product_id}/related`;

  redisClient.get(cacheKey)
    .then(response => {
      if (response != null) {
        // Using cached data"
        callback(null, JSON.parse(response));
      } else {
        // Set cache data
        postgresClient.query(queryStr, (err, res) => {
          if (err) callback(err);
          const result = res.rows[0].json_agg;
          redisClient.set(cacheKey, JSON.stringify(result));
          redisClient.expire(cacheKey, DEFAULT_EXPIRATION);
          callback(null, result);
        })
      }
    })
    .catch(error => {
      console.log('error', error);
      callback(error);
    })
}

module.exports = {
  getAllProducts,
  getProductById,
  getStylesByProductId,
  getRelatedByProductId,
}
