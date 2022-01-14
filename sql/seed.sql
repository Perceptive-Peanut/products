\connect productsdb;
\COPY productsschema.products FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/product.csv' DELIMITER ',' CSV HEADER; -- COPY 1000011
\COPY productsschema.styles FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/styles.csv' DELIMITER ',' CSV HEADER NULL 'null'; -- COPY 1958102
\COPY productsschema.skus FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/skus.csv' DELIMITER ',' CSV HEADER; -- COPY 11323917
\COPY productsschema.photos FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/photos.csv' DELIMITER ',' CSV HEADER NULL 'null'; -- COPY 5655463
\COPY productsschema.related FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/related.csv' DELIMITER ',' CSV HEADER; -- COPY 4508263
