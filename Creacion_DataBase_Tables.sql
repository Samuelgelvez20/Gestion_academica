CREATE DATABASE IF NOT EXISTS gestion_academica
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE gestion_academica;


CREATE TABLE estudiantes (
    id_estudiante       INT AUTO_INCREMENT,
    nombre_completo     VARCHAR(150) NOT NULL,
    documento_identidad VARCHAR(20)  NOT NULL,
    PRIMARY KEY (id_estudiante),
    UNIQUE KEY uq_documento_identidad (documento_identidad)
);

CREATE TABLE asignaturas (
    id_asignatura     INT AUTO_INCREMENT,
    nombre_asignatura VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_asignatura),
    UNIQUE KEY uq_nombre_asignatura (nombre_asignatura)
);

CREATE TABLE notas (
    id_nota       INT AUTO_INCREMENT,
    id_estudiante INT NOT NULL,
    id_asignatura INT NOT NULL,
    periodo       VARCHAR(10) NOT NULL,
    nota_final    DECIMAL(2,1) NOT NULL,
    PRIMARY KEY (id_nota),
    CONSTRAINT fk_notas_estudiante
        FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_notas_asignatura
        FOREIGN KEY (id_asignatura) REFERENCES asignaturas(id_asignatura)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT chk_nota_rango
        CHECK (nota_final >= 0.0 AND nota_final <= 5.0),
    INDEX idx_notas_estudiante_periodo (id_estudiante, periodo)
);