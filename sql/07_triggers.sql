/*=========SECCIÓN 5 — Triggers=========*/ 

/*
1.  Crea un Trigger llamado TR_AUDITAR_PRESTAMO que se dispare después de 
insertar un nuevo registro en la tabla PRESTAMO. Este trigger debe insertar un 
registro en una nueva tabla llamada AUDITORIA_PRESTAMOS (que deberás crear 
antes) con los siguientes datos: 
 
●  ID_AUDITORIA (autoincremental) 
●  RUT_EST (del préstamo insertado) 
●  COD_LIBRO (del préstamo insertado) 
●  FECHA_REGISTRO (la fecha y hora actual del sistema) 
●  ACCION (un texto que diga "NUEVO PRÉSTAMO") 
 */


CREATE TRIGGER TR_AUDITAR_PRESTAMO
AFTER INSERT ON PRESTAMO
FOR EACH ROW
BEGIN
    INSERT INTO AUDITORIA_PRESTAMO (
        RUT_EST,
        COD_LIBRO,
        FECHA_REGISTRO,
        ACCION
    )
    VALUES (
        NEW.RUT_ESTUDIANTE,
        NEW.COD_LIBRO,
        CURRENT_TIMESTAMP,
        'NUEVO PRÉSTAMO'
    );
END



/*2.  Crea un Trigger llamado TR_VALIDAR_EDAD_ESTUDIANTE que se dispare antes 
de insertar o actualizar un estudiante en la tabla ESTUDIANTES. Si la edad del 
estudiante es menor a 17 años, el trigger debe cancelar la operación y lanzar un 
mensaje de error (ej. "Error: El estudiante debe ser mayor de edad para 
registrarse"). Investiga la sintaxis de SIGNAL SQLSTATE o 
RAISE_APPLICATION_ERROR según el motor que uses. */

CREATE TRIGGER TR_VALIDAR_EDAD_ESTUDIANTE
BEFORE INSERT ON ESTUDIANTE
FOR EACH ROW
BEGIN
    IF NEW.EDAD < 17 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El estudiante debe ser mayor de edad para registrarse';
    END IF;
END;

CREATE TRIGGER TR_VALIDAR_EDAD_ESTUDIANTE_UPDATE
BEFORE UPDATE ON ESTUDIANTE
FOR EACH ROW
BEGIN
    IF NEW.EDAD < 17 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: El estudiante debe ser mayor de edad para registrarse';
    END IF;
END;