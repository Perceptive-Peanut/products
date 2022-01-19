\connect productsdb;

/* get /products */
-- id,name,slogan,description,category,default_price
SELECT * FROM productsschema.products
  OFFSET 5 -- how many records to skip
  FETCH NEXT 5 ROWS ONLY; -- how many records to show


/* get /products/:id */
SELECT * FROM productsschema.products WHERE id = id;


/* get /products/:id/styles */
SELECT * FROM productsschema.styles AS styles
	JOIN productsschema.photos AS photos ON styles.id = photos.styleid
	JOIN productsschema.skus AS skus ON styles.id = skus.styleid
	WHERE styles.productid = 1;


/* get /products/:id/related */
SELECT related_product_id FROM productsschema.related WHERE current_product_id = 1;



-- SELECT * FROM productsdb.productsschema.products WHERE id < 10;
-- SELECT * FROM productsdb.photos WHERE id < 10;
-- SELECT * FROM productsdb.styles WHERE id < 10;
-- SELECT * FROM productsdb.skus WHERE id < 10;
-- SELECT * FROM productsdb.product_related WHERE id < 10;


/*
-- http://johnatten.com/2015/04/22/use-postgres-json-type-and-aggregate-functions-to-map-relational-data-to-json/#Aggregate-Rows-into-a-JSON-Array-Using-the-json_agg---Function

*/


SELECT * FROM productsschema.styles where productid = 1;
-- SELECT * FROM productsschema.styles as styles WHERE styles.productid = 1;
SELECT * FROM productsschema.styles;
SELECT row_to_json("styles") FROM productsschema.styles;
SELECT row_to_json(row('id', 'productid', 'name')) FROM productsschema.styles;
SELECT row_to_json(styles) FROM (SELECT * FROM productsschema.styles) as styles;
SELECT row_to_json(styles) FROM (SELECT id, productid, name FROM productsschema.styles as s WHERE s.productid = 1) as styles;
SELECT json_agg(row_to_json(styles)) FROM (SELECT * FROM productsschema.styles as s WHERE s.productid = 1) as styles;

SELECT id FROM productsschema.styles WHERE productid = 1

SELECT * FROM productsschema.photos as p WHERE p.styleid IN (SELECT id FROM productsschema.styles WHERE productid = 1);

SELECT
	s.id,
	s.name,
	s.original_price,
	s.sale_price,
	(select json_agg(p)
	  from (
		  SELECT * FROM productsschema.photos WHERE styleid = s.id
		) as p
	 ) as photos
	FROM productsschema.styles as s
	WHERE productid = 1;


SELECT json_agg(row_to_json(styles)) FROM (
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
		(select json_build_object(skus)
		  	from (
			  SELECT id, size  FROM productsschema.skus WHERE styleid = s.id
			) as skus
		) as skus
		FROM productsschema.styles as s
		WHERE productid = 1
) as styles;

SELECT json_agg(row_to_json(styles)) FROM (
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

SELECT json_build_object(
	'product_id', 1,
	'results', (SELECT json_agg(row_to_json(styles)) FROM (
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
	) as styles)
)


