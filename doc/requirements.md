# Descripción del modelo de datos

## 1. Descripción general

El modelo representa el sistema de gestión de una biblioteca académica. Permite
organizar la información de las ciudades, campus, carreras, estudiantes,
funcionarios, autores, editoriales, tipos de publicaciones, bibliotecas y
libros.

Además, registra los préstamos de libros realizados por los estudiantes y
atendidos por los funcionarios. De esta forma, el sistema permite conocer qué
libro fue prestado, quién lo solicitó, qué funcionario registró el préstamo y
qué fechas corresponden al retiro y a la entrega.

## 2. Qué representa cada entidad

- **CIUDAD**: ciudades donde se encuentran los campus.
- **CAMPUS**: sedes físicas asociadas a una ciudad.
- **CARRERA**: carreras académicas ofrecidas en un campus.
- **ESTUDIANTE**: personas que estudian una carrera y pueden solicitar libros.
- **FUNCIONARIO**: personas que trabajan en un campus y registran los
  préstamos.
- **AUTOR**: autores de los libros registrados.
- **EDITORIAL**: editoriales responsables de publicar los libros, incluyendo su
  país de origen.
- **TIPO**: clasificación de los libros, por ejemplo, libro de texto, libro de
  referencia o libro de investigación.
- **BIBLIOTECA**: bibliotecas donde se encuentran físicamente los libros.
- **LIBRO**: publicaciones disponibles para ser consultadas o prestadas.
- **PRESTAMO**: registro de la relación entre un estudiante, un funcionario y
  un libro, junto con las fechas del préstamo y de entrega.

## 3. Relaciones entre las entidades

El modelo utiliza claves foráneas para mantener la integridad referencial:

- Una **ciudad** puede tener varios campus. Cada campus pertenece a una sola
  ciudad.
- Un **campus** puede ofrecer varias carreras. Cada carrera pertenece a un
  solo campus.
- Una **carrera** puede tener varios estudiantes. Cada estudiante pertenece a
  una sola carrera.
- Un **campus** puede tener varios funcionarios. Cada funcionario trabaja en
  un solo campus.
- Un **autor** puede tener varios libros. Cada libro tiene un autor.
- Una **editorial** puede publicar varios libros. Cada libro pertenece a una
  editorial.
- Un **tipo** puede clasificar varios libros. Cada libro tiene un tipo.
- Una **biblioteca** puede contener varios libros. Cada libro se encuentra
  asociado a una biblioteca.
- Un **estudiante** puede realizar varios préstamos. Cada préstamo pertenece a
  un estudiante.
- Un **funcionario** puede registrar varios préstamos. Cada préstamo es
  atendido por un funcionario.
- Un **libro** puede aparecer en varios préstamos a lo largo del tiempo. Cada
  préstamo corresponde a un libro.

## 4. Relación inversa

La relación inversa permite consultar la información desde el lado opuesto de
una asociación. Por ejemplo:

- Desde un **estudiante** se pueden consultar sus préstamos.
- Desde un **préstamo** se puede identificar al estudiante que solicitó el
  libro.
- Desde un **libro** se pueden consultar su autor, editorial, tipo, biblioteca
  y todos sus préstamos.
- Desde un **autor** se pueden consultar todos sus libros.
- Desde una **biblioteca** se pueden consultar todos los libros que contiene.
- Desde una **ciudad** se pueden consultar sus campus, carreras y estudiantes
  asociados a esos campus.

En términos de cardinalidad, las relaciones principales son:

```text
CIUDAD     1 ─── N CAMPUS
CAMPUS     1 ─── N CARRERA
CARRERA    1 ─── N ESTUDIANTE
CAMPUS     1 ─── N FUNCIONARIO
AUTOR      1 ─── N LIBRO
EDITORIAL  1 ─── N LIBRO
TIPO       1 ─── N LIBRO
BIBLIOTECA 1 ─── N LIBRO
ESTUDIANTE 1 ─── N PRESTAMO
FUNCIONARIO 1 ── N PRESTAMO
LIBRO      1 ─── N PRESTAMO
```

La tabla `PRESTAMO` funciona como entidad asociativa entre estudiantes,
funcionarios y libros. Su clave primaria compuesta está formada por:

```text
RUT_ESTUDIANTE
RUT_FUNCIONARIO
COD_LIBRO
```

Por lo tanto, no se puede repetir exactamente la misma combinación de
estudiante, funcionario y libro.

## 5. Requerimientos funcionales

El sistema debe permitir:

1. Registrar ciudades y asociarlas con sus campus.
2. Registrar campus y relacionarlos con las carreras que ofrecen.
3. Registrar carreras y asociarlas con los estudiantes correspondientes.
4. Registrar estudiantes con sus datos personales y carrera.
5. Registrar funcionarios y el campus donde trabajan.
6. Registrar autores y relacionarlos con sus libros.
7. Registrar editoriales junto con su país de origen.
8. Clasificar los libros según un tipo.
9. Registrar bibliotecas y asociarles los libros que contienen.
10. Registrar libros con su título, año, autor, editorial, tipo y biblioteca.
11. Registrar préstamos indicando el estudiante, funcionario, libro, fecha de
    préstamo y fecha de entrega.
12. Consultar los libros ordenados por año de publicación.
13. Consultar estudiantes según su edad y carrera.
14. Consultar libros por editorial, autor, tipo o biblioteca.
15. Consultar préstamos junto con los datos del estudiante, funcionario y
    libro.
16. Calcular la cantidad de libros por tipo.
17. Calcular la edad promedio de los estudiantes por carrera.
18. Contabilizar los préstamos realizados por cada funcionario.
19. Identificar autores con más de un libro registrado.
20. Identificar estudiantes que nunca solicitaron un libro.
21. Identificar libros que nunca fueron prestados.
22. Consultar los préstamos realizados durante un período determinado.
23. Obtener los libros más prestados de la biblioteca.

## 6. Requerimientos no funcionales

### Integridad y consistencia

- Cada entidad debe tener una clave primaria única.
- Las claves foráneas deben hacer referencia a registros existentes.
- No se deben permitir valores nulos en los atributos definidos como
  obligatorios.
- No se deben registrar préstamos para estudiantes, funcionarios o libros
  inexistentes.
- La combinación definida como clave primaria de `PRESTAMO` no debe repetirse.

### Rendimiento

- Las consultas frecuentes sobre claves primarias y foráneas deben poder
  ejecutarse eficientemente.
- Se deben utilizar índices cuando el volumen de datos lo justifique,
  especialmente en columnas utilizadas para búsquedas y relaciones.

### Disponibilidad y persistencia

- La base de datos debe ejecutarse en MySQL mediante Docker Compose.
- Los datos deben conservarse aunque el contenedor se detenga o se reinicie.
- La información debe poder respaldarse y restaurarse.

### Mantenibilidad

- Los scripts SQL deben estar separados por responsabilidad: creación,
  inserciones, consultas, alteraciones, índices, vistas, triggers,
  procedimientos y permisos.
- Los nombres de tablas y columnas deben ser consistentes y descriptivos.
- Las consultas y scripts deben incluir comentarios cuando sea necesario para
  facilitar su comprensión.

### Seguridad y control de acceso

- El acceso a la base debe requerir autenticación.
- Se deben poder definir usuarios y permisos diferenciados para tareas
  administrativas y de consulta.
- Las operaciones de modificación de datos deberían limitarse a usuarios
  autorizados.

### Portabilidad

- Los scripts deben utilizar sintaxis compatible con MySQL.
- La configuración de conexión debe poder modificarse mediante variables de
  entorno.