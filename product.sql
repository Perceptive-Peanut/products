DROP SCHEMA IF EXISTS `productsDB` ;
CREATE SCHEMA `productsDB`;
USE `productsDB`;

-- -----------------------------------------------------
-- Table `productsDB`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productsDB`.`products` ;

CREATE TABLE `productsDB`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `campus` VARCHAR(255) NOT NULL,
  `slogan` VARCHAR(255) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `category` VARCHAR(255) NOT NULL,
  `default_price` DECIMAL(10,0) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
);

-- -----------------------------------------------------
-- Table `productsDB`.`photos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productsDB`.`photos` ;

CREATE TABLE `productsDB`.`photos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NULL DEFAULT NULL,
  `thumbnail_url` VARCHAR(255) NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `productId` (`product_id` ASC) VISIBLE,
  CONSTRAINT `photos_fk`
    FOREIGN KEY (`product_id`)
    REFERENCES `productsDB`.`products` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `productsDB`.`product_related`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productsDB`.`product_related` ;

CREATE TABLE `productsDB`.`product_related` (
  `product_id_related` INT NOT NULL,
  `product_id` INT NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`product_id_related`, `product_id`),
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_related_ibfk_1`
    FOREIGN KEY (`product_id_related`)
    REFERENCES `productsDB`.`products` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_related_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `productsDB`.`products` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `productsDB`.`styles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productsDB`.`styles` ;

CREATE TABLE `productsDB`.`styles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `productId` INT NULL DEFAULT NULL,
  `name` VARCHAR(255) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `productId` (`productId` ASC) VISIBLE,
  CONSTRAINT `styles_ibfk_1`
    FOREIGN KEY (`productId`)
    REFERENCES `productsDB`.`products` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `productsDB`.`skus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `productsDB`.`skus` ;

CREATE TABLE `productsDB`.`skus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `styleId` INT NULL DEFAULT NULL,
  `size` VARCHAR(255) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `styleId` (`styleId` ASC) VISIBLE,
  CONSTRAINT `skus_ibfk_1`
    FOREIGN KEY (`styleId`)
    REFERENCES `productsDB`.`styles` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
);
