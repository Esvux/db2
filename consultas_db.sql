-- CONSULTA 2, TOP 10, PICHICHIS, CORRER PROCEDIMIENTO PREVIAMENTE
SELECT actualizar_pichichi();
SELECT jugador.nombre, COUNT(pichichi_temp.id_jugador) AS pichichis 
FROM pichichi_temp, jugador
WHERE pichichi_temp.id_jugador = jugador.id_jugador
GROUP BY jugador.nombre
ORDER BY pichichis DESC
LIMIT 10;

-- CONSULTA 3, TOP 5 DE LOS EQUIPOS CON MÁS LIGAS GANADAS, CORRER PROCEDIMIENTO PREVIAMENTE
SELECT obtener_ganadores_liga();
SELECT * FROM ganadores_temp;
SELECT equipo.nombre, COUNT(ganadores_temp.id_equipo) AS ligas_ganadas
FROM ganadores_temp, equipo
WHERE ganadores_temp.id_equipo = equipo.id_equipo
GROUP BY equipo.nombre
ORDER BY ligas_ganadas DESC
LIMIT 5;

-- CONSULTA 6, POSICIONES POR EQUIPO, POR TEMPORADA, GOLES Y PUNTOS, CREAR ANTES EL PROCEDIMIENTO
SELECT obtener_posiciones_liga_por_equipo(6861);
SELECT temporada.nombre AS nombre_temporada, equipo.nombre AS nombre_equipo, puntos, posicion, goles_a_favor, goles_en_contra 
FROM  posicion_equipo_temp, temporada, equipo
WHERE posicion_equipo_temp.id_temporada = temporada.id_temporada
AND posicion_equipo_temp.id_equipo = equipo.id_equipo;

-- CONSULTA 7, ¿CUÁL HA SIDO LA VICTORIA MÁS ABSOLUTA DE LOS ÚLTIMOS 18 AÑOS?
-- PARTIDO, EQUIPOS Y MARCADORES
SELECT fecha, l.nombre AS local, v.nombre AS visitatne, goles_local, goles_visitante, ABS(goles_local - goles_visitante) as diferencia
FROM partido, equipo AS l, equipo AS v
WHERE l.id_equipo = id_local
AND v.id_equipo = id_visitante
ORDER BY diferencia DESC 
LIMIT 1

-- CONSULTA 10, JUGADOR CON MEJOR PROMEDIO DE GOLES POR TEMPORADAS
SELECT jugador.nombre, AVG(goles) AS goles_promedio 
FROM jugador, record
WHERE jugador.id_jugador = record.id_jugador
GROUP BY jugador.nombre
ORDER BY goles_promedio desc
LIMIT 1;

-- CONSULTA 11, GOLES POR TEMPORADA SEGUN RECORD
SELECT t.nombre, sum(goles) goles_temporada
FROM record, temporada AS t
WHERE t.id_temporada = record.id_temporada
GROUP BY t.id_temporada
ORDER BY goles_temporada desc

-- CONSULTA 11, GOLES POR TEMPORADA SEGUN PARTIDOS
SELECT t.nombre, SUM(goles_local) + SUM(goles_visitante) AS goles_temporada
FROM partido, temporada AS t, jornada AS j
WHERE partido.id_jornada = j.id_jornada
AND j.id_temporada = t.id_temporada
GROUP BY t.id_temporada
ORDER BY goles_temporada desc

-- CONSULTA 12, EQUIPO CON MÁS VICTORIAS, CON MÁS DERROTAS Y CON MÁS EMPATES
SELECT obtener_historial();
	-- EQUIPO CON MÁS VICTORIAS
	SELECT equipo.nombre, victorias 
	FROM historial_equipo_temp, equipo
	WHERE equipo.id_equipo = historial_equipo_temp.id_equipo
	ORDER BY victorias desc
	LIMIT 1;
	-- EQUIPO CON MÁS DERROTAS
	SELECT equipo.nombre, derrotas 
	FROM historial_equipo_temp, equipo
	WHERE equipo.id_equipo = historial_equipo_temp.id_equipo
	ORDER BY derrotas desc
	LIMIT 1;
	-- EQUIPO CON MÁS EMPATES
	SELECT equipo.nombre, empates 
	FROM historial_equipo_temp, equipo
	WHERE equipo.id_equipo = historial_equipo_temp.id_equipo
	ORDER BY empates desc
	LIMIT 1;
