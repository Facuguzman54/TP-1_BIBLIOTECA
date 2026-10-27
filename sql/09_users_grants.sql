/*
======================SECCIÓN 7 — Usuarios y permisos========================== 
 
Imagina que tienes dos tipos de trabajadores en la biblioteca: un bibliotecario y un 
administrador de sistema. 
*/

/* 
1.  Crea un usuario llamado 'bibliotecario_user'@'localhost' con una contraseña segura. 
*/ 
CREATE USER 'bibliotecario_user'@'localhost' IDENTIFIED BY 'ContraseñaSegura123!';


/*2.  Otorga permisos de Solo Lectura (SELECT) sobre las tablas LIBROS, AUTORES y 
EDITORIALES al usuario bibliotecario_user. (No debe poder modificarlas). 
*/
GRANT SELECT ON BIBLIOTECA.LIBRO TO 'bibliotecario_user'@'localhost';
GRANT SELECT ON BIBLIOTECA.AUTOR TO 'bibliotecario_user'@'localhost';
GRANT SELECT ON BIBLIOTECA.EDITORIAL TO 'bibliotecario_user'@'localhost';

/* 
3.  Otorga permisos de Lectura y Escritura (SELECT, INSERT, UPDATE, DELETE) 
sobre la tabla PRESTAMO al mismo usuario (porque él registra los préstamos). 
 */
GRANT SELECT, INSERT, UPDATE, DELETE ON BIBLIOTECA.PRESTAMO TO 'bibliotecario_user'@'localhost';

/*4.  Crea un usuario 'admin_user'@'localhost' y otórgale TODOS LOS PRIVILEGIOS 
sobre la base de datos completa. 
*/
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'ContraseñaSegura123$';
GRANT ALL PRIVILEGES ON BIBLIOTECA.* TO 'admin_user'@'localhost';


/*
5.  Escribe la sentencia para revocar el permiso de DELETE sobre la tabla PRESTAMO 
al bibliotecario_user (por si acaso borra un préstamo por error).
*/

REVOKE DELETE ON BIBLIOTECA.PRESTAMO FROM 'bibliotecario_user'@'localhost';


