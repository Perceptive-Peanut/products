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
-- id,name,slogan,description,category,default_price
CREATE TABLE productsschema.products (
  id SERIAL UNIQUE PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slogan VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  category VARCHAR(255) NOT NULL,
  default_price INT NOT NULL
);

-- -----------------------------------------------------
-- Table styles
-- -----------------------------------------------------
-- id,productId,name,sale_price,original_price,default_style
CREATE TABLE productsschema.styles (
  id SERIAL PRIMARY KEY,
  productId INT NULL DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  sale_price INT,
  original_price INT NOT NULL,
  default_style INT NOT NULL,
  CONSTRAINT styles_ibfk_1
    FOREIGN KEY (productId)
    REFERENCES productsschema.products (id)
);

-- -----------------------------------------------------
-- Table photos
-- -----------------------------------------------------
-- id,styleId,url,thumbnail_url
CREATE TABLE productsschema.photos (
  id SERIAL PRIMARY KEY,
  styleId INT NULL DEFAULT NULL,
  thumbnail_url VARCHAR(255) NOT NULL,
  url TEXT NOT NULL,
  CONSTRAINT photos_fk
    FOREIGN KEY (styleId)
    REFERENCES productsschema.styles(id)
);

-- -----------------------------------------------------
-- Table product_related
-- -----------------------------------------------------
-- id,current_product_id,related_product_id
CREATE TABLE productsschema.related (
  id INT NOT NULL PRIMARY KEY,
  current_product_id INT NOT NULL,
  related_product_id INT NOT NULL,
  CONSTRAINT product_related_ibfk_1
    FOREIGN KEY (current_product_id)
    REFERENCES productsschema.products (id),
  CONSTRAINT product_related_ibfk_2
    FOREIGN KEY (related_product_id)
    REFERENCES productsschema.products (id)
);

-- -----------------------------------------------------
-- Table skus
-- -----------------------------------------------------
-- id,styleId,size,quantity
CREATE TABLE productsschema.skus (
  id SERIAL PRIMARY KEY ,
  styleId INT NULL DEFAULT NULL,
  size VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  CONSTRAINT skus_ibfk_1
    FOREIGN KEY (styleId)
    REFERENCES productsschema.styles (id)
);

-- -----------------------------------------------------
-- Populate db schema tables
-- -----------------------------------------------------
