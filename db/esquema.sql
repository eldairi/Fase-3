-- Crear base de datos
CREATE DATABASE db; -- Creación de base de datos
USE db; -- Usando la base de datos

-- Crear tabla SEVERIDAD
CREATE TABLE SEVERIDAD (
    ID_SEVERIDAD INT PRIMARY KEY AUTO_INCREMENT,
    NOM_SEVERIDAD VARCHAR(100) NOT NULL,  -- Nombre de la severidad (crítica, alta, normal, baja)
    DESC_SEVERIDAD VARCHAR(1000)          -- Descripción de la severidad
);

-- Crear tabla CLIENTE
CREATE TABLE CLIENTE (
    ID_CLIENTE INT PRIMARY KEY AUTO_INCREMENT,
    NOM_CLIENTE VARCHAR(100) NOT NULL     -- Nombre del cliente
);

-- Crear tabla MODULO
CREATE TABLE MODULO (
    ID_MODULO INT PRIMARY KEY AUTO_INCREMENT,
    NOM_MODULO VARCHAR(100) NOT NULL      -- Nombre del módulo
);

-- Crear tabla TICKET
CREATE TABLE TICKET (
    ID_TICKET INT PRIMARY KEY AUTO_INCREMENT,
    ID_CLIENTE INT,
    FEC_CREACION DATE,                    -- Fecha de creación del ticket
    FEC_CIERRE DATE,                      -- Fecha de cierre del ticket
    DESC_DETALLADA VARCHAR(1000),         -- Descripción detallada del ticket
    DESC_BREVE VARCHAR(100),              -- Descripción breve del ticket
    FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
);

-- Crear tabla ESTADO
CREATE TABLE ESTADO (
    ID_ESTADO INT PRIMARY KEY AUTO_INCREMENT,
    NOM_EST_TICKET VARCHAR(100) NOT NULL  -- Nombre del estado del ticket
);

-- Crear tabla ESTADO_TICKET
CREATE TABLE ESTADO_TICKET (
    ID_ESTADO INT,
    ID_TICKET INT,
    FEC_INI_ESTADO DATE,                  -- Fecha de inicio del estado en el ticket
    FEC_TER_ESTADO DATE,                  -- Fecha de término del estado en el ticket
    PRIMARY KEY (ID_ESTADO, ID_TICKET, FEC_INI_ESTADO),
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO),
    FOREIGN KEY (ID_TICKET) REFERENCES TICKET(ID_TICKET)
);

-- Crear tabla SEVERIDAD_TICKET
CREATE TABLE SEVERIDAD_TICKET (
    ID_SEVERIDAD INT,
    ID_TICKET INT,
    FEC_INI_SEVERIDAD DATE,               -- Fecha de inicio de la severidad
    FEC_TER_SEVERIDAD DATE,               -- Fecha de término de la severidad
    PRIMARY KEY (ID_SEVERIDAD, ID_TICKET, FEC_INI_SEVERIDAD),
    FOREIGN KEY (ID_SEVERIDAD) REFERENCES SEVERIDAD(ID_SEVERIDAD),
    FOREIGN KEY (ID_TICKET) REFERENCES TICKET(ID_TICKET)
);

-- Crear tabla MODULO_TICKET
CREATE TABLE MODULO_TICKET (
    ID_MODULO INT,
    ID_TICKET INT,
    FEC_INI_MODULO DATE,                  -- Fecha de inicio del módulo en el ticket
    FEC_TER_MODULO DATE,                  -- Fecha de término del módulo en el ticket
    PRIMARY KEY (ID_MODULO, ID_TICKET, FEC_INI_MODULO),
    FOREIGN KEY (ID_MODULO) REFERENCES MODULO(ID_MODULO),
    FOREIGN KEY (ID_TICKET) REFERENCES TICKET(ID_TICKET)
);

-- Crear tabla ACCION_FINAL_TRANS
CREATE TABLE ACCION_FINAL_TRANS (
    ID_ACCION INT PRIMARY KEY AUTO_INCREMENT,
    NOM_ACCION VARCHAR(100) NOT NULL      -- Nombre de la acción final de la transacción
);

-- Crear tabla TRANS_COMPL
CREATE TABLE TRANS_COMPL (
    ID_TRANS_COMPL INT PRIMARY KEY AUTO_INCREMENT,
    NOM_TRANS_COMPL VARCHAR(100) NOT NULL -- Nombre de la transacción completa
);

-- Crear tabla DUEÑO_TRANS
CREATE TABLE DUEÑO_TRANS (
    ID_DUENO_TRANS INT PRIMARY KEY AUTO_INCREMENT,
    NOM_DUENO_TRANS VARCHAR(100) NOT NULL -- Nombre del dueño de la transacción
);

-- Crear tabla MOD_CALCULO
CREATE TABLE MOD_CALCULO (
    ID_MOD_CAL INT PRIMARY KEY AUTO_INCREMENT,
    NOM_MOD_CAL VARCHAR(100) NOT NULL     -- Nombre de la modalidad de cálculo (24x7, hábil)
);

-- Crear tabla TRANSAC_ORIGINAL
CREATE TABLE TRANSAC_ORIGINAL (
    ID_TRANS_OR INT PRIMARY KEY AUTO_INCREMENT,
    ID_ESTADO INT,
    ID_ACCION INT,
    ID_TRANS_COMPL INT,
    ID_DUENO_TRANS INT,
    ID_TICKET INT,
    FEC_INI_TRANS DATE,                   -- Fecha de inicio de la transacción
    FEC_TER_TRANS DATE,                   -- Fecha de término de la transacción
    TIEMPO_TOTAL_TRANS INT,               -- Tiempo total de la transacción
    FOREIGN KEY (ID_ESTADO) REFERENCES ESTADO(ID_ESTADO),
    FOREIGN KEY (ID_ACCION) REFERENCES ACCION_FINAL_TRANS(ID_ACCION),
    FOREIGN KEY (ID_TRANS_COMPL) REFERENCES TRANS_COMPL(ID_TRANS_COMPL),
    FOREIGN KEY (ID_DUENO_TRANS) REFERENCES DUEÑO_TRANS(ID_DUENO_TRANS),
    FOREIGN KEY (ID_TICKET) REFERENCES TICKET(ID_TICKET)
);

-- Crear tabla TRANSAC_CALCULO
CREATE TABLE TRANSAC_CALCULO (
    ID_TRANS_ACT INT PRIMARY KEY AUTO_INCREMENT,
    ID_TRANS_ANT INT,
    ID_MOD_CAL INT,
    ID_TRANS_OR INT,
    FEC_INI_TRANS_DU DATE,                -- Fecha de inicio de la transacción duplicada
    FEC_TER_TRANS_DU DATE,                -- Fecha de término de la transacción duplicada
    FEC_INI_CLIENTE DATE,                 -- Fecha de inicio en cliente
    FEC_TER_CLIENTE DATE,                 -- Fecha de término en cliente
    TIEMPO_CONS_TRANS INT,                -- Tiempo consumido en la transacción
    TIEMPO_REST_BOLSA INT,                -- Tiempo restante en la bolsa
    FOREIGN KEY (ID_TRANS_ANT) REFERENCES TRANSAC_ORIGINAL(ID_TRANS_OR),
    FOREIGN KEY (ID_MOD_CAL) REFERENCES MOD_CALCULO(ID_MOD_CAL),
    FOREIGN KEY (ID_TRANS_OR) REFERENCES TRANSAC_ORIGINAL(ID_TRANS_OR)
);


