DELIMITER //

CREATE FUNCTION ClasificarDesempeño(p_id_estudiante INT)
RETURNS VARCHAR(20)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_periodo_reciente VARCHAR(10);
    DECLARE v_promedio         DECIMAL(4,2);
    DECLARE v_clasificacion    VARCHAR(20);

    -- Paso 1: obtener el periodo más reciente en el que ESTE estudiante tiene notas
    SELECT MAX(periodo) INTO v_periodo_reciente
    FROM notas
    WHERE id_estudiante = p_id_estudiante;

    -- Paso 2: si no existe ningún periodo, el estudiante no tiene notas registradas
    IF v_periodo_reciente IS NULL THEN
        RETURN 'Sin datos';
    END IF;

    -- Paso 3: calcular el promedio de nota_final para ese estudiante en ese periodo
    SELECT AVG(nota_final) INTO v_promedio
    FROM notas
    WHERE id_estudiante = p_id_estudiante
      AND periodo = v_periodo_reciente;

    -- Paso 4: clasificar según los umbrales definidos
    IF v_promedio < 3.0 THEN
        SET v_clasificacion = 'Bajo';
    ELSEIF v_promedio <= 4.0 THEN
        SET v_clasificacion = 'Aceptable';
    ELSE
        SET v_clasificacion = 'Sobresaliente';
    END IF;

    RETURN v_clasificacion;
END //

DELIMITER ;



SELECT 
    id_estudiante,
    nombre_completo,
    ClasificarDesempeño(id_estudiante) AS desempeño
FROM estudiantes;
