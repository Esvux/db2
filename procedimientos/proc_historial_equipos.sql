DROP FUNCTION obtener_historial_equipo_temporada(INTEGER);
CREATE OR REPLACE FUNCTION obtener_historial_equipo_temporada(_idt INTEGER)
   RETURNS text AS $$
DECLARE
	_partido PARTIDO; 
	_ide INTEGER;
	cur_partidos CURSOR (_idt INTEGER) FOR 
		SELECT * FROM partido, jornada
		WHERE partido.id_jornada = jornada.id_jornada 
		AND jornada.id_temporada = _idt;
BEGIN
	OPEN cur_partidos (_idt);
	LOOP
		FETCH cur_partidos INTO _partido;
		EXIT WHEN NOT FOUND;
		-- Actualizar historial
		IF _partido.goles_local > _partido.goles_visitante THEN
			UPDATE historial_equipo_temp SET victorias = victorias + 1 WHERE id_equipo = _partido.id_local AND id_temporada = _idt;	
			UPDATE historial_equipo_temp SET derrotas = derrotas + 1 WHERE id_equipo = _partido.id_visitante AND id_temporada = _idt;	
		ELSIF _partido.goles_visitante > _partido.goles_local THEN
			UPDATE historial_equipo_temp SET derrotas = derrotas + 1 WHERE id_equipo = _partido.id_local AND id_temporada = _idt;	
			UPDATE historial_equipo_temp SET victorias = victorias + 1 WHERE id_equipo = _partido.id_visitante AND id_temporada = _idt;	
		ELSE
			UPDATE historial_equipo_temp SET empates = empates + 1 WHERE id_equipo = _partido.id_local AND id_temporada = _idt;	
			UPDATE historial_equipo_temp SET empates = empates + 1 WHERE id_equipo = _partido.id_visitante AND id_temporada = _idt;	
		END IF;
	END LOOP;
	CLOSE cur_partidos;
	RETURN 'GENERACION DE HISTORIAL CONCLUIDA';
END
$$ LANGUAGE plpgsql;

DROP FUNCTION obtener_historial();
CREATE OR REPLACE FUNCTION obtener_historial()
   RETURNS text AS $$
DECLARE
	_temporada TEMPORADA;
	cur_temporadas CURSOR FOR 
		SELECT * FROM temporada;
BEGIN
	DELETE FROM historial_equipo_temp;
	OPEN cur_temporadas;
	LOOP
		FETCH cur_temporadas INTO _temporada;
		EXIT WHEN NOT FOUND;

		INSERT INTO historial_equipo_temp (
		SELECT nextval('seq_historial_equipo_temp'), id_temporada, id_equipo, 0, 0, 0 FROM participacion
		WHERE participacion.id_temporada = _temporada.id_temporada);

		PERFORM obtener_historial_equipo_temporada(_temporada.id_temporada);

	END LOOP;
	CLOSE cur_temporadas;
	RETURN 'PROCESO TERMINADO';
END
$$ LANGUAGE plpgsql;
