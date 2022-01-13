DROP SCHEMA if exists productsSchema;
DROP SCHEMA if exists productsSchema;

-- -----------------------------------------------------
-- Table productsDB.products
-- -----------------------------------------------------

DROP TABLE IF EXISTS productsDB.products CASCADE;
DROP TABLE IF EXISTS productsDB.photos CASCADE;
DROP TABLE IF EXISTS productsDB.product_related CASCADE;
DROP TABLE IF EXISTS productsDB.styles CASCADE;
DROP TABLE IF EXISTS productsDB.skus CASCADE;


CREATE TABLE productsDB.products (
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

-- -----------------------------------------------------
-- Table photos
-- -----------------------------------------------------
CREATE TABLE productsDB.photos (
  id SERIAL PRIMARY KEY,
  product_id INT NULL DEFAULT NULL,
  thumbnail_url VARCHAR(255) NOT NULL,
  url VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT photos_fk
    FOREIGN KEY (product_id)
    REFERENCES productsDB.products(id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table product_related
-- -----------------------------------------------------
CREATE TABLE productsDB.product_related (
  product_id INT NOT NULL PRIMARY KEY,
  product_id_related INT NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT product_related_ibfk_1
    FOREIGN KEY (product_id_related)
    REFERENCES productsDB.products (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT product_related_ibfk_2
    FOREIGN KEY (product_id)
    REFERENCES productsDB.products (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table styles
-- -----------------------------------------------------
CREATE TABLE productsDB.styles (
  id SERIAL PRIMARY KEY,
  productId INT NULL DEFAULT NULL,
  name VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT styles_ibfk_1
    FOREIGN KEY (productId)
    REFERENCES productsDB.products (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table skus
-- -----------------------------------------------------
CREATE TABLE productsDB.skus (
  id SERIAL PRIMARY KEY ,
  styleId INT NULL DEFAULT NULL,
  size VARCHAR(255) NOT NULL,
  createdAt TIMESTAMP NOT NULL,
  updatedAt TIMESTAMP NOT NULL,
  CONSTRAINT skus_ibfk_1
    FOREIGN KEY (styleId)
    REFERENCES productsDB.styles (id)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
