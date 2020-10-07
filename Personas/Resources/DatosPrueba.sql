/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  rodrigo
 * Created: 4 oct. 2020
 */
INSERT INTO Personas.Cursos (`Codigo`,`Nombre`)
VALUES
('DAW','Desarrollo de aplicaciones WEB'),
('DAM','Desarrollo de aplicaciones multiplataforma'),
('ASIR','Administracón de sistemas y redes');

INSERT INTO Personas.Asignaturas (`Codigo`,`Nombre`)
VALUES
('DWC','Desarrollo Web Cliente'),
('DWS','Desarrollo Web Servidor'),
('DI','Diseño Interfaces');

INSERT INTO Personas.Personas (`DNI`,`Tipo`,`Nombre`,`Curso`)
VALUES
('101A', 0, 'Israel','DAW'),
('101B', 1, 'Alejandro','DAW'),
('1A', 0, 'Nestor','DAW'),
('2B', 1, 'Belen','DAW'),
('3C', 0, 'Luis','DAW'),
('4D', 1, 'Jonathan','DAW'),
('5E', 0, 'Dario','DAW'),
('6F', 1, 'Jorge','DAW'),
('7G', 0, 'Maria','DAW'),
('8H', 1, 'Daniel','DAW'),
('9T', 1, 'Rodrigo','DAW');

INSERT INTO Personas.PersonasAsignaturas (`RPersona`,`RAsignatura`)
VALUES 
('101A','DWC'),
('101B','DWC'),
('1A','DWC'),
('2B','DWC'),
('3C','DWC'),
('4D','DWC'),
('5E','DWC'),
('6F','DWC'),
('7G','DWC'),
('8H','DWC'),
('9T','DWC'),
('9T','DWS'),
('9T','DI');
