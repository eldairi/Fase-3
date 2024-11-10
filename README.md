## Integrantes /Parte Fase 3
- Fernanda Durandeau Cerda: Parte 1 
- Bruno Roque Mendoza: Parte 2
- Sebastián Bravo Brito: Parte 3
- Abraham Silva: Parte 4


# Sistema de Gestión de Tickets

Este proyecto es una aplicación para gestionar tickets, creada en Node.js con Express y MySQL. Proporciona funcionalidades para crear y modificar tickets.

## Configuración e Instalación

1. Clona este repositorio.
2. Asegúrate de tener MySQL y Node.js instalados en tu máquina.
3. Configura la base de datos:
   - Crea una base de datos MySQL usando `db/esquema.sql`.
   - Inserta los datos de ejemplo desde `db/datos.sql`.
4. Configura tus credenciales de MySQL en `db.js`.

## Comandos

- Para instalar dependencias:
  ```bash
  npm install

- Para ejecutar la app en modo desarrollo:
  npm start

### Probar el Proyecto

1. **Instala las dependencias:** Ejecuta `npm install`.
2. **Inicia el servidor:** Ejecuta `npm start` y ve a `http://localhost:3000`.
3. **Prueba la funcionalidad:** Usa los enlaces en `index.html` para navegar a `pagina1.html` (crear ticket) y `pagina2.html` (modificar ticket).

