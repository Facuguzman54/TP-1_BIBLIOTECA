/* ==================== ENTIDAD: CIUDAD ==================== */
INSERT INTO CIUDAD (ID_CIUDAD, NOMBRE)
VALUES
    (1, 'San Juan'),
    (2, 'Mendoza'),
    (3, 'San Luis'),
    (4, 'La Rioja'),
    (5, 'Catamarca');

/* ==================== ENTIDAD: CAMPUS ==================== */
INSERT INTO CAMPUS (ID_CAMPUS, NOMBRE, ID_CIUDAD)
VALUES
    (1, 'Campus San Juan', 1),
    (2, 'Campus Mendoza', 2),
    (3, 'Campus San Luis', 3),
    (4, 'Campus La Rioja', 4),
    (5, 'Campus Catamarca', 5);

/* ==================== ENTIDAD: CARRERA ==================== */
INSERT INTO CARRERA (ID_CARRERA, NOMBRE, ID_CAMPUS)
VALUES
    (1, 'Ingeniería en Sistemas', 1),
    (2, 'Licenciatura en Administración', 2),
    (3, 'Arquitectura', 3),
    (4, 'Medicina', 4),
    (5, 'Derecho', 5);

/* ==================== ENTIDAD: ESTUDIANTE ==================== */
INSERT INTO ESTUDIANTE (
    RUT_ESTUDIANTE,
    NOMBRE,
    APELLIDO,
    EDAD,
    TELEFONO,
    DIRECCION,
    ID_CARRERA
)
VALUES
    (12345678, 'Juan', 'Pérez', 31, '123456789', 'Calle Falsa 123', 1),
    (23456789, 'María', 'González', 22, '987654321', 'Avenida Siempre Viva 456', 2),
    (34567890, 'Pedro', 'López', 25, '456789123', 'Calle Real 789', 3),
    (45678901, 'Ana', 'Martínez', 23, '321654987', 'Avenida Central 101', 4),
    (56789012, 'Luis', 'Rodríguez', 26, '654987321', 'Calle Secundaria 202', 5);

/* ==================== ENTIDAD: FUNCIONARIO ==================== */
INSERT INTO FUNCIONARIO (
    RUT_FUNCIONARIO,
    NOMBRES,
    APELLIDO,
    EDAD,
    DIRECCION,
    SALUD,
    ID_CAMPUS
)
VALUES
    (11111111, 'Carlos', 'García', 35, 'Calle Principal 1', 'Saludable', 1),
    (22222222, 'Laura', 'Fernández', 40, 'Avenida Secundaria 2', 'Saludable', 2),
    (33333333, 'Jorge', 'Ramírez', 45, 'Calle Terciaria 3', 'Saludable', 3),
    (44444444, 'Sofía', 'Torres', 54, 'Avenida Cuarta 4', 'Hipertensión', 4),
    (55555555, 'Diego', 'Vargas', 50, 'Calle Quinta 5', 'Saludable', 5);

/* ==================== ENTIDAD: AUTOR ==================== */
INSERT INTO AUTOR (RUT_AUTOR, NOMBRE, APELLIDO)
VALUES
    (11111111, 'Martín', 'Sosa'),
    (22222222, 'Laura', 'Méndez'),
    (33333333, 'Ricardo', 'Paredes'),
    (44444444, 'Sofía', 'Navarro'),
    (55555555, 'Diego', 'Ferreyra');

/* ==================== ENTIDAD: EDITORIAL ==================== */
INSERT INTO EDITORIAL (ID_EDITORIAL, NOMBRE, PAIS)
VALUES
    (1, 'Editorial Académica del Sur', 'Argentina'),
    (2, 'Ediciones Ciencia y Tecnología', 'Chile'),
    (3, 'Editorial Universitaria Central', 'México'),
    (4, 'Ediciones Técnicas del Plata', 'Uruguay'),
    (5, 'Editorial Investigación Aplicada', 'Colombia');

/* ==================== ENTIDAD: TIPO ==================== */
INSERT INTO TIPO (ID_TIPO, TIPO_DESCRIPCION)
VALUES
    (1, 'Libro de Texto'),
    (2, 'Libro de Referencia'),
    (3, 'Libro de Investigación'),
    (4, 'Libro de Divulgación'),
    (5, 'Libro de Ensayo');

/* ==================== ENTIDAD: BIBLIOTECA ==================== */
INSERT INTO BIBLIOTECA (ID_BIBLIOTECA, NOMBRE)
VALUES
    (1, 'Biblioteca Central'),
    (2, 'Biblioteca de Ciencias Sociales'),
    (3, 'Biblioteca de Ingeniería'),
    (4, 'Biblioteca de Medicina'),
    (5, 'Biblioteca de Derecho');

/* ==================== ENTIDAD: LIBRO ==================== */
INSERT INTO LIBRO (
    COD_LIBRO,
    TITULO,
    ANIO,
    ID_BIBLIOTECA,
    ID_TIPO,
    RUT_AUTOR,
    ID_EDITORIAL
)
VALUES
    (1, 'Fundamentos de Bases de Datos', 2021, 1, 2, 11111111, 1),
    (2, 'Introducción a la Programación', 2020, 2, 2, 22222222, 2),
    (3, 'Matemática Discreta para Informática', 2022, 3, 1, 33333333, 3),
    (4, 'Administración y Gestión de Organizaciones', 2019, 4, 5, 44444444, 4),
    (5, 'Metodología de la Investigación', 2023, 5, 3, 55555555, 5),
    (6, 'Estructuras de Datos', 2018, 3, 4, 11111111, 4),
    (7, 'Algoritmos y Complejidad', 2024, 3, 1, 22222222, 3),
    (8, 'Redes de Computadoras', 2021, 3, 2, 33333333, 2),
    (9, 'Inteligencia Artificial', 2020, 3, 3, 44444444, 1),
    (10, 'Seguridad Informática', 2022, 3, 4, 55555555, 5);
/* ==================== ENTIDAD: PRESTAMO ==================== */
INSERT INTO PRESTAMO (
    RUT_ESTUDIANTE,
    RUT_FUNCIONARIO,
    COD_LIBRO,
    FECHA_PRESTAMO,
    FECHA_ENTREGA
)
VALUES
    (12345678, 11111111, 1, '2026-09-05', '2026-09-15'),
    (23456789, 22222222, 1, '2026-09-06', '2026-09-16'),
    (34567890, 33333333, 1, '2026-09-07', '2026-09-17'),
    (12345678, 11111111, 2, '2026-09-08', '2026-09-18'),
    (23456789, 22222222, 2, '2026-09-09', '2026-09-19'),
    (34567890, 33333333, 3, '2026-09-10', '2026-09-20'),
    (45678901, 44444444, 4, '2026-09-11', '2026-09-21'),
    (56789012, 55555555, 5, '2026-10-01', '2026-10-15');