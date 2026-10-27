/*============SECCIÓN 6 — Procedimientos almacenados ===========   */
 
/*1.  Crea un procedimiento almacenado llamado SP_REGISTRAR_PRESTAMO que 
reciba como parámetros de entrada: 
 
●  p_RUT_EST (RUT del estudiante) 
●  p_COD_LIBRO (Código del libro) 
●  p_RUT_FUNC (RUT del funcionario) 
●  p_FECHA_P (Fecha del préstamo) 
 
El procedimiento debe: 
 
a.  Verificar si el libro ya está prestado (opcional, si quieres hacerlo más 
complejo). 
b.  Si no lo está, insertar el nuevo registro en la tabla PRESTAMO con la fecha 
de entrega (FECHA_E) como NULL o la fecha actual + 7 días (según tu regla 
de negocio). 
c.  Mostrar un mensaje de éxito: "Préstamo registrado correctamente".*/

DELIMITER //

CREATE PROCEDURE SP_REGISTRAR_PRESTAMO (
    IN p_RUT_EST INT,
    IN p_COD_LIBRO INT,
    IN p_RUT_FUNC INT,
    IN p_FECHA_P DATE
)
BEGIN
    DECLARE v_libro_prestado INT;

    -- Verificar si el libro ya está prestado
    SELECT COUNT(*) INTO v_libro_prestado
    FROM PRESTAMO
    WHERE COD_LIBRO = p_COD_LIBRO
      AND FECHA_ENTREGA >= p_FECHA_P;

    IF v_libro_prestado > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El libro ya está prestado';
    ELSE
        -- Insertar el nuevo registro en la tabla PRESTAMO
        INSERT INTO PRESTAMO (RUT_ESTUDIANTE, RUT_FUNCIONARIO, COD_LIBRO, FECHA_PRESTAMO, FECHA_ENTREGA)
        VALUES (p_RUT_EST, p_RUT_FUNC, p_COD_LIBRO, p_FECHA_P, DATE_ADD(p_FECHA_P, INTERVAL 7 DAY));

        -- Mostrar mensaje de éxito
        SELECT 'Préstamo registrado correctamente' AS mensaje;
    END IF;
END//

DELIMITER ;