DROP TABLE master_goleador;
CREATE TABLE public.master_goleador (
    temporada character varying(50) NOT NULL,
    jugador character varying(150) NOT NULL,
    goles integer DEFAULT 0 NOT NULL
);
ALTER TABLE public.master_goleador OWNER TO postgres;
COPY master_goleador FROM '/tmp/GoleadoresLaLiga.csv' WITH CSV HEADER;