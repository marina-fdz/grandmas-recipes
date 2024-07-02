# Grandma's Recipes API

Grandma's Recipes API is a RESTful service that allows users to manage a database of recipes contributed by grandmas. Users can view recipes and grandmas, register and login, and upon authentication, add new recipes and grandmas. Additionally, registered users can modify and delete grandmas' entries.

## Table of Contents

1. [Technologies Used](#technologies-used)
2. [Installation](#installation)
3. [Environment Variables](#environment-variables)
4. [API Endpoints](#api-endpoints)
    - [User Endpoints](#user-endpoints)
    - [Recipe Endpoints](#recipe-endpoints)
    - [Grandma Endpoints](#grandma-endpoints)
5. [Database Schema](#database-schema)

## Technologies Used

- Node.js
- Express
- JWT (JSON Web Token)
- Bcrypt
- Dotenv
- CORS
- MySQL

## Dependencies

- express
- cors
- mysql2
- bcrypt
- jsonwebtoken
- dotenv

## Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/marina-fdz/grandmas-recipes.git
    ```

2. Navigate to the project directory:

    ```bash
    cd grandmas-recipes
    ```

3. Install dependencies:

    ```bash
    npm install
    ```

4. Set up the database using the provided MySQL script in `grandmarecipes.sql`.

5. Start the server:

    ```bash
    npm run dev
    ```

## Environment Variables

Create a `.env` file in the root directory and add the following variables:

```
PORT=your_chosen_port
DB_HOST=your_database_host
DB_USER=your_database_user
DB_PASS=your_database_password
DB_NAME=your_database_name
KEY_TOKEN=your_jwt_secret_key
```

## API Endpoints

### Public Endpoints

#### Get all recipes

   GET /recipes
        
Retrieves all recipes along with their details, ingredients, images, and associated grandma.

#### Get recipes by name

    GET /recipes/:nameRecipe
        
Retrieves recipes matching the given name.

#### Get recipes by ID

    GET /recipe/:idRecipe
        
Retrieves a specific recipe by its ID.

#### Get all grandmas

    GET /grandmas
        
Retrieves all grandmas.

#### Get grandma by ID

    GET /grandma/:idGrandma
        
Retrieves a specific grandma by her ID.

#### User Signup

    POST / signup
        
Creates a new user account.

Request body:

        {
            "email": "user@example.com",
            "password": "userpassword"
        }

#### User Login

    POST / login
        
Authenticates a user and returns a JWT.

Request body:

        {
            "email": "user@example.com",
            "password": "userpassword"
        }


### Protected endpoints

These endpoints require a valid JWT token to be included in the Authorization header.

#### Get all users

    GET / users
        
Retrieves all user profiles.


#### Get user profile

    GET /user/:idUser

        
Retrieves a specific user profile by user ID.

#### Add new grandma

    POST /grandma
      
Adds a new grandma entry associated with the logged-in user.

Request body:

            {
                "name": "Grandma's name",
                "lastname": "Lastname",
                "city": "City",
                "province": "Province",
                "country": "Country",
                "birthYear": "1933",
                "bio": "Short biography",
                "photo": "URL to photo"
            }


#### Modify grandma

    PUT /grandma/:id
      
Modifies an existing grandma's details.

#### Delete grandma

    DELETE /grandma/:id
      
Deletes a grandma's entry by ID.

#### Add new recipe

    POST /recipes/new
      
Adds a new recipe associated with the logged-in user and a grandma.

Requested body: 

            {
                "nameRecipe": "Recipe name",
                "descRecipe": "Recipe description",
                "cookingTime": "Cooking time",
                "ingredients": [
                    {
                        "nameIngredient": "Ingredient name",
                        "quantity": "Quantity",
                        "unit": "Unit"
                    }
                ],
                "directions": "Cooking directions",
                "background": "Background information",
                "images": ["Image URL"],
                "grandma": {
                    "nameGrandma": {
                        "name": "Grandma's name",
                        "lastname": "Lastname"
                    },
                    "location": {
                        "city": "City",
                        "province": "Province"
                    }
                }
            }


#### User Logout

    PUT /logout
      
Logs out the user by invalidating the JWT.


## Database Schema

```
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
    background TEXT,
    fkUser INT NOT NULL,
    fkGrandma INT NOT NULL,
    FOREIGN KEY (fkUser) REFERENCES users(idUser),
    FOREIGN KEY (fkGrandma) REFERENCES grandmas(idGrandma)
);

CREATE TABLE ingredients (
    idIngredient INT AUTO_INCREMENT PRIMARY KEY,
    nameIngredient VARCHAR(30) NOT NULL
);

CREATE TABLE users (
    idUser INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE images (
    idImage INT AUTO_INCREMENT PRIMARY KEY,
    image TEXT,
    fkRecipe INT NOT NULL,
    FOREIGN KEY (fkRecipe) REFERENCES recipes(idRecipe)
);

CREATE TABLE users_have_grandmas (
    idUserGrandma INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    fkUser INT NOT NULL,
    fkGrandma INT NOT NULL,
    FOREIGN KEY (fkUser) REFERENCES users(idUser),
    FOREIGN KEY (fkGrandma) REFERENCES grandmas(idGrandma)
);

CREATE TABLE recipes_have_ingredients (
    idRecipeIngredient INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    quantity FLOAT,
    unit VARCHAR(30),
    fkIngredient INT NOT NULL,
    fkRecipe INT NOT NULL,
    FOREIGN KEY (fkIngredient) REFERENCES ingredients(idIngredient),
    FOREIGN KEY (fkRecipe) REFERENCES recipes(idRecipe)
);

```

## Error Handling

- The API returns standard HTTP status codes for success and error states.
- Error responses include a JSON object with an error message.

## Author

[@marina-fdz](https://www.github.com/marina-fdz)
