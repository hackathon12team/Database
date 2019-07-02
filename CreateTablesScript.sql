CREATE TABLE IF NOT EXISTS USERS (
  id SERIAL,
  email VARCHAR(45) NULL,
  username VARCHAR(45) NULL,
  password VARCHAR(65) NOT NULL,
  gender INT NOT NULL,
  birthdate DATE NOT NULL,
  PRIMARY KEY (id));

create UNIQUE INDEX id_UNIQUE on USERS (id);
create UNIQUE INDEX email_UNIQUE on USERS (email);
create UNIQUE INDEX username_UNIQUE on USERS (username);


-- -----------------------------------------------------
-- Table PARAMETERS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PARAMETERS (
  id SERIAL,
  user_id INT NOT NULL,
  weight FLOAT NOT NULL,
  height FLOAT NOT NULL,
  physical_activity FLOAT NOT NULL,
  target_weight FLOAT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW() NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT user_id_fk
    FOREIGN KEY (user_id)
    REFERENCES USERS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

create UNIQUE INDEX id_UNIQUE on PARAMETERS (id);


-- -----------------------------------------------------
-- Table INGREDIENTS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS INGREDIENTS (
  id SERIAL,
  name VARCHAR(45) NOT NULL,
  calories INT NOT NULL,
  PRIMARY KEY (id));

create UNIQUE INDEX id_UNIQUE on INGREDIENTS (id);


-- -----------------------------------------------------
-- Table DISHES
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DISHES (
  id INT NOT NULL,
  name VARCHAR(45) NOT NULL,
  description VARCHAR(500) NOT NULL,
  category INT NOT NULL,
  meal_type_mask BYTEA NOT NULL,
  photo_url VARCHAR(100) NULL,
  PRIMARY KEY (id));

create UNIQUE INDEX id_UNIQUE on DISHES (id);


-- -----------------------------------------------------
-- Table PRIORITY
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS PRIORITY (
  user_id INT NOT NULL,
  dish_id INT NOT NULL,
  priority INT NOT NULL DEFAULT 10,
  PRIMARY KEY (user_id, dish_id),
  CONSTRAINT user_id_fk
    FOREIGN KEY (user_id)
    REFERENCES USERS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT dish_id_fk
    FOREIGN KEY (dish_id)
    REFERENCES DISHES (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


create INDEX dish_id_idx on PRIORITY (dish_id);

-- -----------------------------------------------------
-- Table DISH_COMPONENTS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS DISH_COMPONENTS (
  dish_id INT NOT NULL,
  ingredient_id INT NULL,
  weight FLOAT NOT NULL,
  PRIMARY KEY (dish_id, ingredient_id),
  CONSTRAINT dish_id_fk
    FOREIGN KEY (dish_id)
    REFERENCES DISHES (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT ingredient_id_fk
    FOREIGN KEY (ingredient_id)
    REFERENCES INGREDIENTS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

create INDEX ingredient_id_idx on DISH_COMPONENTS (ingredient_id);


-- -----------------------------------------------------
-- Table MEALS
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS MEALS (
  user_id INT NOT NULL,
  dish_id INT NULL,
  date DATE NOT NULL,
  type INT NOT NULL,
  PRIMARY KEY (user_id, dish_id),
  CONSTRAINT user_id_fk
    FOREIGN KEY (user_id)
    REFERENCES USERS (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT dish_id_fk
    FOREIGN KEY (dish_id)
    REFERENCES DISHES (id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

create INDEX dish_id_idx on MEALS (dish_id);