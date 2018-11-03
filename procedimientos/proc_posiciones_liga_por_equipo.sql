DROP FUNCTION obtener_posiciones_liga_por_equipo(_ide INTEGER);
CREATE OR REPLACE FUNCTION obtener_posiciones_liga_por_equipo(_ide INTEGER)
   RETURNS text AS $$
DECLARE
	_temporada TEMPORADA;
	cur_temporadas CURSOR FOR 
		SELECT * FROM temporada;
BEGIN
	DELETE FROM ganadores_temp;
	DELETE FROM posicion_equipo_temp;
	OPEN cur_temporadas;
	LOOP
		FETCH cur_temporadas INTO _temporada;
		EXIT WHEN NOT FOUND;
		PERFORM actualizar_liga_temp(_temporada.id_temporada);

		DELETE FROM ganadores_temp;

		INSERT INTO ganadores_temp (
		SELECT nextval('seq_ganadores_temp'), _temporada.id_temporada, id_equipo, punteo, goles_a_favor, goles_en_contra, ROW_NUMBER() OVER(ORDER BY punteo desc) AS posicion FROM liga_temp);

		INSERT INTO posicion_equipo_temp (
		SELECT nextval('seq_posicion_equipo_temp'), _temporada.id_temporada, id_equipo, punteo, posicion, goles_a_favor, goles_en_contra FROM ganadores_temp 
		WHERE id_equipo = _ide);

	END LOOP;
	CLOSE cur_temporadas;
	RETURN 'PROCESO TERMINADO';
END
$$ LANGUAGE plpgsql;