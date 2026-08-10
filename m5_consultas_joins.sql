USE Ventas_Tech_DB;

-- Consulta 1: Vista base del proyecto

SELECT
    v.fecha_venta AS fecha,
    c.nombre AS cliente,
    c.segmento,
    t.region,
    p.nombre_producto,
    ca.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias ca
    ON p.id_categoria = ca.id_categoria
INNER JOIN territorios t
    ON c.id_territorio = t.id_territorio;

    -- Consulta 2: Clientes sin ventas

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Consulta 3: Productos sin ventas

SELECT
    p.nombre_producto,
    c.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
INNER JOIN categorias c
    ON p.id_categoria = c.id_categoria
WHERE v.id_producto IS NULL;

-- Consulta 4: Consolidado por canal

SELECT
    canal,
    SUM(total_venta) AS total_por_canal
FROM (
    SELECT
        'Online' AS canal,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Online'

    UNION ALL

    SELECT
        'Presencial' AS canal,
        cantidad * precio_unitario AS total_venta
    FROM ventas
    WHERE canal = 'Presencial'
) AS ventas_consolidadas
GROUP BY canal;