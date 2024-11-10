import { pool } from '../db.js';
import express from 'express';
const router = express.Router();

// Ruta para obtener todos los clientes
router.get('/', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM CLIENTE');
    res.json(rows);  // Devuelve los resultados en formato JSON
  } catch (err) {
    console.error('Error al obtener clientes:', err);
    res.status(500).json({ error: 'Error al obtener los datos de clientes' });
  }
});

export default router;  // Exportar la ruta para usarla en app.js
