DROP FUNCTION actualizar_liga_temp(INTEGER);
CREATE OR REPLACE FUNCTION actualizar_liga_temp(_idt INTEGER)
   RETURNS text AS $$
DECLARE
	count_partidos INTEGER DEFAULT 0;
	_partido PARTIDO; 
	_ide INTEGER;
	cur_partidos CURSOR (_idt INTEGER) FOR 
		SELECT * FROM partido, jornada
		WHERE partido.id_jornada = jornada.id_jornada 
		AND jornada.id_temporada = _idt;
BEGIN
	-- Limpiar tabla liga_temp
	DELETE FROM liga_temp;

	-- LLenar tabla liga_temp con valores iniciales
	INSERT INTO liga_temp (
	SELECT nextval('seq_liga_temp'), 0, 0, 0, id_temporada, id_equipo FROM participacion
	WHERE participacion.id_temporada = _idt);

	OPEN cur_partidos (_idt);
	LOOP
		FETCH cur_partidos INTO _partido;
		EXIT WHEN NOT FOUND;

		-- Actualizar goles a favor y en contra
		UPDATE liga_temp 
		SET goles_a_favor = goles_a_favor + _partido.goles_local, 
		    goles_en_contra = goles_en_contra + _partido.goles_visitante 
		WHERE id_equipo = _partido.id_local;	

		UPDATE liga_temp 
		SET goles_a_favor = goles_a_favor + _partido.goles_visitante, 
		    goles_en_contra = goles_en_contra + _partido.goles_local 
		WHERE id_equipo = _partido.id_visitante;	

		-- Actualizar punteos
		IF _partido.goles_local > _partido.goles_visitante THEN
			UPDATE liga_temp SET punteo = punteo + 3 WHERE id_equipo = _partido.id_local;	
		ELSIF _partido.goles_visitante > _partido.goles_local THEN
			UPDATE liga_temp SET punteo = punteo + 3 WHERE id_equipo = _partido.id_visitante;	
		ELSE
			UPDATE liga_temp SET punteo = punteo + 1 WHERE id_equipo = _partido.id_local;	
			UPDATE liga_temp SET punteo = punteo + 1 WHERE id_equipo = _partido.id_visitante;	
		END IF;
		count_partidos := count_partidos + 1;
	END LOOP;
	CLOSE cur_partidos;
	RETURN count_partidos;
END
$$ LANGUAGE plpgsql;

SELECT actualizar_liga_temp(96);

select * from temporada
select equipo.nombre, punteo, goles_a_favor, goles_en_contra from liga_temp, equipo
where equipo.id_equipo = liga_temp.id_equipo
order by punteo desc;