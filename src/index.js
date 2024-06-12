const express = require('express');
const cors = require('cors');
const mysql = require('mysql2/promise');

require('dotenv').config();

const api = express();
api.use(cors());
api.use(express.json());

const PORT = process.env.PORT || 5001;

api.listen(PORT, ()=>{
    console.log(`Server running in port : http://localhost:${PORT}`);
});

async function getConnection(){
    const conex = await mysql.createConnection({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASS,
        database: process.env.DB_NAME
    });
    await conex.connect();
    console.log('conexion con la BD' + conex.threadId);
    return conex;
}

//get all recipes

api.get("/recetas", async(req, res)=>{
    try{
        const conn = await getConnection();
        const select = "SELECT * FROM grandmas INNER JOIN recipes ON grandmas.idGrandma = recipes.fkGrandma INNER JOIN recipes_have_ingredients ON recipes.idRecipe = recipes_have_ingredients.fkRecipe INNER JOIN ingredients ON recipes_have_ingredients.fkIngredient = ingredients.idIngredient INNER JOIN images ON images.fkRecipe = recipes.idRecipe;";
        const [results] = await conn.query(select);
        await conn.end();
        res.status(200).json({
            info: {count: results.length},
            results: results,
        });
    }catch (error){
        res.status(400).json(error);
    }
});

//get all grandmas
api.get("/abuelas", async(req, res)=>{
    try{
        const conn = await getConnection();
        const select = "SELECT * FROM grandmas;";
        const [results] = await conn.query(select);
        await conn.end();
        res.status(200).json({
            info: {count: results.length},
            results: results,
        });
    }catch (error){
        res.status(400).json(error);
    }
});



