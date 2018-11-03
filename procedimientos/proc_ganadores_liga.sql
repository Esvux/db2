DROP FUNCTION obtener_ganadores_liga();
CREATE OR REPLACE FUNCTION obtener_ganadores_liga()
   RETURNS text AS $$
DECLARE
	_temporada TEMPORADA;
	cur_temporadas CURSOR FOR 
		SELECT * FROM temporada;
BEGIN
	DELETE FROM ganadores_temp;
	OPEN cur_temporadas;
	LOOP
		FETCH cur_temporadas INTO _temporada;
		EXIT WHEN NOT FOUND;
		PERFORM actualizar_liga_temp(_temporada.id_temporada);
		INSERT INTO ganadores_temp (
		SELECT nextval('seq_ganadores_temp'), _temporada.id_temporada, id_equipo, punteo FROM liga_temp
		ORDER BY punteo desc
		LIMIT 1);
	END LOOP;
	CLOSE cur_temporadas;
	RETURN 'PROCESO TERMINADO';
END
$$ LANGUAGE plpgsql;


