USE Ventas_Tech_DB;
-- MÓDULO 4: CONSULTAS SQL DE NEGOCIO


-- Consulta 1: Resumen ejecutivo mensual

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- Consulta 2: Ranking de productos

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3: Clientes recurrentes

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- Consulta 4: Meses por encima o por debajo del promedio

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_mensual)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mensual
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS resumen_mensual
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- Hallazgo 1: Durante el mes 3 se registraron 10 pedidos con una facturación total de 6444.00.
-- Hallazgo 2: El producto con id_producto = 1 fue el que generó la mayor facturación, con un total de 3600.00.
-- Hallazgo 3: Todos los clientes registrados realizaron 2 pedidos. El cliente con id_cliente = 1 fue el que más gastó, con un total de 2640.00.