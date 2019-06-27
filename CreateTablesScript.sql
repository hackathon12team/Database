CREATE TABLE IF NOT EXISTS `HEATDB`.`USERS` (
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
-- Table `HEATDB`.`PARAMETERS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HEATDB`.`PARAMETERS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `weight` FLOAT NOT NULL,
  `height` FLOAT NOT NULL,
  `physical_activity` INT NOT NULL,
  `target_weight` FLOAT NOT NULL,
  `created_at` TIMESTAMP DEFAULT NOW() NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `HEATDB`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `HEATDB`.`INGREDIENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HEATDB`.`INGREDIENTS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `calories` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)


-- -----------------------------------------------------
-- Table `HEATDB`.`DISHES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HEATDB`.`DISHES` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `category` INT NOT NULL,
  `meal_type_mask` BYTEA NOT NULL,
  `photo_url` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)


-- -----------------------------------------------------
-- Table `HEATDB`.`PRIORITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HEATDB`.`PRIORITY` (
  `user_id` INT NOT NULL,
  `dish_id` INT NOT NULL,
  `priority` INT NOT NULL DEFAULT 10,
  PRIMARY KEY (`user_id`, `dish_id`),
  INDEX `dish_id_idx` (`dish_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `HEATDB`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dish_id_fk`
    FOREIGN KEY (`dish_id`)
    REFERENCES `HEATDB`.`DISHES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `HEATDB`.`DISH_COMPONENTS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HEATDB`.`DISH_COMPONENTS` (
  `dish_id` INT NOT NULL,
  `ingredient_id` INT NULL,
  `weight` FLOAT NOT NULL,
  PRIMARY KEY (`dish_id`, `ingredient_id`),
  INDEX `ingredient_id_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `dish_id_fk`
    FOREIGN KEY (`dish_id`)
    REFERENCES `HEATDB`.`DISHES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ingredient_id_fk`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `HEATDB`.`INGREDIENTS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)


-- -----------------------------------------------------
-- Table `HEATDB`.`MEALS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HEATDB`.`MEALS` (
  `user_id` INT NOT NULL,
  `dish_id` INT NULL,
  `date` DATE NOT NULL,
  `type` INT NOT NULL,
  PRIMARY KEY (`user_id`, `dish_id`),
  INDEX `dish_id_idx` (`dish_id` ASC) VISIBLE,
  CONSTRAINT `user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `HEATDB`.`USERS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dish_id_fk`
    FOREIGN KEY (`dish_id`)
    REFERENCES `HEATDB`.`DISHES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)