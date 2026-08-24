# Pipeline_ETL_Dataset

Pre-entrega del Módulo 6 del curso de Data Analytics (Coderhouse).

## Objetivo

Construir un proceso ETL en Power BI para limpiar y transformar un dataset antes de utilizarlo en el análisis y la creación de dashboards.

## Herramientas utilizadas

- Power BI
- Power Query
- Lenguaje M

## Transformaciones realizadas

- Eliminación de registros duplicados en clientes y productos.
- Reemplazo de valores nulos por "Sin dato" cuando correspondía.
- Reemplazo del precio nulo por 0 para mantener la integridad del modelo.
- Corrección de tipos de datos.
- Renombrado de tablas con el formato `Dim_` y `Fact_`.
- Merge entre `Fact_Ventas` y `Dim_Productos`.
- Documentación de las transformaciones mediante comentarios en el Editor Avanzado.

## Archivos del repositorio

- `Pipeline_ETL_Macarena_SanFrancisco.pbix`: proyecto desarrollado en Power BI con todas las transformaciones realizadas.
