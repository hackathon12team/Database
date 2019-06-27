CREATE TABLE IF NOT EXISTS `mydb`.`USERS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `password` VARCHAR(45) NOT NULL,
  `gender` INT NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE)


-- -----------------------------------------------------
-- Table `mydb`.`PARAMETERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PARAMETERS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `weight` FLOAT NOT NULL,
  `height` FLOAT NOT NULL,
  `physical_activity` INT NOT NULL,
  `target_weight` FLOAT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `mydb`.`INGREDIENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`INGREDIENTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `calories` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)


-- -----------------------------------------------------
-- Table `mydb`.`DISHES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`DISHES` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `category` INT NOT NULL,
  `meal_type_mask` INT NOT NULL,

  `photo_url` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)


-- -----------------------------------------------------
-- Table `mydb`.`PRIORITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRIORITY` (
  `user_id` INT NOT NULL,
  `dish_id` INT NOT NULL,
  `priority` INT NOT NULL DEFAULT 10,
  PRIMARY KEY (`user_id`, `dish_id`),
  INDEX `dish_id_idx` (`dish_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dish_id_fk`
    FOREIGN KEY (`dish_id`)
    REFERENCES `mydb`.`DISHES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `mydb`.`PRODUCTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PRODUCTS` (
  `dish_id` INT NOT NULL,
  `ingredient_id` INT NULL,
  `weight` FLOAT NOT NULL,
  PRIMARY KEY (`dish_id`, `ingredient_id`),
  INDEX `ingredient_id_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `dish_id_fk`
    FOREIGN KEY (`dish_id`)
    REFERENCES `mydb`.`DISHES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ingredient_id_fk`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `mydb`.`INGREDIENTS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `mydb`.`MEALS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MEALS` (
  `user_id` INT NOT NULL,
  `dish_id` INT NULL,
  `date` DATE NOT NULL,
  `type` INT NOT NULL,
  PRIMARY KEY (`user_id`, `dish_id`),
  INDEX `dish_id_idx` (`dish_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dish_id_fk`
    FOREIGN KEY (`dish_id`)
    REFERENCES `mydb`.`DISHES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)