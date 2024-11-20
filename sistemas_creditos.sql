-- Crear la base de datos
CREATE DATABASE sistema_creditos;
DROP DATABASE IF exists sistema_creditos;

USE sistema_creditos;

-- Tabla para los solicitantes
CREATE TABLE solicitante (
    id_solicitante INT AUTO_INCREMENT PRIMARY KEY, -- Llave primaria que se va a autoincrementar
    nombre VARCHAR(100) NOT NULL, -- Nombre del solicitante
    rfc VARCHAR(13) NOT NULL UNIQUE, -- RFC único
    fecha_nacimiento DATE NOT NULL, -- Fecha de nacimiento
    ingresos_mensuales DECIMAL(10, 2) -- Ingresos mensuales
);

-- Tabla para el historial de créditos
CREATE TABLE historial_creditos (
    id_credito INT AUTO_INCREMENT PRIMARY KEY, -- Llave primaria
    id_solicitante INT NOT NULL, -- Relación con solicitante
    fecha_credito DATE NOT NULL, -- Fecha del crédito
    importe DECIMAL(10, 2) NOT NULL, -- Importe solicitado
    aprobado BOOLEAN NOT NULL, -- Estado del crédito
    FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante) ON DELETE CASCADE ON UPDATE CASCADE -- Si se actualiza/elimina un solicitante, sus créditos también se actualizan o eliminan
);

-- Tabla para solicitudes de crédito
CREATE TABLE solicitud_credito (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY, -- Llave primaria
    id_solicitante INT NOT NULL, -- Relación con solicitante
    importe_solicitado DECIMAL(10, 2) NOT NULL, -- Importe solicitado
    fecha_solicitud DATE NOT NULL, -- Fecha de la solicitud
    estatus VARCHAR(20) NOT NULL DEFAULT 'En proceso', -- Estatus de la solicitud
    razon_rechazo VARCHAR(255), -- Razón del rechazo (opcional esto sería colocado por alguien desde la petición que recibe el sistema)
    FOREIGN KEY (id_solicitante) REFERENCES solicitante(id_solicitante) ON DELETE CASCADE ON UPDATE CASCADE -- Si el solicitante se elimina o actualiza, las solicitudes también se afectan
);

-- Tabla para límites de crédito según ingresos
CREATE TABLE limites_credito (
    id_limite INT AUTO_INCREMENT PRIMARY KEY, -- Llave primaria
    rango_min_ingresos DECIMAL(10, 2) NOT NULL, -- Rango mínimo de ingresos
    rango_max_ingresos DECIMAL(10, 2) NOT NULL, -- Rango máximo de ingresos
    max_historial DECIMAL(10, 2) NOT NULL, -- Importe máximo con historial crediticio
    max_sin_historial DECIMAL(10, 2) NOT NULL -- Importe máximo sin historial crediticio
);

-- Se insertaran los valores para los límites de crédito
INSERT INTO limites_credito (rango_min_ingresos, rango_max_ingresos, max_historial, max_sin_historial)
VALUES 
    (5000.00, 9999.99, 15000.00, 7500.00),
    (10000.00, 19999.99, 25000.00, 12000.00),
    (20000.00, 39999.99, 50000.00, 30000.00),
    (40000.00, 999999.99, 100000.00, 50000.00);
    
-- probamos el script haciendo una consulta:
SELECT * FROM limites_credito;


-- ------APARTADO DE CONSULTAS DE PRUEBA------------
SHOW TABLES;

SELECT * FROM solicitante;


