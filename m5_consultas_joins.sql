/*=========================================================
    MÓDULO 5 - CONSULTAS CON JOINS
    Base de datos: Ventas_Tech_DB
    Motor: SQL Server
=========================================================*/

USE Ventas_Tech_DB;
GO


/*=========================================================
    PARTE 1 - ACTUALIZACIÓN DE LA BASE

    Se agregan los campos y la tabla necesarios para
    poder realizar las consultas solicitadas en M5.
=========================================================*/


-- ==========================================
-- AGREGAR SEGMENTO A CLIENTES
-- ==========================================

IF COL_LENGTH('clientes', 'segmento') IS NULL
BEGIN
    ALTER TABLE clientes
    ADD segmento VARCHAR(50);
END;
GO


-- Asignamos un segmento a cada cliente

UPDATE clientes
SET segmento = CASE id_cliente
    WHEN 1 THEN 'Premium'
    WHEN 2 THEN 'Regular'
    WHEN 3 THEN 'Premium'
    WHEN 4 THEN 'Regular'
    WHEN 5 THEN 'Regular'
END;
GO


-- ==========================================
-- CREAR TABLA TERRITORIOS
-- ==========================================

IF OBJECT_ID('territorios', 'U') IS NULL
BEGIN
    CREATE TABLE territorios (
        id_territorio INT PRIMARY KEY,
        region VARCHAR(50) NOT NULL,
        pais VARCHAR(50) NOT NULL,
        zona VARCHAR(50)
    );
END;
GO


-- Cargamos los territorios solamente si todavía no existen

IF NOT EXISTS (SELECT 1 FROM territorios)
BEGIN
    INSERT INTO territorios VALUES
    (1, 'Buenos Aires', 'Argentina', 'Centro'),
    (2, 'Córdoba', 'Argentina', 'Centro'),
    (3, 'Litoral', 'Argentina', 'Este'),
    (4, 'Cuyo', 'Argentina', 'Oeste'),
    (5, 'Noroeste', 'Argentina', 'Norte');
END;
GO


-- ==========================================
-- AGREGAR TERRITORIO A VENTAS
-- ==========================================

IF COL_LENGTH('ventas', 'id_territorio') IS NULL
BEGIN
    ALTER TABLE ventas
    ADD id_territorio INT;
END;
GO


-- Asignamos un territorio a cada venta

UPDATE ventas
SET id_territorio = CASE id_venta
    WHEN 1 THEN 1
    WHEN 2 THEN 2
    WHEN 3 THEN 3
    WHEN 4 THEN 1
    WHEN 5 THEN 4
    WHEN 6 THEN 2
    WHEN 7 THEN 5
    WHEN 8 THEN 3
    WHEN 9 THEN 4
    WHEN 10 THEN 5
END;
GO


-- Crear la Foreign Key solamente si todavía no existe

IF NOT EXISTS (
    SELECT 1
    FROM sys.foreign_keys
    WHERE name = 'FK_ventas_territorios'
)
BEGIN
    ALTER TABLE ventas
    ADD CONSTRAINT FK_ventas_territorios
    FOREIGN KEY (id_territorio)
    REFERENCES territorios(id_territorio);
END;
GO


-- ==========================================
-- AGREGAR CANAL A VENTAS
-- ==========================================

IF COL_LENGTH('ventas', 'canal') IS NULL
BEGIN
    ALTER TABLE ventas
    ADD canal VARCHAR(20);
END;
GO


-- Asignamos canal a las ventas

UPDATE ventas
SET canal = CASE
    WHEN id_venta IN (1, 3, 5, 7, 9) THEN 'Online'
    ELSE 'Presencial'
END;
GO



/*=========================================================
    CONSULTA 1
    VISTA BASE DEL PROYECTO - INNER JOIN
=========================================================*/

SELECT
    v.fecha_venta AS fecha,
    c.nombre AS cliente,
    c.segmento,
    t.region,
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta,
    v.canal
FROM ventas v
INNER JOIN clientes c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos p
    ON v.id_producto = p.id_producto
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
INNER JOIN territorios t
    ON v.id_territorio = t.id_territorio
ORDER BY v.fecha_venta;
GO



/*=========================================================
    CONSULTA 2
    CLIENTES SIN VENTAS - LEFT JOIN
=========================================================*/

SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;
GO



/*=========================================================
    CONSULTA 3
    PRODUCTOS SIN VENTAS - LEFT JOIN
=========================================================*/

SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
INNER JOIN categorias cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;
GO



/*=========================================================
    CONSULTA 4
    CONSOLIDADO POR CANAL - UNION ALL
=========================================================*/

SELECT
    canal,
    SUM(total_venta) AS total_por_canal
FROM
(
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

) AS ventas_por_canal

GROUP BY canal;
GO