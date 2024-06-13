# Grandma's Recipes API

Grandma's Recipes API is a RESTful service that allows users to manage a database of recipes contributed by grandmas. Users can view recipes and grandmas, register and login, and upon authentication, add new recipes and grandmas. Additionally, users can modify and delete grandmas' entries.

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
    git clone https://github.com/Adalab/modulo-4-evaluacion-final-bpw-marina-fdz.git
    ```

2. Navigate to the project directory:

    ```bash
    cd modulo-4-evaluacion-final-bpw-marina-fdz.git
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

```plaintext
PORT=5001
DB_HOST=your_database_host
DB_USER=your_database_user
DB_PASS=your_database_password
DB_NAME=your_database_name
KEY_TOKEN=your_jwt_secret_key
```

## API Endpoints

### Public Endpoints

#### Get all recipes

    ```bash
   GET /recipes
    ```
        
Retrieves all recipes along with their details, ingredients, images, and associated grandma.

#### Get recipes by name

    ```bash
   GET /recipes/:nameRecipe
    ```
        
Retrieves recipes matching the given name.