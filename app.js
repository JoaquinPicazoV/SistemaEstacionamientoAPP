// app.js
const { Pool } = require('pg');
var express = require('express');
var app = express();
require('dotenv').config();

let { PGHOST, PGDATABASE, PGUSER, PGPASSWORD } = process.env;
const pool = new Pool({
  host: PGHOST,
  database: PGDATABASE,
  username: PGUSER,
  password: PGPASSWORD,
  port: 5432,
  ssl: {
    require: true,
  },
});
async function getPgVersion() {
  const client = await pool.connect();
  try {
    const result = await client.query('SELECT version()');
    console.log(result.rows[0]);
  } finally {
    client.release();
  }
}

//getter edificio
app.get('/edificio/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM edificio');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter estacionamiento
app.get('/estacionamiento/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM estacionamiento');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter guardia
app.get('/guardia/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM guardia');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter registrousuariovehiculo
app.get('/registrousuariovehiculo/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM registrousuariovehiculo');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter reserva
app.get('/reserva/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM reserva');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter seccion
app.get('/seccion/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM seccion');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter usuario
app.get('/usuario/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM usuario');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

//getter vehiculo
app.get('/vehiculo/get', async (req, res)=>{
  try {
    const { rows } = await pool.query('SELECT * FROM vehiculo');
    res.json(rows);
  } catch (error) {
    console.error('Error executing query', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.listen(3000, () => {
  console.log('Server is running on port 3000');
});
getPgVersion();