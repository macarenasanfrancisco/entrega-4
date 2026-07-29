USE Ventas_Tech_DB;
GO

/* =========================================================
   PRE-ENTREGA: CONSULTAS SQL DE NEGOCIO

   Título: Extrayendo métricas clave con SQL
   Proyecto: RetailPro
   Motor: SQL Server
   ========================================================= */


/* =========================================================
   CONSULTA 1 — RESUMEN EJECUTIVO MENSUAL

   Se calcula:
   - Total facturado por mes.
   - Cantidad de pedidos por mes.
   - Ticket promedio por pedido.
   ========================================================= */

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;
GO


/* =========================================================
   CONSULTA 2 — RANKING DE PRODUCTOS

   Se muestran los 5 productos que más facturaron.
   También se calcula la cantidad de unidades vendidas.
   ========================================================= */

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;
GO


/* =========================================================
   CONSULTA 3 — CLIENTES RECURRENTES

   Se muestran los clientes que realizaron más de un pedido.
   ========================================================= */

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;
GO


/* =========================================================
   CONSULTA 4 — MESES POR ENCIMA O POR DEBAJO DEL PROMEDIO

   Primero se calcula la facturación por mes.
   Luego se compara cada mes con el promedio mensual general.
   ========================================================= */

WITH facturacion_mensual AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
),
promedio_general AS (
    SELECT
        AVG(total_facturado) AS promedio_mensual
    FROM facturacion_mensual
)
SELECT
    fm.mes,
    fm.total_facturado,
    pg.promedio_mensual,
    CASE
        WHEN fm.total_facturado > pg.promedio_mensual
            THEN 'Por encima'
        WHEN fm.total_facturado < pg.promedio_mensual
            THEN 'Por debajo'
        ELSE 'Igual al promedio'
    END AS comparacion_con_promedio
FROM facturacion_mensual AS fm
CROSS JOIN promedio_general AS pg
ORDER BY fm.mes;
GO


/* =========================================================
   HALLAZGOS DE NEGOCIO

   1. La facturación total de marzo fue de 6444.00,
      distribuida en 10 pedidos, con un ticket promedio
      de 644.40.

   2. El producto con id_producto = 1 generó 3600.00
      y concentró aproximadamente el 55.87 % de la
      facturación total.

   3. Todos los clientes realizaron dos pedidos.
      El cliente con id_cliente = 1 fue quien más gastó,
      con un total acumulado de 2640.00.
   ========================================================= */