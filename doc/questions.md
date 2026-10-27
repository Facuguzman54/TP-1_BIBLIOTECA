# Sección 8 — Preguntas teóricas

## 1. Clave primaria compuesta de `PRESTAMO`

La tabla `PRESTAMO` utiliza una clave primaria compuesta por:

```text
RUT_ESTUDIANTE
RUT_FUNCIONARIO
COD_LIBRO
```

Estas columnas también funcionan como claves foráneas hacia `ESTUDIANTE`,
`FUNCIONARIO` y `LIBRO`. La combinación identifica de forma única un préstamo
según el modelo actual.

La clave primaria compuesta evita que se repita exactamente la misma
combinación de estudiante, funcionario y libro. Por ejemplo, no se podría
insertar dos veces:

```text
RUT_ESTUDIANTE = 12345678
RUT_FUNCIONARIO = 11111111
COD_LIBRO = 1
```

Sin embargo, esta estructura tiene una limitación: no permite registrar dos
préstamos históricos del mismo libro realizados por el mismo estudiante y
atendidos por el mismo funcionario, aunque hayan ocurrido en fechas
diferentes. En la vida real, un estudiante podría pedir el mismo libro varias
veces, siempre que lo haya devuelto antes o que se trate de un nuevo préstamo.

Un modelo más completo normalmente utilizaría un identificador propio, por
ejemplo `ID_PRESTAMO`, como clave primaria. También incluiría estados o fechas
que permitan diferenciar cada operación:

```text
ID_PRESTAMO
RUT_ESTUDIANTE
RUT_FUNCIONARIO
COD_LIBRO
FECHA_PRESTAMO
FECHA_ENTREGA
ESTADO
```

De esta manera, el mismo estudiante podría pedir el mismo libro varias veces
en diferentes momentos. En este modelo académico, la clave compuesta simplifica
la estructura y evita duplicar exactamente la misma relación, pero no representa
completamente el historial real de préstamos.

## 2. Eliminación de una `CARRERA` con estudiantes asociados

Si se intenta eliminar una carrera que tiene estudiantes asociados, la base de
datos debería impedir la operación y devolver un error de integridad
referencial.

La tabla `ESTUDIANTE` contiene la clave foránea `ID_CARRERA`, que referencia a
`CARRERA(ID_CARRERA)`. Mientras existan estudiantes relacionados, eliminar la
carrera dejaría referencias inválidas.

La restricción protege la consistencia de los datos. No sería correcto que un
estudiante continuara registrado con un `ID_CARRERA` que ya no existe.

Una alternativa sería actualizar previamente los estudiantes para asignarlos a
otra carrera y luego eliminar la carrera. Otra posibilidad es utilizar
`ON DELETE CASCADE`, pero no sería recomendable en este caso porque eliminaría
automáticamente todos los estudiantes asociados. Para datos académicos,
normalmente conviene conservar la información y desactivar la carrera, en vez
de borrarla físicamente.

## 3. Autor en una tabla separada

El autor se encuentra en una tabla independiente porque puede tener varios
libros. Separar `AUTOR` de `LIBRO` evita repetir sus datos personales en cada
registro:

```text
AUTOR
RUT_AUTOR
NOMBRE
APELLIDO
```

La tabla `LIBRO` almacena únicamente la referencia mediante `RUT_AUTOR`.

Esta separación ofrece varias ventajas:

- Evita duplicar el nombre y apellido del autor.
- Reduce inconsistencias en los datos.
- Permite actualizar el nombre de un autor en un solo lugar.
- Facilita consultar todos los libros de un autor.
- Mantiene el modelo normalizado.

En este modelo, la relación es de uno a muchos: un autor puede tener varios
libros y cada libro tiene un autor.

En un sistema más completo, un libro también podría tener varios autores. En
ese caso, la relación sería de muchos a muchos y se necesitaría una tabla
intermedia, por ejemplo:

```text
LIBRO_AUTOR
COD_LIBRO
RUT_AUTOR
```

## 4. Relación entre `CAMPUS` y `CIUDAD`

La relación entre `CIUDAD` y `CAMPUS` es de uno a muchos:

```text
CIUDAD 1 ─── N CAMPUS
```

Una ciudad puede tener varios campus, pero cada campus pertenece a una sola
ciudad.

Esto se representa mediante la clave foránea `ID_CIUDAD` en la tabla `CAMPUS`:

```sql
FOREIGN KEY (ID_CIUDAD) REFERENCES CIUDAD(ID_CIUDAD)
```

Por ejemplo, una ciudad podría tener un campus central, uno de ingeniería y
otro de medicina. Todos pertenecerían a la misma ciudad, pero cada campus
tendría su propio registro e identificador.

No es una relación muchos a muchos porque el modelo no permite que un mismo
campus pertenezca simultáneamente a varias ciudades. Tampoco es uno a uno,
porque una ciudad sí puede tener más de un campus.