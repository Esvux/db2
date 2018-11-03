CREATE FUNCTION get_jugadorid(nombre text) RETURNS int
AS $$
#print_strict_params on
DECLARE
id_jugador int;
BEGIN
    SELECT jugador.id_jugador INTO STRICT id_jugador
        FROM jugador WHERE jugador.nombre = get_jugadorid.nombre;
    RETURN id_jugador;
END
$$ LANGUAGE plpgsql;

SELECT get_jugadorid('Alfonso');