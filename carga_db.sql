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


select * from equipo
SELECT * FROM master_partido 
WHERE equipo_local like '%Real Madrid	1%'