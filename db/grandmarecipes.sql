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

ALTER TABLE users ADD address VARCHAR(255);
ALTER TABLE users MODIFY email VARCHAR(255) UNIQUE;
ALTER TABLE users RENAME COLUMN username TO name;

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

SELECT *
FROM grandmas
INNER JOIN recipes ON idGrandma = recipes.fkGrandma
INNER JOIN recipes_have_ingredients ON idRecipe = recipes_have_ingredients.fkRecipe
INNER JOIN ingredients ON recipes_have_ingredients.fkIngredient = idIngredient
INNER JOIN images ON images.fkRecipe = idRecipe;

SELECT * FROM grandmas, recipes, recipes_have_ingredients, ingredients, images WHERE grandmas.idGrandma = recipes.fkGrandma AND recipes.idRecipe = recipes_have_ingredients.fkRecipe
AND recipes_have_ingredients.fkIngredient = ingredients.idIngredient AND images.fkRecipe = recipes.idRecipe;



INSERT INTO grandmas (name, lastname, city, province, country, birthYear, bio, photo)
VALUES ("Ana", "Romero", "Loja", "Granada", "España", 1933, "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "https://hips.hearstapps.com/hmg-prod/images/vintage-kitchen-tools-bread-box-1665515815.jpg?crop=1xw:0.9775364107627746xh;center,top&resize=980:*");

INSERT INTO grandmas (name, lastname, city, province, country, birthYear, bio, photo)
VALUES ("Roberta", "Ramirez", "Madrid", "Madrid", "España", 1950, "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "https://hips.hearstapps.com/hmg-prod/images/vintage-kitchen-tools-bread-box-1665515815.jpg?crop=1xw:0.9775364107627746xh;center,top&resize=980:*");

INSERT INTO users (username, email, password)
VALUES ("Lucía", "lucia@gmail.com", "123");

INSERT INTO users (username, email, password)
VALUES ("Aroa", "aroa@gmail.com", "123");

INSERT INTO recipes (nameRecipe, descRecipe, cookingTime, directions, background, fkUser, fkGrandma)
VALUES ("Papas a lo pobre", "Donec ultrices metus quis nisl accumsan convallis.", "40 min", "Praesent tincidunt tellus et molestie lacinia.", "Nunc efficitur augue quis dolor pellentesque faucibus eu non mi.", 1, 1);

INSERT INTO recipes (nameRecipe, descRecipe, cookingTime, directions, background, fkUser, fkGrandma)
VALUES ("Salmorejo", "Donec ultrices metus quis nisl accumsan convallis.", "30 min", "Praesent tincidunt tellus et molestie lacinia.", "Nunc efficitur augue quis dolor pellentesque faucibus eu non mi.", 2, 2);

INSERT INTO ingredients (nameIngredient)
VALUES ("tomate");
INSERT INTO ingredients (nameIngredient)
VALUES ("aceite");
INSERT INTO ingredients (nameIngredient)
VALUES ("sal");
INSERT INTO ingredients (nameIngredient)
VALUES ("ajo");
INSERT INTO ingredients (nameIngredient)
VALUES ("pepino");
INSERT INTO ingredients (nameIngredient)
VALUES ("garbanzos");
INSERT INTO ingredients (nameIngredient)
VALUES ("cebolla");
INSERT INTO ingredients (nameIngredient)
VALUES ("calabaza");

INSERT INTO images (image, fkRecipe)
VALUES ("https://www.chocolateyron.com/wp-content/uploads/salmorejo.jpg",3);

INSERT INTO images (image, fkRecipe)
VALUES ("https://upload.wikimedia.org/wikipedia/commons/f/f8/Patatas_a_lo_pobre_%287456975814%29.jpg",2);


