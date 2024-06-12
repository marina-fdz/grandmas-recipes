CREATE DATABASE grandmarecipes;
USE grandmarecipes;

CREATE TABLE grandmas (
idGrandma INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(45) NOT NULL,
lastname VARCHAR(45),
city VARCHAR(45),
province VARCHAR(45),
country VARCHAR(30),
birthYear YEAR,
bio TEXT,
photo TEXT
);

CREATE TABLE recipes (
idRecipe INT AUTO_INCREMENT PRIMARY KEY,
nameRecipe VARCHAR(45) NOT NULL,
descRecipe VARCHAR(200) NOT NULL,
cookingTime VARCHAR(30),
directions MEDIUMTEXT NOT NULL,
background TEXT
);

ALTER TABLE recipes ADD fkUser INT NOT NULL;
ALTER TABLE recipes ADD foreign key (fkUser)
REFERENCES users (idUser);
ALTER TABLE recipes ADD fkGrandma INT NOT NULL;
ALTER TABLE recipes ADD foreign key (fkGrandma)
REFERENCES grandmas (idGrandma);

CREATE TABLE ingredients (
idIngredient INT AUTO_INCREMENT PRIMARY KEY,
nameIngredient VARCHAR(30) NOT NULL
);

CREATE TABLE users (
idUser INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(45) NOT NULL,
email TINYTEXT NOT NULL,
password TEXT
);

CREATE TABLE images (
idImage INT AUTO_INCREMENT PRIMARY KEY,
image TEXT
);

ALTER TABLE images ADD fkRecipe INT NOT NULL;
ALTER TABLE images ADD foreign key (fkRecipe)
REFERENCES recipes (idRecipe);

CREATE TABLE users_have_grandmas (
idUserGrandma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
fkUser INT NOT NULL,
fkGrandma INT NOT NULL
);

ALTER TABLE users_have_grandmas ADD foreign key (fkUser)
REFERENCES users (idUser);
ALTER TABLE users_have_grandmas ADD foreign key (fkGrandma)
REFERENCES grandmas (idGrandma);

CREATE TABLE recipes_have_ingredients (
idRecipeIngredient INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
quantity FLOAT,
unit VARCHAR(30),
fkIngredient INT NOT NULL,
fkRecipe INT NOT NULL
);

ALTER TABLE recipes_have_ingredients ADD foreign key (fkIngredient)
REFERENCES ingredients (idIngredient);
ALTER TABLE recipes_have_ingredients ADD foreign key (fkRecipe)
REFERENCES recipes (idRecipe);

