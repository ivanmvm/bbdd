DROP DATABASE IF EXISTS projecte_practiques;
CREATE DATABASE projecte_practiques;
USE projecte_practiques;

CREATE TABLE IF NOT EXISTS alumne (
	id_alumne INT NOT NULL PRIMARY KEY,
	nom VARCHAR(45) NOT NULL,
	cognoms VARCHAR(45) NOT NULL,
	data_naixement DATE NOT NULL,
	email VARCHAR(45) NOT NULL,
	telefon INT NOT NULL,
	cicle_formatiu VARCHAR(45) NOT NULL,
	curs VARCHAR(45) NOT NULL
	PRIMARY KEY (id_alumne)
);

CREATE TABLE IF NOT EXISTS empresa (
	id_empresa INT NOT NULL,
	nom VARCHAR(45) NOT NULL,
	adreça VARCHAR(45) NOT NULL,
	telefon INT NOT NULL,
	email VARCHAR(45) NOT NULL,
	PRIMARY KEY (id_empresa)
);

CREATE TABLE IF NOT EXISTS practiques (
	id_practica INT (45) NOT NULL,
	id_alumne INT(45) NOT NULL,
	id_empresa INT(45) NOT NULL,
	data_inici DATE NOT NULL,
	data_final DATE NOT NULL,
	num_hores INT(45) NOT NULL,
	exempcio INT NOT NULL,
	PRIMARY KEY (id_practica, id_alumne, id_empresa),
	FOREIGN KEY (id_alumne) REFERENCES alumnat (id_alumne),
	FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa)
);

CREATE TABLE IF NOT EXISTS tutor_practica (
	id_tutor INT(45) NOT NULL,
	id_practica INT(50) NOT NULL,
	nom_tutor VARCHAR(30) NOT NULL,
	PRIMARY KEY (id_tutor, id_practica),
	FOREIGN KEY (id_practica) REFERENCES practiques (id_practica)
);

CREATE TABLE IF NOT EXISTS tutor_empresa (
	id_tutor INT(50) NOT NULL,
	id_empresa INT(50) NOT NULL,
	nom_tutor VARCHAR(30) NOT NULL,
	PRIMARY KEY (id_tutor, id_empresa),
	FOREIGN KEY (id_empresa) REFERENCES empresa (id_empresa)
);

INSERT INTO tutor_empresa (id_tutorempresa, nom_tutorempresa) 
VALUES	(5, 'Emmnauel Sanchez'),
	(10, 'Paco Lopez'),
	(15, 'Manolo Espada')
;

INSERT INTO tutor_alumne (id_tutoralumne, nom_tutoralumne)
VALUES	(20, 'Miquel Molano'),
	(25, 'Clara Casio'),
	(30, 'Pepe Mujica')
;

INSERT INTO cicle (id_cicle, nom_cicle)
VALUES	(35, 'SMIX'),
	(40, 'DAW'),
	(45, 'ASIX')
;

INSERT INTO empresa (id_empresa, nom_empresa, adreça, telefon, email, id_tutorempresa, id_homologacio)
VALUES 	(50, 'FruteriaSAB', 'Avenida general, Sant Adria de Besos', 626379323, 'fruteria@gmail.com', 6, 71),
	(55, 'PatosMuebles', 'Carrer Pere IV, Barcelona', 688123201, 'patosmuebles@gmail.com', 5, 83),
	(60, 'Bazar24h', 'Carrer Joan Baptista, Badalona', 600321232, 'bazar24hbcn@gmail.com', 8, 95)
;

INSERT INTO practica (id_practica, tipus_practica, data_inici, data_final, hores, exempcio, id_empresa)
VALUES 	(65, 'FCT', '2020-05-22', '2022-01-30', 2800, '35%', 22),
	(70, 'DUAL', '2023-01-10', '2024-03-21', 2500, '90%', 20),
	(75, 'FCT', '2021-05-11', '2023-07-16', 3000, '10%', 29)
;

INSERT INTO alumne (id_alumne, nom_alumne, cognom, data_naixement, email, telefon, qualificacio, id_practica, id_tutoralumne, id_cicle)
VALUES 	(80, 'Kilian', 'Sanchez', '1999-02-12', 'ksanchez@gmail.com', 653623212, 9.7, 55, 80, 12),
	(85, 'Joel', 'Espada', '2000-05-23', 'jespada@gmail.com', 635631432, 4.6, 52, 56, 31),
	(90, 'Ivan', 'Rodriguez', '2003-05-11', 'irodriguez@gmail.com', 661072573, 8.5, 53, 54, 11)
;

delimiter // 

CREATE TRIGGER pr_bi BEFORE INSERT ON practica
FOR EACH ROW
BEGIN
	IF (NEW.data_inici <= NOW())
	THEN
	SIGNAL SQLSTATE'45000' SET MESSAGE_TEXT= 'ERROR. No es pot introduir una pràctica d'una data anterior a l'actual';
	END IF  
	END; //
/*
delimiter ;
	 
delimiter //

CREATE TRIGGER pr_bu BEFORE UPDATE ON practica
FOR EACH ROW
BEGIN
	IF (NEW.data_final < NEW.data_inici)
	THEN
	SIGNAL SQLSTATE'45000' SET MESSAGE_TEXT= 'ERROR. No es pot actualitzar una pràctica d'una data anterior a la data inicial';
	END IF;
	END; //
*/  
delimiter ;
