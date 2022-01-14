\connect productsdb;
\COPY productsschema.products FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/product.csv' DELIMITER ',' CSV HEADER; -- COPY 1000011
\COPY productsschema.styles FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/styles.csv' DELIMITER ',' CSV HEADER;
\COPY productsschema.photos FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/photos.csv' DELIMITER ',' CSV HEADER;
\COPY productsschema.related FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/related.csv' DELIMITER ',' CSV HEADER;
\COPY productsschema.skus FROM '/Users/nanda/Projects/galvanizeNov/perceptive-peanut/products/csv/skus.csv' DELIMITER ',' CSV HEADER;