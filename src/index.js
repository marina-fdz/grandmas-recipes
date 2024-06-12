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

api.get("/recipes", async(req, res)=>{
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
api.get("/grandmas", async(req, res)=>{
    try{
        const conn = await getConnection();
        const select = "SELECT * FROM grandmas;";
        const [results] = await conn.query(select);
        await conn.end();
        res.status(200).json({
            sucess: true,
            info: {count: results.length},
            results: results,
        });
    }catch (error){
        res.status(400).json(error);
    }
});

//get one grandma by id
api.get('/grandma/:idGrandma', async(req, res)=>{
    try{
        const {idGrandma} = req.params;
        const conn = await getConnection();
        const select = "SELECT * FROM grandmas WHERE idGrandma = ?;";
        const [result] = await conn.query(select, [idGrandma]);
        await conn.end();
        if(result.length === 0){
            res.status(200).json({
                success: false,
                message: 'That id does not exist in our data base'
            });
        }else{
            res.status(200).json({
                success: true,
                data: result[0],
            });
        }  
    }catch(error){
        res.status(400).json(error);
    }
});

//add new grandma
api.post('/grandma', async (req, res)=>{
    try{
        const conn = await getConnection();
        const { name, lastname, city, province, country, birthYear, bio, photo } = req.body;
        const insert = "INSERT INTO grandmas (name, lastname, city, province, country, birthYear, bio, photo) VALUES (?,?,?,?,?,?,?,?)";
        const [newGrandma] = await conn.query(insert, [name, lastname, city, province, country, birthYear, bio, photo]);
        await conn.end();
        res.status(200).json({
            success: true,
            idGrandma: newGrandma.insertId
        })
    }catch(error){
        res.status(400).json(error);
    }
});

//modify an existing grandma
api.put('/grandma/:id', async (req, res) => {
    try{
        const conn = await getConnection();
        const idGrandma = req.params.id;
        const data = req.body;
        const update = "UPDATE grandmas SET name = ?, lastname = ?, city = ?, province = ?, country = ?, birthYear = ?, bio = ?, photo = ? WHERE idGrandma = ?";
        const [result] = await conn.query(update, [
            data.name, 
            data.lastname, 
            data.city, 
            data.province, 
            data.country, 
            data.birthYear, 
            data.bio, 
            data.photo,
            idGrandma,
        ]);
        await conn.end();
        if(result.affectedRows > 0){
            res.status(200).json({ 
                success: true,
                message: result.affectedRows + ' fields updated'
             });
        }else{
            res.status(400).json({ 
                success: false, 
                message: 'That id does not exist in our data base' 
            });
        }
    }catch(error){
        res.status(400).json(error);
    }
})

//delete grandma
api.delete('/grandma/:id', async (req, res) => {
    try{
        const conn = await getConnection();
        const idGrandma = req.params.id;
        const deleteSQL = "DELETE FROM grandmas WHERE idGrandma = ?";
        const [result] = await conn.query(deleteSQL, [idGrandma]);
        await conn.end();
        if(result.affectedRows > 0){
            res.status(200).json({ 
                success: true,
                message: `The row with idGrandma = ${idGrandma} has been deleted.`
             });
        }else{
            res.status(400).json({ 
                success: false, 
                message: 'That id does not exist in our data base' 
            });
        }
    }catch(error){
        res.status(400).json(error);
    }
})

