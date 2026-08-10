USE Ventas_Tech_DB;

ALTER TABLE clientes
ADD segmento VARCHAR(50);

UPDATE clientes
SET segmento = 'Minorista'
WHERE id_cliente = 1;

UPDATE clientes
SET segmento = 'Mayorista'
WHERE id_cliente = 2;

UPDATE clientes
SET segmento = 'Minorista'
WHERE id_cliente = 3;

UPDATE clientes
SET segmento = 'Mayorista'
WHERE id_cliente = 4;

UPDATE clientes
SET segmento = 'Minorista'
WHERE id_cliente = 5;

CREATE TABLE territorios (
    id_territorio INT PRIMARY KEY,
    region VARCHAR(50) NOT NULL
);

INSERT INTO territorios VALUES (1, 'Norte');
INSERT INTO territorios VALUES (2, 'Centro');
INSERT INTO territorios VALUES (3, 'Sur');

ALTER TABLE clientes
ADD id_territorio INT;

UPDATE clientes
SET id_territorio = 1
WHERE id_cliente = 1;

UPDATE clientes
SET id_territorio = 2
WHERE id_cliente = 2;

UPDATE clientes
SET id_territorio = 3
WHERE id_cliente = 3;

UPDATE clientes
SET id_territorio = 2
WHERE id_cliente = 4;

UPDATE clientes
SET id_territorio = 1
WHERE id_cliente = 5;

ALTER TABLE clientes
ADD FOREIGN KEY (id_territorio)
REFERENCES territorios(id_territorio);

ALTER TABLE ventas
ADD canal VARCHAR(20);

UPDATE ventas
SET canal = 'Online'
WHERE id_venta IN (1, 3, 5, 7, 9);

UPDATE ventas
SET canal = 'Presencial'
WHERE id_venta IN (2, 4, 6, 8, 10);