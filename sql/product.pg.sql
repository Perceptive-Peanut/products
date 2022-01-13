-- -----------------------------------------------------
-- Drop and Create database and schema
-- -----------------------------------------------------

DROP DATABASE IF EXISTS productsdb;
CREATE DATABASE productsdb;
\connect productsdb;
DROP SCHEMA if exists productsschema;
CREATE SCHEMA productsschema;

-- -----------------------------------------------------
-- Drop tables
-- -----------------------------------------------------

DROP TABLE IF EXISTS productsschema.products CASCADE;
DROP TABLE IF EXISTS productsschema.photos CASCADE;
DROP TABLE IF EXISTS productsschema.product_related CASCADE;
DROP TABLE IF EXISTS productsschema.styles CASCADE;
DROP TABLE IF EXISTS productsschema.skus CASCADE;


-- -----------------------------------------------------
-- Table productsDB.products
-- -----------------------------------------------------

CREATE TABLE productsschema.products (
  id SERIAL UNIQUE PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  campus VARCHAR(255) NOT NULL,
  slogan VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL,
  category VARCHAR(255) NOT NULL,
  default_price VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL
);

-- -----------------------------------------------------
-- Table photos
-- -----------------------------------------------------
CREATE TABLE productsschema.photos (
  id SERIAL PRIMARY KEY,
  product_id INT NULL DEFAULT NULL,
  thumbnail_url VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT photos_fk
    FOREIGN KEY (product_id)
    REFERENCES productsschema.products(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table product_related
-- -----------------------------------------------------
CREATE TABLE productsschema.related (
  product_id INT NOT NULL PRIMARY KEY,
  related_id INT NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT product_related_ibfk_1
    FOREIGN KEY (related_id)
    REFERENCES productsschema.products (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT product_related_ibfk_2
    FOREIGN KEY (product_id)
    REFERENCES productsschema.products (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table styles
-- -----------------------------------------------------
CREATE TABLE productsschema.styles (
  id SERIAL PRIMARY KEY,
  productId INT NULL DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT styles_ibfk_1
    FOREIGN KEY (productId)
    REFERENCES productsschema.products (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table skus
-- -----------------------------------------------------
CREATE TABLE productsschema.skus (
  id SERIAL PRIMARY KEY ,
  styleId INT NULL DEFAULT NULL,
  size VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT skus_ibfk_1
    FOREIGN KEY (styleId)
    REFERENCES productsschema.styles (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Populate db schema tables
-- -----------------------------------------------------
