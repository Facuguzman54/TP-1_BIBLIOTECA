
/*
===============SECCIÓN 2 —  Consultas SELECT==========================
*/
/*
1.  Muestra el título y el año de todos los libros registrados, ordenados desde el más 
antiguo al más nuevo
*/
SELECT TITULO,ANIO FROM LIBRO ORDER BY ANIO ASC;

/*
2.  Obtén el nombre, apellido y edad de todos los estudiantes mayores de 25 años
*/
SELECT NOMBRE,APELLIDO,EDAD FROM ESTUDIANTE WHERE EDAD>25;

/*
3. Muestra el título y el año de los libros que pertenecen a la editorial con ID_EDIT = 3. 
*/
SELECT TITULO, ANIO FROM LIBRO WHERE ID_EDITORIAL = 3;

/*
4. Lista todos los datos de los autores cuyo apellido comience con la letra "M  
*/

SELECT AUTOR.* FROM AUTOR WHERE  APELLIDO LIKE 'M%';

/*
 
5.  Muestra el nombre y apellido de los funcionarios que tengan una salud distinta a 
"Saludable" .
*/

SELECT NOMBRES, APELLIDO FROM FUNCIONARIO WHERE SALUD <> 'Saludable';

/*
6.  Muestra el título del libro junto con el nombre y apellido de su autor. 
*/

SELECT
    l.TITULO,
    a.NOMBRE AS NOMBRE_AUTOR,
    a.APELLIDO AS APELLIDO_AUTOR
FROM LIBRO AS l
JOIN AUTOR AS a
    ON l.RUT_AUTOR = a.RUT_AUTOR;

/*
7. Realiza una consulta que muestre:
    a. Fecha de préstamo (FECHA_P)
    b. Nombre del Estudiante (NOMBRES + APELLIDOS)
    c. Título del Libro (TITULO)
    d. Nombre del Funcionario que atendió (NOMBRES + APELLIDOS).
*/

SELECT 
    p.FECHA_PRESTAMO,
    CONCAT(e.NOMBRE, ' ', e.APELLIDO) AS NOMBRE_ESTUDIANTE,
    l.TITULO AS TITULO_LIBRO,
    CONCAT(f.NOMBRES, ' ', f.APELLIDO) AS NOMBRE_FUNCIONARIO
FROM PRESTAMO AS p
JOIN ESTUDIANTE AS e
    ON p.RUT_ESTUDIANTE = e.RUT_ESTUDIANTE
JOIN LIBRO AS l
    ON p.COD_LIBRO = l.COD_LIBRO
JOIN FUNCIONARIO AS f
    ON p.RUT_FUNCIONARIO = f.RUT_FUNCIONARIO;

/*
8. Muestra el nombre del estudiante, su carrera y la ciudad donde estudia.
*/

SELECT 
    e.NOMBRE AS NOMBRE_ESTUDIANTE,
    c.NOMBRE AS NOMBRE_CARRERA,
    ci.NOMBRE AS NOMBRE_CIUDAD
    FROM ESTUDIANTE AS e
    JOIN CARRERA AS c ON e.ID_CARRERA = c.ID_CARRERA
    JOIN CAMPUS AS camp ON c.ID_CAMPUS = camp.ID_CAMPUS
    JOIN CIUDAD AS ci ON camp.ID_CIUDAD = ci.ID_CIUDAD;


/*
9. Lista los títulos de los libros junto con el nombre de la editorial y el país de origen.
*/
SELECT
    l.TITULO,
    edi.NOMBRE AS NOMBRE_EDITORIAL,
    edi.PAIS AS PAIS_EDITORIAL
FROM LIBRO AS l
JOIN EDITORIAL AS edi
    ON l.ID_EDITORIAL = edi.ID_EDITORIAL;

/*
10. Muestra el título del libro y el nombre de la biblioteca donde se encuentra físicamente.
*/
SELECT 
    l.TITULO,
    b.NOMBRE AS NOMBRE_BIBLIOTECA
    FROM LIBRO AS l
    JOIN BIBLIOTECA AS b ON l.ID_BIBLIOTECA = b.ID_BIBLIOTECA;

/*
11. ¿Cuántos libros hay registrados por cada tipo?
    Muestra el nombre del tipo y la cantidad.
*/
SELECT 
    t.TIPO_DESCRIPCION AS NOMBRE_TIPO,
    COUNT(l.COD_LIBRO) AS CANTIDAD_LIBROS
FROM TIPO AS t
LEFT JOIN LIBRO AS l ON t.ID_TIPO = l.ID_TIPO
GROUP BY t.TIPO_DESCRIPCION;

/*
12. Calcula la edad promedio de los estudiantes por cada carrera.
*/
SELECT c.NOMBRE AS NOMBRE_CARRERA, 
AVG(e.EDAD) AS EDAD_PROMEDIO
FROM CARRERA AS c
JOIN ESTUDIANTE AS e ON c.ID_CARRERA = e.ID_CARRERA
GROUP BY c.NOMBRE;

/*
13. Muestra el nombre del funcionario y cuántos préstamos ha realizado en total
    (ordenado de mayor a menor).
*/
SELECT CONCAT(f.NOMBRES, ' ', f.APELLIDO) AS NOMBRE_FUNCIONARIO,
COUNT(p.RUT_FUNCIONARIO) AS TOTAL_PRESTAMOS
FROM FUNCIONARIO AS f
LEFT JOIN PRESTAMO AS p ON f.RUT_FUNCIONARIO = p.RUT_FUNCIONARIO
GROUP BY f.RUT_FUNCIONARIO, f.NOMBRES, f.APELLIDO
ORDER BY TOTAL_PRESTAMOS DESC;

/*
14. Lista los autores que tienen más de 1 libro registrado en el sistema.
*/

SELECT a.NOMBRE, a.APELLIDO, COUNT(l.COD_LIBRO) AS CANTIDAD_LIBROS
FROM AUTOR AS a
JOIN LIBRO AS l ON a.RUT_AUTOR = l.RUT_AUTOR
GROUP BY a.RUT_AUTOR, a.NOMBRE, a.APELLIDO
HAVING CANTIDAD_LIBROS > 1;


/*
15. Muestra el nombre de la ciudad y la cantidad de estudiantes que viven allí.
*/
SELECT ci.NOMBRE AS NOMBRE_CIUDAD, COUNT(e.RUT_ESTUDIANTE) AS CANTIDAD_ESTUDIANTES
FROM CIUDAD AS ci
LEFT JOIN CAMPUS AS camp ON ci.ID_CIUDAD = camp.ID_CIUDAD 
JOIN CARRERA AS c ON camp.ID_CAMPUS = c.ID_CAMPUS
JOIN ESTUDIANTE AS e ON c.ID_CARRERA = e.ID_CARRERA
GROUP BY ci.NOMBRE;


/*
16. Muestra el título y año del libro más antiguo de la biblioteca.
*/
SELECT TITULO, ANIO FROM LIBRO 
WHERE ANIO = (SELECT MIN(ANIO) FROM LIBRO);

/*
17. Lista los estudiantes que nunca han pedido un libro prestado.
*/
SELECT e.NOMBRE, e.APELLIDO
FROM ESTUDIANTE AS e
LEFT JOIN PRESTAMO AS p ON e.RUT_ESTUDIANTE = p.RUT_ESTUDIANTE
WHERE p.RUT_ESTUDIANTE IS NULL; 

/*
18. Libros nunca prestados:
    Muestra los títulos de los libros que no aparecen en la tabla PRESTAMO.
*/
SELECT l.TITULO
FROM LIBRO AS l
LEFT JOIN PRESTAMO AS p ON l.COD_LIBRO = p.COD_LIBRO
WHERE p.COD_LIBRO IS NULL; 


/*
19. Muestra los préstamos realizados el mes anterior.
*/

SELECT *
FROM PRESTAMO
WHERE FECHA_PRESTAMO >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH)
  AND FECHA_PRESTAMO < CURDATE();

/*
20. Muestra los 3 libros más prestados de la biblioteca.
*/

SELECT l.TITULO, COUNT(p.COD_LIBRO) AS CANTIDAD_PRESTAMOS
FROM LIBRO AS l 
JOIN PRESTAMO AS p ON l.COD_LIBRO = p.COD_LIBRO
GROUP BY l.COD_LIBRO, l.TITULO
ORDER BY CANTIDAD_PRESTAMOS DESC
LIMIT 3;    



/*
===============SECCIÓN 3 — OPERACIONES DML==========================
*/

/*
1. Nuevo estudiante:
   Inserta un nuevo estudiante en la tabla ESTUDIANTES.
   Asume un RUT_EST nuevo, inventa los datos y asígnale una carrera existente.
*/

INSERT INTO ESTUDIANTE (RUT_ESTUDIANTE, NOMBRE, APELLIDO, EDAD, TELEFONO ,DIRECCION,ID_CARRERA)
VALUES (98765432, 'Lucía', 'González', 22,'264555555','Calle Falsa 321', 2);


/*
2. Actualizar salud:
   Actualiza la columna SALUD a "Excelente" para todos los funcionarios que
   tengan más de 50 años.
*/

UPDATE FUNCIONARIO
SET SALUD = 'Excelente'
WHERE EDAD > 50;    


/*
3. Borrar libro:
   Elimina un libro específico de la tabla LIBROS, asumiendo que no tiene
   préstamos asociados para evitar errores de integridad referencial.
*/

DELETE FROM LIBRO
WHERE COD_LIBRO = 7; 

/*
4. Cambio de editorial:
   Actualiza el ID_EDIT de un libro específico porque la editorial cambió de
   dueño.
*/
UPDATE LIBRO
SET ID_EDITORIAL = 2
WHERE COD_LIBRO = 6; 
