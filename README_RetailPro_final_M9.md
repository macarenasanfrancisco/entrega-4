# RetailPro

## Descripción del proyecto

RetailPro es un proyecto de análisis de datos orientado al estudio de información de ventas para obtener insights comerciales y desarrollar un flujo de trabajo de datos de principio a fin.

El proyecto integra distintas etapas: construcción y consulta de una base de datos, análisis mediante SQL, procesos ETL con Power Query, modelado en Power BI, desarrollo de medidas DAX, validación de resultados y diseño de un dashboard.

## Objetivo

El objetivo principal es transformar datos de ventas en información útil para el análisis y la toma de decisiones comerciales, combinando herramientas de bases de datos, transformación de datos y Business Intelligence.

## Herramientas utilizadas

- **SQL Server:** creación y consulta de la base de datos y análisis de ventas.
- **Power Query:** limpieza, transformación y preparación de los datos mediante procesos ETL.
- **Power BI:** modelado de datos, medidas DAX, validación y visualización.
- **GitHub:** almacenamiento, organización y documentación del proyecto.

## Etapas del proyecto

El trabajo se desarrolla de forma progresiva:

1. **Construcción de la base de datos:** creación de tablas y carga de información de clientes, productos, categorías y ventas.
2. **Análisis SQL:** elaboración de consultas de análisis y consultas con `JOIN` para integrar información de distintas tablas.
3. **ETL:** limpieza, transformación y preparación de los datos con Power Query.
4. **Modelado:** construcción de un modelo relacional para análisis en Power BI.
5. **Análisis temporal:** creación y utilización de una tabla calendario.
6. **DAX:** creación de medidas para ventas, ventas online, acumulados YTD, comparación con el año anterior y crecimiento anual.
7. **Validación:** comprobación de los resultados mediante una matriz de validación.
8. **Dashboard:** diseño de visualizaciones orientadas a comunicar los principales resultados comerciales.
9. **Uso de IA:** revisión de consultas SQL, generación de insights, documentación y reflexión crítica sobre el uso de inteligencia artificial.

## Estructura del repositorio

El repositorio está organizado por módulos correspondientes a las distintas etapas del proyecto:

```text
Pipeline_ETL_Dataset/
├── M1/
├── M2/
├── M3/
├── M4/
├── M5/
├── M6/
├── M7/
├── M8/
└── M9/
```

Cada módulo contiene los archivos y entregables correspondientes a la etapa desarrollada.

## Ejecución de las consultas SQL

Las consultas SQL se ejecutan utilizando **SQL Server Management Studio (SSMS)**.

Pasos generales:

1. Abrir SQL Server Management Studio.
2. Conectarse a la instancia de SQL Server utilizada para el proyecto.
3. Seleccionar la base de datos correspondiente al proyecto.
4. Ejecutar primero los scripts de creación y carga de datos cuando corresponda.
5. Ejecutar las consultas de análisis incluidas en los módulos.

Entre los scripts desarrollados se encuentran consultas de análisis de ventas y consultas con `INNER JOIN` para relacionar ventas con clientes, productos, categorías y territorios.

## Flujo de trabajo en Power BI

Power BI se utiliza para transformar el resultado del proceso ETL en un modelo analítico.

Las principales tablas del modelo son:

- **Dim_Clientes**
- **Dim_Productos**
- **Dim_Categorias**
- **Dim_Fechas**
- **Fact_Ventas**

A partir de este modelo se crean medidas DAX y visualizaciones para analizar la información.

Entre las medidas desarrolladas se encuentran:

- `Total Ventas`
- `Ventas Online`
- `Ventas YTD`
- `Ventas LY`
- `% Crecimiento Anual`

También se utiliza una tabla calendario para realizar análisis temporales y comparar períodos.

## Resultados y análisis

El proyecto permite analizar distintos aspectos de las ventas, entre ellos:

- evolución temporal de las ventas;
- desempeño de productos;
- comportamiento de clientes;
- ventas por canal;
- indicadores acumulados y comparaciones interanuales;
- crecimiento porcentual;
- validación de resultados mediante matrices y tablas.

Los resultados obtenidos se utilizan como base para generar insights comerciales y desarrollar un dashboard orientado a la toma de decisiones.

## Documentación

La documentación se encuentra organizada dentro del repositorio de GitHub junto con los scripts, archivos de trabajo y entregables de cada módulo.

La documentación incluye tanto aspectos técnicos del proceso de datos como decisiones tomadas durante la limpieza, transformación, modelado y análisis.

## Conclusión

RetailPro integra SQL, procesos ETL, modelado dimensional, DAX y visualización en un flujo de trabajo completo de análisis de datos. El proyecto busca mostrar cómo un conjunto de datos puede transformarse progresivamente en información útil para comprender el negocio y apoyar decisiones comerciales.
