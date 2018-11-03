DELETE FROM liga_temp;
DELETE FROM pichichi_temp;
DELETE FROM ganadores_temp;
DELETE FROM record;
DELETE FROM jugador;
DELETE FROM participacion;
DELETE FROM partido;
DELETE FROM equipo;
DELETE FROM jornada;
DELETE FROM temporada;

INSERT INTO temporada (id_temporada, fecha_inicio, fecha_fin, nombre)
SELECT nextval('seq_temporada'), min(fecha), max(fecha), TRIM(temporada) FROM master_partido 
GROUP BY temporada
ORDER BY temporada;

INSERT INTO jornada (id_jornada, id_temporada, numero, nombre, fecha_inicio, fecha_fin) 
SELECT nextval('seq_jornada'), id_temporada, CAST(TRIM(SUBSTRING(jornada, ' *([0-9]+)')) AS integer) AS numero, jornada, min(fecha), max(fecha) 
FROM master_partido, temporada
WHERE  master_partido.temporada = temporada.nombre
GROUP BY id_temporada, jornada
ORDER BY id_temporada;

ALTER TABLE equipo ALTER COLUMN id_equipo SET DEFAULT nextval('seq_equipo');

INSERT INTO equipo (nombre)
SELECT DISTINCT TRIM(equipo_local) FROM master_partido;

INSERT INTO partido (id_partido, id_local, id_visitante, fecha, goles_local, goles_visitante, id_jornada)
SELECT nextval('seq_partido'), L.id_equipo AS local, V.id_equipo AS visitante, M.fecha, M.goles_local, M.goles_visitante, J.id_jornada 
FROM master_partido AS M, temporada AS T, jornada AS J, equipo AS L, equipo AS V
WHERE M.equipo_local = L.nombre
AND M.equipo_visitante = V.nombre
AND M.jornada = J.nombre
AND M.temporada = T.nombre
AND J.id_temporada = T.id_temporada;

ALTER TABLE participacion ALTER COLUMN id_participacion SET DEFAULT nextval('seq_participacion');

INSERT INTO participacion (id_temporada, id_equipo)
SELECT DISTINCT id_temporada, id_equipo
FROM master_partido, temporada, equipo
WHERE master_partido.temporada = temporada.nombre
AND master_partido.equipo_local = equipo.nombre
ORDER BY id_temporada;
 
ALTER TABLE jugador ALTER COLUMN id_jugador SET DEFAULT nextval('seq_jugador');

INSERT INTO jugador (nombre)
SELECT DISTINCT jugador FROM master_goleador; 

INSERT INTO record (id_record, id_temporada, id_jugador, goles)
SELECT nextval('seq_record'), id_temporada, id_jugador, goles
FROM master_goleador, temporada, jugador
WHERE  master_goleador.temporada = temporada.nombre
AND master_goleador.jugador = jugador.nombre;

ALTER TABLE liga_temp ALTER COLUMN id_liga_temp SET DEFAULT nextval('seq_liga_temp');

ALTER TABLE pichichi_temp ALTER COLUMN id_pichichi_temp SET DEFAULT nextval('seq_pichichi_temp');

ALTER TABLE ganadores_temp ALTER COLUMN id_ganadores_temp SET DEFAULT nextval('seq_ganadores_temp');

ALTER TABLE posicion_equipo_temp ALTER COLUMN id_posicion_equipo_temp SET DEFAULT nextval('seq_posicion_equipo_temp');

ALTER TABLE historial_equipo_temp ALTER COLUMN id_historial_equipo_temp SET DEFAULT nextval('seq_historial_equipo_temp');
