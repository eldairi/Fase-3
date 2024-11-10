-- Usar la base de datos
USE db;

-- Insertar datos en CLIENTE
INSERT INTO CLIENTE (ID_CLIENTE, NOM_CLIENTE) VALUES
(1, 'TelNova Chile'),
(2, 'TelNova Ecuador'),
(3, 'TelNova México'),
(4, 'TelNova Colombia'),
(5, 'TelNova Nicaragua');

-- Insertar datos en TICKET
INSERT INTO TICKET (ID_TICKET, ID_CLIENTE, FEC_CREACION, DESC_BREVE, DESC_DETALLADA) VALUES
(249083, 1, '2010-09-23 00:00:00', 'Error postventa', 'El sistema de postventa no está generando informes para el cliente. Este problema se presenta de forma intermitente y afecta la consulta de ventas realizadas.'),
(250897, 2, '2011-08-15 00:00:00', 'Error en facturación', 'Al procesar facturas, el sistema muestra errores al conectar con el módulo de pagos. Los clientes no pueden procesar sus pagos a tiempo.'),
(249090, 3, '2010-10-11 00:00:00', 'Problema crítico en ventas', 'El módulo de ventas no permite registrar nuevas órdenes. Este error afecta la entrada de datos y el procesamiento de pedidos en tiempo real.'),
(250950, 4, '2011-09-07 00:00:00', 'Retrasos en cobranza', 'Las facturas de cobranza se generan de manera inconsistente, provocando retrasos en la emisión y problemas de flujo de caja.'),
(267890, 5, '2012-03-21 00:00:00', 'Error en postventa', 'El sistema de postventa no muestra el historial de pedidos para clientes. Algunos usuarios no pueden ver sus órdenes pasadas ni el estado de entregas.');

-- Insertar datos en MODULO
INSERT INTO MODULO (ID_MODULO, NOM_MODULO) VALUES
(1, 'Postventa'),
(2, 'Facturacion'),
(3, 'Ventas'),
(4, 'Cobranza'),
(5, 'Atencion Clientes'),
(6, 'Beneficios y Promociones'),
(7, 'Comisiones'),
(8, 'Correspondencia'),
(9, 'Evaluacion de Riesgo'),
(10, 'Ficha Retenciones'),
(11, 'Gestion de Documentos'),
(12, 'Logistica'),
(13, 'Recaudacion y Cajas'),
(14, 'Reclamos'),
(15, 'Reportes'),
(16, 'Servicio Tecnico');

-- Insertar datos en SEVERIDAD
INSERT INTO SEVERIDAD (ID_SEVERIDAD, NOM_SEVERIDAD, DESC_SEVERIDAD) VALUES
(1, 'Crítica', 'Incidencia crítica que afecta el funcionamiento general'),
(2, 'Alta', 'Incidencia alta que afecta la mayoría de funciones'),
(3, 'Normal', 'Incidencia que afecta parcialmente'),
(4, 'Baja', 'Incidencia menor con bajo impacto');

-- Insertar datos en ESTADO
INSERT INTO ESTADO (ID_ESTADO, NOM_EST_TICKET) VALUES
(1, 'Trabajando en solución'),
(2, 'Esperando Aceptación del Cliente'),
(3, 'Solicitando Información'),
(4, 'Probando Beta'),
(5, 'Cerrada');

-- Insertar datos en SEVERIDAD_TICKET
INSERT INTO SEVERIDAD_TICKET (ID_SEVERIDAD, ID_TICKET, FEC_INI_SEVERIDAD) VALUES
(3, 249083, '2010-09-23 17:09:10'),
(2, 250897, '2011-08-15 22:00:01'),
(1, 249090, '2010-10-11 09:29:59'),
(4, 250950, '2011-09-07 13:34:08'),
(4, 267890, '2012-03-21 15:45:09');

-- Insertar datos en MODULO_TICKET
INSERT INTO MODULO_TICKET (ID_MODULO, ID_TICKET, FEC_INI_MODULO) VALUES
(1, 249083, '2010-09-23 17:09:10'),  -- Postventa
(2, 250897, '2011-08-15 22:00:01'),  -- Facturación
(3, 249090, '2010-10-11 09:29:59'),  -- Ventas
(4, 250950, '2011-09-07 13:34:08'),  -- Cobranza
(1, 267890, '2012-03-21 15:45:09');  -- Postventa

-- Insertar datos en TRANSAC_ORIGINAL
INSERT INTO TRANSAC_ORIGINAL (ID_TRANS_OR, ID_TICKET, FEC_INI_TRANS, FEC_TER_TRANS, ID_ESTADO, ID_ACCION, ID_DUENO_TRANS, ID_TRANS_COMPL) VALUES
(1, 250897, '2011-08-15 22:00:01', '2011-08-16 12:00:45', 1, 1, 1, 1),
(2, 250897, '2011-08-16 12:00:46', '2011-08-19 23:43:09', 3, 2, 2, 1),
(3, 250897, '2011-08-19 23:43:10', '2011-08-20 15:09:29', 1, 3, 1, 1),
(4, 250897, '2011-08-20 15:09:30', '2011-08-25 19:43:37', 4, 4, 2, 1),
(5, 250897, '2011-08-25 19:43:38', '2011-08-26 11:15:15', 1, 5, 1, 1),
(6, 250897, '2011-08-26 11:15:16', '2011-09-05 17:56:32', 2, 2, 2, 1),
(7, 250897, '2011-09-05 17:56:33', '2011-09-05 19:01:08', 1, 5, 1, 1),
(8, 249083, '2010-09-23 17:09:10', '2010-09-30 23:25:04', 1, 3, 1, 1),
(9, 249083, '2010-09-30 23:25:05', '2010-10-16 08:39:47', 4, 4, 2, 1),
(10, 267890, '2012-03-21 15:45:09', '2012-03-21 16:59:34', 1, 5, 1, 1),
(11, 267890, '2012-03-21 16:59:35', '2012-03-31 23:13:48', 2, 6, 2, 1);

-- Insertar datos en ACCION_FINAL_TRANS
INSERT INTO ACCION_FINAL_TRANS (ID_ACCION, NOM_ACCION) VALUES
(1, 'Solicitar Información'),
(2, 'Responder Información'),
(3, 'Envío de script de regularización'),
(4, 'Envío de resultados del script'),
(5, 'Envío de Respuesta'),
(6, 'Rechazar'),
(7, 'Envío de Beta'),
(8, 'Aceptar');

-- Insertar datos en TRANS_COMPL
INSERT INTO TRANS_COMPL (ID_TRANS_COMPL, NOM_TRANS_COMPL) VALUES
(1, 'COMPLETE'),
(2, 'ELEGIBLE');

-- Insertar datos en DUEÑO_TRANS
INSERT INTO DUEÑO_TRANS (ID_DUENO_TRANS, NOM_DUENO_TRANS) VALUES
(1, 'Proveedor'),
(2, 'Cliente');

-- Modificar las columnas para asegurar el tipo de dato DATETIME
ALTER TABLE TICKET
MODIFY FEC_CREACION DATETIME,
MODIFY FEC_CIERRE DATETIME;

ALTER TABLE SEVERIDAD_TICKET
MODIFY FEC_INI_SEVERIDAD DATETIME,
MODIFY FEC_TER_SEVERIDAD DATETIME;

ALTER TABLE MODULO_TICKET
MODIFY FEC_INI_MODULO DATETIME,
MODIFY FEC_TER_MODULO DATETIME;

ALTER TABLE ESTADO_TICKET
MODIFY FEC_INI_ESTADO DATETIME,
MODIFY FEC_TER_ESTADO DATETIME;

ALTER TABLE TRANSAC_ORIGINAL
MODIFY FEC_INI_TRANS DATETIME,
MODIFY FEC_TER_TRANS DATETIME;
