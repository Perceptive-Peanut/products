-- DROP DATABASE IF EXISTS productsdb;
-- DROP SCHEMA if exists productsSchema;
CREATE SCHEMA productsSchema;

CREATE TABLE productsSchema.products (
  id SERIAL UNIQUE PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  campus VARCHAR(255) NOT NULL,
  slogan VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  category VARCHAR(255) NOT NULL,
  default_price DECIMAL(10,0) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL
);

\copy productsSchema.products FROM '../csv/products.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE productsSchema.photos (
  id SERIAL PRIMARY KEY,
  product_id INT NULL DEFAULT NULL,
  thumbnail_url VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT photos_fk
    FOREIGN KEY (product_id)
    REFERENCES productsSchema.products(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- \copy productsSchema.photos FROM '../photos.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE productsSchema.product_related (
  id SERIAL UNIQUE PRIMARY KEY NOT NULL,
  answer_id INT NOT NULL,
  url VARCHAR(255) NOT NULL,
  FOREIGN KEY (answer_id) REFERENCES productsSchema.products (id)
);

-- \copy productsSchema.product_related FROM '../related.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE productsSchema.styles (
  id SERIAL PRIMARY KEY,
  productId INT NULL DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT styles_ibfk_1
    FOREIGN KEY (productId)
    REFERENCES productsSchema.products (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- \copy productsSchema.styles FROM '../styles.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE productsSchema.skus (
  id SERIAL PRIMARY KEY ,
  styleId INT NULL DEFAULT NULL,
  size VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT skus_ibfk_1
    FOREIGN KEY (styleId)
    REFERENCES productsSchema.styles (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- \copy productsSchema.skus FROM '../skus.csv' DELIMITER ',' CSV HEADER;

/*  Execute this file from the command line by typing:
 *  psql -U postgres -W server/schema.sql
 *  to create the database and the tables.*/