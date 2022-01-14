\connect productsdb;

DELETE FROM productsschema.related  WHERE related_product_id = 0;

ALTER TABLE productsschema.related ADD CONSTRAINT product_related_ibfk_2 FOREIGN KEY (related_product_id) REFERENCES productsschema.products(id);
