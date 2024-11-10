import express from 'express';
import cors from 'cors';
import path from 'path';
import { fileURLToPath } from 'url';

// Importar las rutas de la API
import clientesRoute from './routes/clientes.js';
import modulosRoute from './routes/modulos.js';
import severidadesRoute from './routes/severidades.js';
import ticketsRoute from './routes/tickets.js'; // Ruta para tickets

const app = express();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(cors());
app.use(express.json());

// Servir los archivos estáticos desde la carpeta 'front'
app.use(express.static(path.join(__dirname, 'front')));

// Usar las rutas de la API
app.use('/api/clientes', clientesRoute);
app.use('/api/modulos', modulosRoute);
app.use('/api/severidades', severidadesRoute);
app.use('/api/tickets', ticketsRoute); // Aquí usamos las rutas de tickets.js

// Configuración del servidor
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor escuchando en el puerto ${PORT}`);
});
