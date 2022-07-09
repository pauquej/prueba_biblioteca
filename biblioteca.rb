#1.Crear el modelo en una base de datos llamada biblioteca, considerando las tablas
#definidas y sus atributos.

CREATE DATABASE biblioteca

c\biblioteca

CREATE TABLE libro(
isbn CHAR (15) PRIMARY KEY,
titulo VARCHAR (100),
pagina INT,
);

CREATE TABLE socio(
rut CHAR (10) PRIMARY KEY, 
nombre VARCHAR (25),
apellido VARCHAR(25),
direccion VARCHAR(100),
telefono VARCHAR (10),
);

CREATE TABLE autor(
codigo_autor INT (PRIMARY KEY),
nombre_autor VARCHAR(25),
apellido_autor VARCHAR(25),
fecha_nacimiento_autor DATE,
fecha_muerte_autor DATE,
);

CREATE TABLE tipo_de_autor(
codigo_autor INT,
isbn CHAR (15),
tipo_autor VARCHAR (25),
FOREIGN KEY (isbn) REFERENCES libro (isbn),
FOREIGN KEY (codigo_autor) REFERENCES autor (codigo_autor)
);


CREATE TABLE historial_prestamos( 
rut CHAR (10),
isbn CHAR (15),
fecha_prestamo DATE, 
fecha_devolucion DATE,
);

#2. Insertar los registros en las tablas correspondientes.

INSERT INTO autor(codigo_autor, nombre_autor, apellido_autor, fecha_nacimiento_autor, fecha_muerte_autor)
VALUES
(3, 'JOSE', 'SALGADO', '1968-01-01', '01-01-2020'),
(4, 'ANA', 'SALGADO', '1972-01-01',NULL),
(1, 'ANDRES', 'ULLOA', '1982-01-01',NULL),
(2, 'SERGIO', 'MARDONES', '1950-01-01','2012-01-01'),
(5, 'MARTIN', 'PORTA', '1976-01-01',NULL)
;

INSERT INTO libro(isbn, titulo, paginas)
VALUES
('111-1111111-111', 'CUENTOS DE TERROR', 344),
('222-2222222-222', 'POESIAS CONTEMPORANEAS', 167),
('333-3333333-333', 'HISTORIA DE ASIA', 511),
('444-4444444-444', 'MANUAL DE MECANICA', 298);

INSERT INTO tipo_de_autor(isbn,codigo_autor, tipo_autor)
VALUES
('111-1111111-111', 3, 'PRINCIPAL'),
('111-1111111-111', 4, 'COAUTOR'),
('222-2222222-222', 1, 'PRINCIPAL'),
('333-3333333-333', 2, 'PRINCIPAL'),
('444-4444444-444', 5, 'PRINCIPAL');

-- INSERTAR VALORES A TABLA SOCIO
INSERT INTO socio(rut, nombre, apellido, direccion, telefono)
VALUES
('1111111-1', 'JUAN', 'SOTO', 'AVENIDA 1, SANTIAGO', '911111111'),
('2222222-2', 'ANA', 'PEREZ', 'PASAJE 2, SANTIAGO', '922222222'),
('3333333-3', 'SANDRA', 'AGUILAR', 'AVENIDA 2, SANTIAGO', '933333333'),
('4444444-4', 'ESTEBAN', 'JEREZ', 'AVENIDA 3, SANTIAGO', '944444444'),
('5555555-5', 'SILVANA', 'MUNOZ', 'PASAJE 3, SANTIAGO', '955555555');

INSERT INTO prestamo(isbn, rut, fecha_prestamo,fecha_devolucion)
VALUES
('2020-01-20', '2020-01-27', '1111111-1', '111-1111111-111'),
('2020-01-20', '2020-01-30', '5555555-5', '222-2222222-222'),
('2020-01-22', '2020-01-30', '3333333-3', '333-3333333-333'),
('2020-01-23', '2020-01-30', '4444444-4', '444-4444444-444'),
('2020-01-27', '2020-02-04', '2222222-2', '111-1111111-111'),
('2020-01-31', '2020-02-12', '1111111-1', '444-4444444-444'),
('2020-01-31', '2020-02-12', '3333333-3', '222-2222222-222');


#3.Mostrar todos los libros que posean menos de 300 páginas:

SELECT titulo, paginas FROM libro WHERE paginas < 300 ORDER BY paginas_libro DESC;


#4.Mostrar todos los autores que hayan nacido después del 01-01-1970

SELECT nombre_autor, apellido_autor FROM autor
WHERE fecha_nacimiento_autor>='1970-01-01';


#5.¿Cuál es el libro más solicitado?

SELECT titulo, COUNT(*) as numero_prestamos FROM libro
INNER JOIN prestamo
ON libro.isbn = prestamo.isbn
GROUP BY libro.titulo ORDER BY numero_prestamos DESC;


#6.Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días:

SELECT prestamo.id_prestamo, socio.rut,((fecha_devolucion - fecha_prestamo) - 7)*100 AS "monto_adeudado" FROM prestamo
INNER JOIN socio
ON prestamo.rut = socio.rut
WHERE ((fecha_devolucion - fecha_prestamo)) > 7
ORDER BY prestamo.id_prestamo;


