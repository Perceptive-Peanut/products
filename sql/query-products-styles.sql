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
			) as skus,
			(select json_agg(testa)
				from (
				  SELECT id, size  FROM productsschema.skus WHERE styleid = s.id
				) as testa
			) as test,
			(select json_build_object('id1', json_agg(testa))
				from (
				  SELECT id FROM productsschema.skus WHERE styleid = s.id
				) as testa
			) as test2
			FROM productsschema.styles as s
			WHERE productid = 1
	) as styles)
)
