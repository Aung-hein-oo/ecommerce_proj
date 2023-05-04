-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema ecommerce_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ecommerce_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ecommerce_db` DEFAULT CHARACTER SET utf8mb3 ;
USE `ecommerce_db` ;

-- -----------------------------------------------------
-- Table `ecommerce_db`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_id` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` BLOB NULL DEFAULT NULL,
  `image` VARCHAR(45) NULL DEFAULT NULL,
  `category_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `category_id1`),
  INDEX `fk_product_category1_idx` (`category_id1` ASC) VISIBLE,
  CONSTRAINT `fk_product_category1`
    FOREIGN KEY (`category_id1`)
    REFERENCES `ecommerce_db`.`category` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`product_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`product_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qty_in_stock` INT NOT NULL,
  `product_image` VARCHAR(45) NULL DEFAULT NULL,
  `price` DECIMAL(65,0) NOT NULL,
  `product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_id`),
  INDEX `fk_product_detail_product_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_detail_product`
    FOREIGN KEY (`product_id`)
    REFERENCES `ecommerce_db`.`product` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`delivery_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`delivery_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `price` DECIMAL(65,0) NOT NULL,
  `address` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`order_status` (
  `id` INT NOT NULL,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`shop_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`shop_order` (
  `id` INT NOT NULL,
  `order_date` DATETIME NULL DEFAULT NULL,
  `order_total` INT NULL DEFAULT NULL,
  `order_status_id` INT NOT NULL,
  `delivery_method_id` INT NOT NULL,
  PRIMARY KEY (`id`, `order_status_id`, `delivery_method_id`),
  INDEX `fk_shop_order_order_status1_idx` (`order_status_id` ASC) VISIBLE,
  INDEX `fk_shop_order_delivery_method1_idx` (`delivery_method_id` ASC) VISIBLE,
  CONSTRAINT `fk_shop_order_delivery_method1`
    FOREIGN KEY (`delivery_method_id`)
    REFERENCES `ecommerce_db`.`delivery_method` (`id`),
  CONSTRAINT `fk_shop_order_order_status1`
    FOREIGN KEY (`order_status_id`)
    REFERENCES `ecommerce_db`.`order_status` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`checkout`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`checkout` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qty` INT NOT NULL,
  `price` DECIMAL(65,0) NOT NULL,
  `product_detail_id` INT NOT NULL,
  `shop_order_id` INT NOT NULL,
  PRIMARY KEY (`id`, `product_detail_id`, `shop_order_id`),
  INDEX `fk_checkout_product_detail1_idx` (`product_detail_id` ASC) VISIBLE,
  INDEX `fk_checkout_shop_order1_idx` (`shop_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_checkout_product_detail1`
    FOREIGN KEY (`product_detail_id`)
    REFERENCES `ecommerce_db`.`product_detail` (`id`),
  CONSTRAINT `fk_checkout_shop_order1`
    FOREIGN KEY (`shop_order_id`)
    REFERENCES `ecommerce_db`.`shop_order` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`payment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`payment_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(45) NULL DEFAULT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `phone_number` VARCHAR(45) NULL DEFAULT NULL,
  `address` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`payment_method` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `payment_type_id` INT NOT NULL,
  `shop_order_id` INT NOT NULL,
  `shop_order_order_status_id` INT NOT NULL,
  `shop_order_delivery_method_id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `payment_type_id`, `shop_order_id`, `shop_order_order_status_id`, `shop_order_delivery_method_id`, `user_user_id`),
  INDEX `fk_payment_method_payment_type1_idx` (`payment_type_id` ASC) VISIBLE,
  INDEX `fk_payment_method_shop_order1_idx` (`shop_order_id` ASC, `shop_order_order_status_id` ASC, `shop_order_delivery_method_id` ASC) VISIBLE,
  INDEX `fk_payment_method_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_method_payment_type1`
    FOREIGN KEY (`payment_type_id`)
    REFERENCES `ecommerce_db`.`payment_type` (`id`),
  CONSTRAINT `fk_payment_method_shop_order1`
    FOREIGN KEY (`shop_order_id` , `shop_order_order_status_id` , `shop_order_delivery_method_id`)
    REFERENCES `ecommerce_db`.`shop_order` (`id` , `order_status_id` , `delivery_method_id`),
  CONSTRAINT `fk_payment_method_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ecommerce_db`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`variation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`variation` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `category_id`),
  INDEX `fk_variation_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_variation_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `ecommerce_db`.`category` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`variation_option`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`variation_option` (
  `id` INT NOT NULL,
  `value` VARCHAR(45) NULL DEFAULT NULL,
  `variation_id` INT NOT NULL,
  PRIMARY KEY (`id`, `variation_id`),
  INDEX `fk_variation_option_variation1_idx` (`variation_id` ASC) VISIBLE,
  CONSTRAINT `fk_variation_option_variation1`
    FOREIGN KEY (`variation_id`)
    REFERENCES `ecommerce_db`.`variation` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`product_config`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`product_config` (
  `product_detail_id` INT NOT NULL,
  `variation_option_id` INT NOT NULL,
  PRIMARY KEY (`product_detail_id`, `variation_option_id`),
  INDEX `fk_product_config_variation_option1_idx` (`variation_option_id` ASC) VISIBLE,
  CONSTRAINT `fk_product_config_product_detail1`
    FOREIGN KEY (`product_detail_id`)
    REFERENCES `ecommerce_db`.`product_detail` (`id`),
  CONSTRAINT `fk_product_config_variation_option1`
    FOREIGN KEY (`variation_option_id`)
    REFERENCES `ecommerce_db`.`variation_option` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`promotion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`promotion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(100) NULL DEFAULT NULL,
  `discount_rate` VARCHAR(45) NULL DEFAULT NULL,
  `start_date` DATE NOT NULL,
  `end_date` DATE NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`promotion_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`promotion_category` (
  `promotion_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`promotion_id`, `category_id`),
  INDEX `fk_promotion_category_category1_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_promotion_category_category1`
    FOREIGN KEY (`category_id`)
    REFERENCES `ecommerce_db`.`category` (`id`),
  CONSTRAINT `fk_promotion_category_promotion1`
    FOREIGN KEY (`promotion_id`)
    REFERENCES `ecommerce_db`.`promotion` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`shopping_cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`shopping_cart` (
  `id` INT NOT NULL,
  `user_user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_user_id`),
  INDEX `fk_shopping_cart_user1_idx` (`user_user_id` ASC) VISIBLE,
  CONSTRAINT `fk_shopping_cart_user1`
    FOREIGN KEY (`user_user_id`)
    REFERENCES `ecommerce_db`.`user` (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ecommerce_db`.`shopping_cart_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce_db`.`shopping_cart_item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `qty` INT NOT NULL,
  `shopping_cart_id` INT NOT NULL,
  `product_detail_id` INT NOT NULL,
  `product_detail_product_id` INT NOT NULL,
  PRIMARY KEY (`id`, `shopping_cart_id`, `product_detail_id`, `product_detail_product_id`),
  INDEX `fk_shopping_cart_item_shopping_cart1_idx` (`shopping_cart_id` ASC) VISIBLE,
  INDEX `fk_shopping_cart_item_product_detail1_idx` (`product_detail_id` ASC, `product_detail_product_id` ASC) VISIBLE,
  CONSTRAINT `fk_shopping_cart_item_product_detail1`
    FOREIGN KEY (`product_detail_id` , `product_detail_product_id`)
    REFERENCES `ecommerce_db`.`product_detail` (`id` , `product_id`),
  CONSTRAINT `fk_shopping_cart_item_shopping_cart1`
    FOREIGN KEY (`shopping_cart_id`)
    REFERENCES `ecommerce_db`.`shopping_cart` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
