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