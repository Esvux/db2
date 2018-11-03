DROP FUNCTION actualizar_pichichi();
CREATE OR REPLACE FUNCTION actualizar_pichichi()
   RETURNS text AS $$
DECLARE
	_temporada TEMPORADA;
	cur_temporadas CURSOR FOR 
		SELECT * FROM temporada;
BEGIN
	DELETE FROM pichichi_temp;
	OPEN cur_temporadas;
	LOOP
		FETCH cur_temporadas INTO _temporada;
		EXIT WHEN NOT FOUND;
		INSERT INTO pichichi_temp (
		SELECT id_jugador, goles, id_temporada, nextval('seq_pichichi_temp') FROM record
		WHERE record.id_temporada = _temporada.id_temporada
		ORDER BY goles desc
		LIMIT 1);
	END LOOP;
	CLOSE cur_temporadas;
	RETURN 'PROCESO TERMINADO';
END
$$ LANGUAGE plpgsql;
