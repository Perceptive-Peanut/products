\connect productsdb;

-- Load "products" table data
\COPY productsschema.products FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/product.csv' DELIMITER ',' CSV HEADER; -- COPY 1000011

-- Load "styles" table data
\COPY productsschema.styles FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/styles.csv' DELIMITER ',' CSV HEADER NULL 'null'; -- COPY 1958102

-- Load "skus" table data
\COPY productsschema.skus FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/skus.csv' DELIMITER ',' CSV HEADER; -- COPY 11323917

-- Load "photos" table data
\COPY productsschema.photos FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/photos.csv' DELIMITER ',' CSV HEADER NULL 'null'; -- COPY 5655463

-- Load "related" table data
\COPY productsschema.related FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/related.csv' DELIMITER ',' CSV HEADER; -- COPY 4508263

-- Remove invalid records from "related" table
DELETE FROM productsschema.related  WHERE related_product_id = 0;

-- Add constrain to "related" table
ALTER TABLE productsschema.related ADD CONSTRAINT product_related_ibfk_2 FOREIGN KEY (related_product_id) REFERENCES productsschema.products(id);
