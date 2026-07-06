USE gestion_academica;

INSERT INTO estudiantes (nombre_completo, documento_identidad) VALUES
    ('Ana Torres',    '1001001001'),  -- caso: promedio exactamente 3.0
    ('Carlos Ruiz',   '1001001002'),  -- caso: promedio exactamente 4.0 (límite superior de 'Aceptable')
    ('Maria Gómez',   '1001001003'),  -- caso: promedio bajo (< 3.0)
    ('Luis Peña',     '1001001004'),  -- caso: promedio sobresaliente (> 4.0)
    ('Sofía Rincón',  '1001001005'),  -- caso: solo tiene notas en un periodo ANTERIOR, no en el más reciente global
    ('Pedro Salas',   '1001001006');  -- caso: sin ninguna nota registrada (debe devolver 'Sin datos')
    

INSERT INTO asignaturas (nombre_asignatura) VALUES
    ('Cálculo I'),
    ('Física I'),
    ('Programación I'),
    ('Bases de Datos');
    
    
    -- Ana Torres (id 1): promedio EXACTO de 3.0 en el periodo más reciente (2026-1)
INSERT INTO notas (id_estudiante, id_asignatura, periodo, nota_final) VALUES
    (1, 1, '2026-1', 3.0),
    (1, 2, '2026-1', 3.0),
    (1, 3, '2026-1', 3.0);

-- Carlos Ruiz (id 2): promedio EXACTO de 4.0 -- límite superior de 'Aceptable'
INSERT INTO notas (id_estudiante, id_asignatura, periodo, nota_final) VALUES
    (2, 1, '2026-1', 4.0),
    (2, 2, '2026-1', 4.0);

-- Maria Gómez (id 3): promedio por debajo de 3.0 -> 'Bajo'
INSERT INTO notas (id_estudiante, id_asignatura, periodo, nota_final) VALUES
    (3, 1, '2026-1', 2.0),
    (3, 2, '2026-1', 2.5);
-- promedio = 2.25

-- Luis Peña (id 4): promedio por encima de 4.0 -> 'Sobresaliente'
INSERT INTO notas (id_estudiante, id_asignatura, periodo, nota_final) VALUES
    (4, 1, '2026-1', 4.5),
    (4, 2, '2026-1', 4.8);
-- promedio = 4.65

-- Sofía Rincón (id 5): SOLO tiene notas en un periodo anterior (2025-2),
-- no tiene ninguna nota en 2026-1. Esto prueba que la función debe usar
-- el periodo más reciente DE ESE ESTUDIANTE, no un periodo "global" fijo.
INSERT INTO notas (id_estudiante, id_asignatura, periodo, nota_final) VALUES
    (5, 3, '2025-2', 3.8),
    (5, 4, '2025-2', 4.2);
-- promedio de su periodo más reciente (2025-2) = 4.0

-- Pedro Salas (id 6): NO se inserta ninguna nota a propósito.
-- Debe probar la ruta de "Sin datos" en la función.