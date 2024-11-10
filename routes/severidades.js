import { pool } from '../db.js';
import express from 'express';
const router = express.Router();

router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM SEVERIDAD');
    res.json(rows);  // Devuelve los resultados en formato JSON
  } catch (err) {
    console.error('Error al obtener severidades:', err);
    res.status(500).json({ error: 'Error al obtener los datos de severidades' });
  }
});

export default router;
