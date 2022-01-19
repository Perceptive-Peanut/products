\connect productsdb;


/* get /products */
EXPLAIN ANALYZE SELECT * FROM productsschema.products
  OFFSET 5
  FETCH NEXT 5 ROWS ONLY;

/* get /products/:id */
EXPLAIN ANALYZE SELECT * FROM productsschema.products WHERE id = id;

/* get /products/:id/styles */
EXPLAIN ANALYZE SELECT json_agg(row_to_json(styles)) FROM (
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
		WHERE productid = 1
) as styles;

/* get /products/:id/related */
EXPLAIN ANALYZE SELECT related_product_id FROM productsschema.related WHERE current_product_id = 1;
