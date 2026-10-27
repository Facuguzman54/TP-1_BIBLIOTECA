/*SECCIÓN 4 — Vistas*/
 
/*1. Crea una vista llamada VW_PRESTAMOS_DETALLE que muestre de forma "amigable" 
la información de los préstamos. En lugar de mostrar los RUTs y códigos numéricos, debe 
mostrar: 
a.  Fecha del préstamo. 
b.  Nombre completo del estudiante (Nombres + Apellidos). 
c.  Título del libro. 
d.  Nombre completo del funcionario que entregó el libro. 
e.  Nombre de la carrera del estudiante. 
f.  Pista: Requiere unir 4 o 5 tablas. */

CREATE VIEW VW_PRESTAMOS_DETALLE AS
SELECT p.FECHA_PRESTAMO AS FECHA_PRESTAMO,
       CONCAT(e.nombre, ' ', e.apellido) AS NOMBRE_COMPLETO_ESTUDIANTE,
       l.titulo AS TITULO_LIBRO,
       CONCAT(f.nombres, ' ', f.apellido) AS NOMBRE_COMPLETO_FUNCIONARIO,
       c.nombre AS NOMBRE_CARRERA
FROM PRESTAMO AS p
JOIN ESTUDIANTE AS e ON p.RUT_ESTUDIANTE = e.RUT_ESTUDIANTE
JOIN LIBRO AS l ON p.COD_LIBRO = l.COD_LIBRO
JOIN FUNCIONARIO AS f ON p.RUT_FUNCIONARIO = f.RUT_FUNCIONARIO
JOIN CARRERA AS c ON e.ID_CARRERA = c.ID_CARRERA;   

SELECT * FROM VW_PRESTAMOS_DETALLE;

 
/*2. Crea una vista llamada VW_LIBROS_POR_BIBLIOTECA que muestre el nombre de la 
biblioteca, la ciudad donde está (si aplica) y la cantidad total de libros que posee. Esto le 
servirá al administrador para ver rápidamente qué sede tiene más material.*/

CREATE VIEW VW_LIBROS_POR_BIBLIOTECA AS
SELECT b.nombre AS NOMBRE_BIBLIOTECA,
         COUNT(l.cod_libro) AS CANTIDAD_TOTAL_LIBROS
FROM BIBLIOTECA AS b
LEFT JOIN LIBRO AS l ON b.id_biblioteca = l.id_biblioteca   
GROUP BY b.nombre;

SELECT * FROM VW_LIBROS_POR_BIBLIOTECA;
/*
NOTA:
No se puede determinar la ciudad de la biblioteca
porque el DER no define una relación entre BIBLIOTECA y CIUDAD.
El préstamo permite llegar a la ciudad del estudiante o del funcionario,
pero no prueba la ubicación de la biblioteca.
*/