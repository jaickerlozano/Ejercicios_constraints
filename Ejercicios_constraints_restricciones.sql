/*
CONSTRAINTS (RESTRICCIONES)
 Dentro de la base de datos ‘RESTRICCIONES’...
*/

-- Creación de schema RESTRICCIONES
create schema restricciones;
use restricciones;

/* 1. Crear una tabla llamada “FABRICANTES” que tenga la siguiente estructura
 COLUMNA      TIPO             CONSTRAINTS 
 CÓDIGO       INT              CLAVE PRIMARIA, TIPO AUTOINCREMENT
 NOMBRE       VARCHAR(50)      NOTNULL--
 APELLIDOS    VARCHAR(50)      -
 EDAD         INT              -
 FECHA_ALTA   DATE             -
 */
 create table FABRICANTES (
 CODIGO INT AUTO_INCREMENT PRIMARY KEY, 
 NOMBRE VARCHAR(50) NOT NULL, 
 APELLIDOS VARCHAR(50) , 
 EDAD INT, 
 FECHA_ALTA DATE
 );
 
 select * from fabricantes;
 
 -- 2. Hacer un DESC dela tabla para ver sus propiedades y comprobamos que 
 -- tenemos la Primary Key y el auto_increment
 desc fabricantes;
 
-- 3. Insertar un par de filas en la tabla para comprobar el autoincrement. 
-- Debe haber generado un valor a partir de 1
insert into fabricantes (NOMBRE, APELLIDOS, EDAD, FECHA_ALTA) values
('Carlos', 'Romero Alcántara', 26, curdate()),
('Ismael', 'Sosa Lara', 30, curdate());
select * from fabricantes;

-- 4. Modificar el campo AUTOINCREMENT para que comience ahora desde 1000
alter table fabricantes auto_increment = 1000;

-- 5. Insertar otro par de filas para omprobar el resultado
insert into fabricantes (NOMBRE, APELLIDOS, EDAD, FECHA_ALTA) values
('Katherine', 'Rojas Espinoza', 27, curdate()),
('Carla', 'Figueroa Dante', 30, curdate());
select * from fabricantes;

-- 6. Crear una clave única a nivel de TABLA para las columnas nombre y apellidos. 
-- La llamamos nombre_completo.
alter table fabricantes add constraint NOMBRE_COMPLETO UNIQUE KEY (nombre, apellidos);

-- 7. Hacer un DESC para comprobar el resultado. Debe poner MUL para indicar que es una clave múltiple.
desc fabricantes;

-- 8. Comprobar las constraints de la tabla con “information_schema.table_constraints
select * from information_schema.table_constraints where table_schema='restricciones' and table_name='fabricantes';

/* 9. Crear una tabla llamada “TANQUES” con la siguiente estructura y después comprobar con DESC:
COLUMNA         TIPO             CONSTRAINTS
CÓDIGO          INT         CLAVE PRIMARIA, AUTOINCREMENT
NOMBRE       VARCHAR(50)         NOT NULL
PAÍS         VARCHAR(50)    NOT NULL, Default: desconocido
LONGITUD        INT           NOT NULL, Default: 0
PESO            INT              Default: 5600
PESO_ARMADO     INT                  -
*/
create table TANQUES (
CODIGO INT AUTO_INCREMENT PRIMARY KEY,
NOMBRE VARCHAR(50) NOT NULL,
PAIS VARCHAR(50) NOT NULL DEFAULT "desconocido",
LONGITUD INT NOT NULL DEFAULT 0,
PESO INT DEFAULT 5600,
PESO_ARMADO INT
);
desc tanques;

/* 10. Añadir las siguientes filas y comprobar que se han insertado:
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Lepoard A','Alemania',9.67,62000,65000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Lepoard E','España',9.67,62000,65000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('T-90M','Rusia',9.63,46000,48000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Leclerc','Francia',10.6,56000,73000);
 insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Merkava Mk.4','Israel',9.04,65000,73000);
*/
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Lepoard A','Alemania',9.67,62000,65000);
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Lepoard E','España',9.67,62000,65000);
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('T-90M','Rusia',9.63,46000,48000);
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Leclerc','Francia',10.6,56000,73000);
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Merkava Mk.4','Israel',9.04,65000,73000);

select * from tanques;

-- 11. Añadir una constraint de tipo UNIQUE en la columna “nombre_tanque”
alter table tanques add constraint nombre_tanque unique(NOMBRE);

-- 12. Comprobar que se ha realizado la restricción
desc tanques;
select * from information_schema.table_constraints where table_schema='restricciones' and table_name='tanques';

/*13. Intentar añadir una de las filas anteriores. Debe generar un error porque
aunque genera una nueva Primary Key con el increment, la clave única debe
fallar.*/
insert into tanques (nombre,pais,longitud,peso,peso_armado) values ('Merkava Mk.4','Israel',9.04,65000,73000);
-- Efectivamente genera un error porque se intenta crear un duplicado del nombre del tanque el cual tiene como 
-- restricción unique

-- 14. Insertar una nueva fila dejando los default por defecto
insert into tanques (NOMBRE, PESO_ARMADO) values ('M1 Abrams', 71000);
select * from tanques;

-- 15. Cambiar default value de longitud a 0 e insertar otra fila para comprobarlo
alter table tanques modify LONGITUD int default 0;
-- Otra forma de cambiar el default puede ser utilizando otro alter despues del nombre de la tabla
alter table tanques alter LONGITUD set default 0;
insert into tanques (NOMBRE, PESO_ARMADO) values ('T-14', 58000);

-- 16. Crear una constraint de tipo CHECK, donde el peso_armado no puede ser
-- inferior al peso del tanque. La llamamos “control_peso”

alter table tanques add constraint CONTROL_PESO CHECK(PESO_ARMADO>PESO);

-- 17. Comprobar las constraints
select * from information_schema.table_constraints where table_schema = 'restricciones' and table_name = 'tanques';

-- 18. Insertar una fila para comprobar que funciona y que no deja insertarlo.
insert into tanques (NOMBRE,PAIS,LONGITUD,PESO,PESO_ARMADO) values ('T-34','Chile',9.67,68000,65000);
-- Efectivamente no nos deja insertar los valores porque el peso del armado es menor al peso.alter
 
 /*19. Crea la siguiente tabla:
 COLUMNA               TIPO           CONSTRAINTS
 NOMBRE_PAIS        VARCHAR(50)      CLAVE PRIMARIA
 DESCRIPCION        VARCHAR(150)          -
 */
create table PAISES(
NOMBRE_PAIS VARCHAR(50) PRIMARY KEY,
DESCRIPCION VARCHAR(150)
);

/*20. Intentar crear una clave ajena entre tanques y países, de forma que el país de
Tanques sea foreign key de la columna nombre_pais de la tablas países.
¿Funciona?*/ 
alter table tanques add constraint FKEY1 foreign key(PAIS) references PAISES(NOMBRE_PAIS);
-- No se puede

-- 21. Insertar los valores necesarios
insert into PAISES(NOMBRE_PAIS) values ('Alemania'), ('España'), ('Rusia'), ('Francia'), ('Israel'), ('desconocido'), ('desconodico');
select * from paises;

-- 22. Intentar de nuevo crear la foreign key. Ahora debería funcionar
alter table tanques add constraint FKEY1 foreign key(PAIS) references PAISES(NOMBRE_PAIS);
-- Ahora si funcionó

-- 23. Insertar una fila con un país que no exista, para que genere un error
insert into tanques (NOMBRE,PAIS,LONGITUD,PESO,PESO_ARMADO) values ('IS-2','Luxemburgo',9.67,65000,68000);
-- No se puede porque la tabla hija (TANQUES) no puede ingresar un país que no esté previamente registrado en la tabla padre (PAISES).

-- 24. Borrar la restricción de tipo Check que creamos antes, denominada “control_peso” y comprobamos que ha desaparecido.
alter table tanques drop constraint CONTROL_PESO;
select * from information_schema.table_constraints where table_schema = 'restricciones' and table_name = 'tanques';

--  25. Borrar el default de la columna “longitud” y comprobar que ha desaparecido con un DESC
alter table tanques alter longitud drop default;
desc tanques;