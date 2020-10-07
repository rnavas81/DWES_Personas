/**
 * Author:  rodrigo
 * Created: 4 oct. 2020
 * Creación de la base de datos y sus relaciones
 */

CREATE DATABASE IF NOT EXISTS Personas
    CHARACTER SET utf8
    COLLATE utf8_spanish_ci;

DROP TABLE IF EXISTS Personas.PersonasAsignaturas;
DROP TABLE IF EXISTS Personas.Personas;
DROP TABLE IF EXISTS Personas.Cursos;
DROP TABLE IF EXISTS Personas.Asignaturas;

-- Crea la tabla de cursos
CREATE TABLE Personas.Cursos (
    Habilitado  TINYINT NOT NULL DEFAULT 1,
    Codigo      VARCHAR(16) CHARACTER SET utf8 COLLATE utf8_spanish_ci PRIMARY KEY,
    Nombre      VARCHAR(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci,

    UNIQUE KEY cursosUnico (Codigo)
);
-- Crea la tabla de asignaturas
CREATE TABLE Personas.Asignaturas (
    Habilitado  TINYINT NOT NULL DEFAULT 1,
    Codigo      VARCHAR(16) CHARACTER SET utf8 COLLATE utf8_spanish_ci PRIMARY KEY,
    Nombre      VARCHAR(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci,

    UNIQUE KEY asignaturasUnico (Codigo)
);

-- Crea la tabla de usuarios
CREATE TABLE Personas.Personas(
    DNI VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL PRIMARY KEY,
    Habilitado TINYINT NOT NULL DEFAULT 1,
    Password VARCHAR(500) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
    Tipo TINYINT NOT NULL DEFAULT 0,
    Nombre VARCHAR(64) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
    Apellidos VARCHAR(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
    Email VARCHAR(128) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
    Tfno VARCHAR(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
    Edad TINYINT DEFAULT 0,
    Genero TINYINT DEFAULT 1,
    Curso VARCHAR(16) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
    Fecha DATE,
    PJugadas TINYINT DEFAULT 0,
    PGanadas TINYINT DEFAULT 0,
    Username VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci,
    Avatar VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_spanish_ci,

    FOREIGN KEY (Curso) REFERENCES Personas.Cursos(Codigo)

);
CREATE TABLE Personas.PersonasAsignaturas (
    RPersona    VARCHAR(10) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL ,
    RAsignatura VARCHAR(16) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL ,
    PRIMARY KEY (RPersona,RAsignatura),

    FOREIGN KEY (RPersona) REFERENCES Personas.Personas(DNI),
    FOREIGN KEY (RAsignatura) REFERENCES Personas.Asignaturas(Codigo)
);
