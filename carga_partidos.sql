DROP TABLE csv_partido;
DROP TABLE master_partido;
CREATE TABLE public.csv_partido (
    temporada character varying(50) NOT NULL,
    jornada character varying(50) NOT NULL,
    fecha character varying(50) NOT NULL,
    equipo_local character varying(150) NOT NULL,
    goles_local integer DEFAULT 0 NOT NULL,
    goles_visitante integer DEFAULT 0 NOT NULL,
    equipo_visitante character varying(150) NOT NULL
);
ALTER TABLE public.csv_partido OWNER TO postgres;
CREATE TABLE public.master_partido (
    temporada character varying(50) NOT NULL,
    jornada character varying(50) NOT NULL,
    fecha date NOT NULL,
    equipo_local character varying(150) NOT NULL,
    goles_local integer DEFAULT 0 NOT NULL,
    goles_visitante integer DEFAULT 0 NOT NULL,
    equipo_visitante character varying(150) NOT NULL
);
ALTER TABLE public.master_partido OWNER TO postgres;
COPY csv_partido FROM '/tmp/PartidosLaLiga.csv' WITH CSV HEADER;
INSERT INTO master_partido (
	SELECT temporada, jornada, TO_DATE(fecha, 'DD/MM/YYYY') as fecha, equipo_local, goles_local, goles_visitante, equipo_visitante
	FROM csv_partido
);