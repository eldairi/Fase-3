import { pool } from '../db.js';  // Asegúrate de tener el pool configurado para la base de datos
import express from 'express';

const router = express.Router();

// Ruta para obtener todos los módulos
router.get('/', async (req, res) => {
  try {
    // Consulta SQL para obtener los módulos
    const [rows] = await pool.query('SELECT ID_MODULO, NOM_MODULO FROM MODULO');
    
    // Verifica que los datos lleguen correctamente
    console.log('Módulos obtenidos:', rows);
    
    // Devuelve los módulos como respuesta en formato JSON
    res.json(rows);  
  } catch (err) {
    // Si hay un error, lo manejamos y devolvemos un mensaje adecuado
    console.error('Error al obtener módulos:', err);
    res.status(500).json({ error: 'Error al obtener los datos de módulos' });
  }
});

export default router;
