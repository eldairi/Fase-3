import { pool } from '../db.js';
import express from 'express';
const router = express.Router();

// Ruta para obtener los clientes disponibles (respuestas fijas)
router.get('/clientes', async (req, res) => {
  try {
    const [clientes] = await pool.query('SELECT * FROM CLIENTES');
    res.status(200).json(clientes);
  } catch (err) {
    console.error('Error al obtener clientes:', err);
    res.status(500).json({ error: 'Error al obtener los clientes' });
  }
});

// Ruta para obtener los módulos disponibles
router.get('/modulos', async (req, res) => {
  try {
    const [modulos] = await pool.query('SELECT * FROM MODULOS');
    res.status(200).json(modulos);
  } catch (err) {
    console.error('Error al obtener módulos:', err);
    res.status(500).json({ error: 'Error al obtener los módulos' });
  }
});

// Ruta para obtener las severidades disponibles
router.get('/severidades', async (req, res) => {
  try {
    const [severidades] = await pool.query('SELECT * FROM SEVERIDADES');
    res.status(200).json(severidades);
  } catch (err) {
    console.error('Error al obtener severidades:', err);
    res.status(500).json({ error: 'Error al obtener las severidades' });
  }
});

// Ruta para crear un nuevo ticket y una transacción
router.post('/', async (req, res) => {
  try {
    const { cliente, descripcionBreve, descripcionDetallada, modulo, severidad } = req.body;

    // Verificar si todos los datos están presentes
    if (!cliente || !descripcionBreve || !descripcionDetallada || !modulo || !severidad) {
      return res.status(400).json({ error: 'Faltan campos requeridos.' });
    }

    // Insertar el ticket en la base de datos
    const [ticketResult] = await pool.query(
      `INSERT INTO TICKET (ID_CLIENTE, FEC_CREACION, DESC_DETALLADA, DESC_BREVE)
       VALUES (?, NOW(), ?, ?)`, 
      [cliente, descripcionDetallada, descripcionBreve]
    );

    const ticketId = ticketResult.insertId;

    // Verificar que los IDs de módulo y severidad sean válidos
    const [moduloResult] = await pool.query('SELECT * FROM MODULO WHERE ID_MODULO = ?', [modulo]);
    const [severidadResult] = await pool.query('SELECT * FROM SEVERIDAD WHERE ID_SEVERIDAD = ?', [severidad]);

    if (!moduloResult.length || !severidadResult.length) {
      return res.status(400).json({ error: 'Módulo o severidad no válidos.' });
    }

    // Insertar la transacción para el ticket
    const estadoId = 1; // Ejemplo de ID de estado
    const accionId = 1; // Ejemplo de ID de acción
    const transaccionCompletaId = null;
    const duenoTransaccionId = 1; // Ejemplo de ID de dueño de la transacción

    await pool.query(
      `INSERT INTO TRANSAC_ORIGINAL 
      (ID_TICKET, FEC_INI_TRANS, FEC_TER_TRANS, TIEMPO_TOTAL_TRANS, ID_ESTADO, ID_ACCION, ID_TRANS_COMPL, ID_DUENO_TRANS)
      VALUES (?, NOW(), NULL, NULL, ?, ?, ?, ?)`,
      [ticketId, estadoId, accionId, transaccionCompletaId, duenoTransaccionId]
    );

    // Responder con el nuevo ticket creado
    res.status(201).json({
      message: "Ticket y transacción creados exitosamente",
      ticketId: ticketId
    });
  } catch (error) {
    console.error("Error al crear el ticket:", error);
    res.status(500).json({
      error: "Hubo un problema al crear el ticket",
      message: error.message
    });
  }
});

export default router;
