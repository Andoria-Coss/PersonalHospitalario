/* BD: ejhospdb
COLLATION: utf8_general_ci
*/

/*Creación de tabla para área*/
CREATE TABLE Area (
	nCveArea SMALLINT NOT NULL AUTO_INCREMENT,
	sDescripcion VARCHAR(50) NOT NULL,
	CONSTRAINT area_pk PRIMARY KEY (nCveArea)
);


/*Creación de tabla para Habitación*/
CREATE TABLE Habitacion (
                nNumHab SMALLINT NOT NULL,
                sCaracteristicas VARCHAR(100) NOT NULL,
                nOcupada SMALLINT DEFAULT 0 NOT NULL COMMENT '0 = No, 1 = Sí',
                nPrecio NUMERIC(10,2) NOT NULL,
                nCveArea SMALLINT NOT NULL,
                CONSTRAINT habitacion_pk PRIMARY KEY (nNumHab)
);
;


/*Creación de tabla para Paciente*/
CREATE TABLE Paciente (
                nIdPac INTEGER NOT NULL AUTO_INCREMENT,
                sNombre VARCHAR(20) NOT NULL,
                sApePat VARCHAR(20) NOT NULL,
                sApeMat VARCHAR(20),
                dFecNacim DATE NOT NULL,
                sSexo CHAR(1) NOT NULL COMMENT 'F o M',
                sAlergias VARCHAR(100),
                CONSTRAINT paciente_pk PRIMARY KEY (nIdPac)
);


/*Creación de tabla para Personal Hospitalario*/
CREATE TABLE PersonalHospitalario (
                nIdPersonal SMALLINT NOT NULL AUTO_INCREMENT,
                sNombre VARCHAR(20) NOT NULL,
                sApePat VARCHAR(20) NOT NULL,
                sApeMat VARCHAR(20),
                dFecNacim DATE,
                sSexo CHAR(1) DEFAULT 'F' NOT NULL COMMENT 'F o M',
                nTipo SMALLINT NOT NULL COMMENT '1=Médico
2=Admisiones
3=Administrador Sistema',
                CONSTRAINT personalhospitalario_pk PRIMARY KEY (nIdPersonal)
);

/*Crear tabla para Episodio Médico*/
CREATE TABLE EpisodioMedico (
                nIdEpisodio INTEGER NOT NULL AUTO_INCREMENT,
                nIdPac INTEGER NOT NULL,
                nIdPersonal SMALLINT NOT NULL,
                dIngreso DATE NOT NULL,
                dEgreso DATE,
                sDiagnostico VARCHAR(100) NOT NULL,
                nNumHab SMALLINT NOT NULL,
                CONSTRAINT episodiomedico_pk PRIMARY KEY (nIdEpisodio)
);

/*Creación de tabla para usuario*/
CREATE TABLE Usuario (
                nCveUsu SMALLINT NOT NULL  AUTO_INCREMENT,
                sContrasenia VARCHAR(16) NOT NULL,
                nIdPersonal SMALLINT NOT NULL,
                CONSTRAINT usuario_pk PRIMARY KEY (nCveUsu)
);

/*Creación de índice sobre id de personal en Usuario, evita que un usuario
se asocie a más de un personal hospitalario */
CREATE UNIQUE INDEX usuario_idx
 ON Usuario
 ( nIdPersonal ASC );

/*Definición de llave foráneas*/
ALTER TABLE Habitacion ADD CONSTRAINT area_habitacion_fk
FOREIGN KEY (nCveArea)
REFERENCES Area (nCveArea);

ALTER TABLE EpisodioMedico ADD CONSTRAINT habitacion_episodiomedico_fk
FOREIGN KEY (nNumHab)
REFERENCES Habitacion (nNumHab);

ALTER TABLE EpisodioMedico ADD CONSTRAINT paciente_episodiomedico_fk
FOREIGN KEY (nIdPac)
REFERENCES Paciente (nIdPac);

ALTER TABLE EpisodioMedico ADD CONSTRAINT personalhospitalario_episodiomedico_fk
FOREIGN KEY (nIdPersonal)
REFERENCES PersonalHospitalario (nIdPersonal);

ALTER TABLE Usuario ADD CONSTRAINT personalhospitalario_usuario_fk
FOREIGN KEY (nIdPersonal)
REFERENCES PersonalHospitalario (nIdPersonal);

/*Creación de usuario de base de datos y permisos*/
DROP USER 'hospital'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'hospital'@'localhost' IDENTIFIED BY 'hospital1';

/*Asignación de permisos*/
GRANT select, insert, delete, update ON area TO hospital;
GRANT select, insert, delete, update ON episodioMedico TO hospital;
GRANT select, insert, delete, update ON habitacion TO hospital;
GRANT select, insert, delete, update ON paciente TO hospital;
GRANT select, insert, delete, update ON personalHospitalario TO hospital;
GRANT select, insert, delete, update ON usuario TO hospital;

/*Carga inicial de datos*/
INSERT INTO area (nCveArea, sDescripcion) VALUES (1, 'Pediatría');
INSERT INTO area (nCveArea, sDescripcion) VALUES (2, 'Gineco-obstetricia');
INSERT INTO area (nCveArea, sDescripcion) VALUES (3, 'Medicina Interna');
INSERT INTO area (nCveArea, sDescripcion) VALUES (4, 'Oncología');
INSERT INTO area (nCveArea, sDescripcion) VALUES (5, 'Neurología');

INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (1, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',0, 980, 1);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (2, 'Cama hospitalaria, sofá para acompañante, ventilador, tv',0, 700, 1);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (3, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',1, 980, 2);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (4, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',0, 980, 2);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (5, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',0, 980, 2);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (6, 'Cama hospitalaria, sofá para acompañante, ventilador, tv',1, 700, 2);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (7, 'Cama hospitalaria, sofá para acompañante, ventilador, tv',0, 700, 2);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (8, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',1, 980, 3);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (9, 'Cama hospitalaria, sofá para acompañante, ventilador, tv',0, 700, 3);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (10, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',0, 980, 4);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (11, 'Cama hospitalaria, sofá para acompañante, ventilador, tv',0, 700, 4);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (12, 'Cama hospitalaria, sofá para acompañante, balcón, aire acondicionado, tv',0, 980, 5);
INSERT INTO habitacion (nNumHab, sCaracteristicas, nOcupada, nPrecio, nCveArea) VALUES (13, 'Cama hospitalaria, sofá para acompañante, ventilador, tv',0, 700, 5);

INSERT INTO personalHospitalario (nIdPersonal,sNombre,sApePat,sApeMat,dFecNacim,sSexo,nTipo) VALUES (1, 'Peter', 'Par', 'Ker', '1970-11-17', 'M', 3);
INSERT INTO personalHospitalario (nIdPersonal,sNombre,sApePat,sApeMat,dFecNacim,sSexo,nTipo) VALUES (2, 'Bruce', 'Barner', 'Smith', '1980-09-22', 'M', 1);
INSERT INTO personalHospitalario (nIdPersonal,sNombre,sApePat,sApeMat,dFecNacim,sSexo,nTipo) VALUES (3, 'Minnie', 'Mouse', 'Disney', '1995-01-01', 'F', 2);

INSERT INTO usuario (nCveUsu,sContrasenia,nIdPersonal) VALUES (1, 'abc123', 1);
INSERT INTO usuario (nCveUsu,sContrasenia,nIdPersonal) VALUES (2, 'abc124', 2);
INSERT INTO usuario (nCveUsu,sContrasenia,nIdPersonal) VALUES (3, 'abc125', 3);

INSERT INTO paciente (nIdPac,sNombre,sApePat,sApeMat,dFecNacim,sSexo,sAlergias) VALUES (1, 'Susan', 'Richards', 'Lee', '1989-06-30', 'F', 'Ninguna');
INSERT INTO paciente (nIdPac,sNombre,sApePat,sApeMat,dFecNacim,sSexo,sAlergias) VALUES (2, 'Mickey', 'Mouse', 'Disney', '1950-03-30', 'M', 'A los gatos');
INSERT INTO paciente (nIdPac,sNombre,sApePat,sApeMat,dFecNacim,sSexo,sAlergias) VALUES (3, 'Loise', 'Lane', 'Kent', '1995-04-19', 'F', 'A la penicilina');
INSERT INTO paciente (nIdPac,sNombre,sApePat,sApeMat,dFecNacim,sSexo,sAlergias) VALUES (4, 'Clark', 'Kent', 'Lee', '1990-02-22', 'M', 'Ninguna');

INSERT INTO episodioMedico (nIdEpisodio,nIdPac,nIdPersonal,dIngreso,dEgreso,sDiagnostico,nNumHab) VALUES (1, 4, 2, '2017-12-20','2017-12-22', 'Dolor de espalda', 8);
INSERT INTO episodioMedico (nIdEpisodio,nIdPac,nIdPersonal,dIngreso,dEgreso,sDiagnostico,nNumHab) VALUES (2, 4, 2, '2018-02-10','2018-02-13', 'Dolor de cabeza', 9);
INSERT INTO episodioMedico (nIdEpisodio,nIdPac,nIdPersonal,dIngreso,dEgreso,sDiagnostico,nNumHab) VALUES (3, 1, 2, '2018-01-01',null, 'Embarazo gemelar', 3);
INSERT INTO episodioMedico (nIdEpisodio,nIdPac,nIdPersonal,dIngreso,dEgreso,sDiagnostico,nNumHab) VALUES (4, 3, 2, '2018-01-02',null, 'Embarazo múltiple', 6);
INSERT INTO episodioMedico (nIdEpisodio,nIdPac,nIdPersonal,dIngreso,dEgreso,sDiagnostico,nNumHab) VALUES (5, 2, 2, '2018-01-03',null, 'Dengue', 8);
