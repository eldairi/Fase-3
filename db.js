import mysql from 'mysql2/promise';

// Crear la conexión a la base de datos
export const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: '1234',
  database: 'db',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
});
