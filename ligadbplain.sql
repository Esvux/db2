--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.14
-- Dumped by pg_dump version 9.5.14

-- Started on 2018-11-01 00:03:59

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2205 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 189 (class 1259 OID 16426)
-- Name: equipo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.equipo (
    id_equipo integer NOT NULL,
    nombre character varying(150) NOT NULL
);


ALTER TABLE public.equipo OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 16448)
-- Name: goleador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goleador (
    id_goleador integer NOT NULL,
    nombre character varying(150) NOT NULL,
    goles integer DEFAULT 0 NOT NULL,
    id_temporada integer NOT NULL
);


ALTER TABLE public.goleador OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16411)
-- Name: jornada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jornada (
    id_jornada integer NOT NULL,
    numero integer NOT NULL,
    nombre character varying(50) NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    id_temporada integer NOT NULL
);


ALTER TABLE public.jornada OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 16481)
-- Name: liga_temp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.liga_temp (
    id_liga_temp integer NOT NULL,
    goles_a_favor integer DEFAULT 0 NOT NULL,
    goles_en_contra integer DEFAULT 0 NOT NULL,
    punteo integer DEFAULT 0 NOT NULL,
    id_temporada integer NOT NULL,
    id_equipo integer NOT NULL
);


ALTER TABLE public.liga_temp OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16510)
-- Name: master_goleador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.master_goleador (
    id_master_goleador integer NOT NULL,
    temporada character varying(50) NOT NULL,
    jugador character varying(150) NOT NULL,
    goles integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.master_goleador OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16503)
-- Name: master_partido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.master_partido (
    id_master_partido integer NOT NULL,
    temporada character varying(50) NOT NULL,
    jornada character varying(50) NOT NULL,
    fecha character varying(50) NOT NULL,
    equipo_local character varying(150) NOT NULL,
    goles_local integer DEFAULT 0 NOT NULL,
    goles_visitante integer DEFAULT 0 NOT NULL,
    equipo_visitante character varying(150) NOT NULL
);


ALTER TABLE public.master_partido OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 16431)
-- Name: participacion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.participacion (
    id_participacion integer NOT NULL,
    id_temporada integer NOT NULL,
    id_equipo integer
);


ALTER TABLE public.participacion OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 16459)
-- Name: partido; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.partido (
    id_partido integer NOT NULL,
    id_local integer NOT NULL,
    id_visitante integer NOT NULL,
    fecha date NOT NULL,
    goles_local integer DEFAULT 0 NOT NULL,
    goles_visitante integer DEFAULT 0 NOT NULL,
    id_jornada integer NOT NULL
);


ALTER TABLE public.partido OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16405)
-- Name: seq_equipo; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_equipo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_equipo OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 16407)
-- Name: seq_goleador; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_goleador
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_goleador OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 16401)
-- Name: seq_jornada; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_jornada
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_jornada OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16409)
-- Name: seq_liga_temp; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_liga_temp
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_liga_temp OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16501)
-- Name: seq_master_goleador; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_master_goleador
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_master_goleador OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 16499)
-- Name: seq_master_partido; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_master_partido
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_master_partido OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16446)
-- Name: seq_participacion; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_participacion
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_participacion OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16403)
-- Name: seq_partido; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_partido
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_partido OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 16399)
-- Name: seq_temporada; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_temporada
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_temporada OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16394)
-- Name: temporada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temporada (
    id_temporada integer NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.temporada OWNER TO postgres;

--
-- TOC entry 2187 (class 0 OID 16426)
-- Dependencies: 189
-- Data for Name: equipo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.equipo (id_equipo, nombre) FROM stdin;
\.


--
-- TOC entry 2190 (class 0 OID 16448)
-- Dependencies: 192
-- Data for Name: goleador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goleador (id_goleador, nombre, goles, id_temporada) FROM stdin;
\.


--
-- TOC entry 2186 (class 0 OID 16411)
-- Dependencies: 188
-- Data for Name: jornada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jornada (id_jornada, numero, nombre, fecha_inicio, fecha_fin, id_temporada) FROM stdin;
\.


--
-- TOC entry 2192 (class 0 OID 16481)
-- Dependencies: 194
-- Data for Name: liga_temp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.liga_temp (id_liga_temp, goles_a_favor, goles_en_contra, punteo, id_temporada, id_equipo) FROM stdin;
\.


--
-- TOC entry 2196 (class 0 OID 16510)
-- Dependencies: 198
-- Data for Name: master_goleador; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.master_goleador (id_master_goleador, temporada, jugador, goles) FROM stdin;
\.


--
-- TOC entry 2195 (class 0 OID 16503)
-- Dependencies: 197
-- Data for Name: master_partido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.master_partido (id_master_partido, temporada, jornada, fecha, equipo_local, goles_local, goles_visitante, equipo_visitante) FROM stdin;
\.


--
-- TOC entry 2188 (class 0 OID 16431)
-- Dependencies: 190
-- Data for Name: participacion; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.participacion (id_participacion, id_temporada, id_equipo) FROM stdin;
\.


--
-- TOC entry 2191 (class 0 OID 16459)
-- Dependencies: 193
-- Data for Name: partido; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.partido (id_partido, id_local, id_visitante, fecha, goles_local, goles_visitante, id_jornada) FROM stdin;
\.


--
-- TOC entry 2206 (class 0 OID 0)
-- Dependencies: 185
-- Name: seq_equipo; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_equipo', 1, false);


--
-- TOC entry 2207 (class 0 OID 0)
-- Dependencies: 186
-- Name: seq_goleador; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_goleador', 1, false);


--
-- TOC entry 2208 (class 0 OID 0)
-- Dependencies: 183
-- Name: seq_jornada; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_jornada', 1, false);


--
-- TOC entry 2209 (class 0 OID 0)
-- Dependencies: 187
-- Name: seq_liga_temp; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_liga_temp', 1, false);


--
-- TOC entry 2210 (class 0 OID 0)
-- Dependencies: 196
-- Name: seq_master_goleador; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_master_goleador', 1, false);


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 195
-- Name: seq_master_partido; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_master_partido', 1, false);


--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 191
-- Name: seq_participacion; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_participacion', 1, false);


--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 184
-- Name: seq_partido; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_partido', 1, false);


--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 182
-- Name: seq_temporada; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_temporada', 1, false);


--
-- TOC entry 2179 (class 0 OID 16394)
-- Dependencies: 181
-- Data for Name: temporada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temporada (id_temporada, fecha_inicio, fecha_fin, nombre) FROM stdin;
\.


--
-- TOC entry 2043 (class 2606 OID 16430)
-- Name: pk_equipo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.equipo
    ADD CONSTRAINT pk_equipo PRIMARY KEY (id_equipo);


--
-- TOC entry 2047 (class 2606 OID 16453)
-- Name: pk_goleador; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goleador
    ADD CONSTRAINT pk_goleador PRIMARY KEY (id_goleador);


--
-- TOC entry 2041 (class 2606 OID 16415)
-- Name: pk_jornada; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jornada
    ADD CONSTRAINT pk_jornada PRIMARY KEY (id_jornada);


--
-- TOC entry 2051 (class 2606 OID 16488)
-- Name: pk_liga_temp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liga_temp
    ADD CONSTRAINT pk_liga_temp PRIMARY KEY (id_liga_temp);


--
-- TOC entry 2055 (class 2606 OID 16515)
-- Name: pk_master_goleador; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_goleador
    ADD CONSTRAINT pk_master_goleador PRIMARY KEY (id_master_goleador);


--
-- TOC entry 2053 (class 2606 OID 16509)
-- Name: pk_master_partido; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.master_partido
    ADD CONSTRAINT pk_master_partido PRIMARY KEY (id_master_partido);


--
-- TOC entry 2045 (class 2606 OID 16435)
-- Name: pk_participacion; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion
    ADD CONSTRAINT pk_participacion PRIMARY KEY (id_participacion);


--
-- TOC entry 2049 (class 2606 OID 16465)
-- Name: pk_partido; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT pk_partido PRIMARY KEY (id_partido);


--
-- TOC entry 2039 (class 2606 OID 16398)
-- Name: pk_temporada; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temporada
    ADD CONSTRAINT pk_temporada PRIMARY KEY (id_temporada);


--
-- TOC entry 2059 (class 2606 OID 16454)
-- Name: fk_goleador_temporada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goleador
    ADD CONSTRAINT fk_goleador_temporada FOREIGN KEY (id_temporada) REFERENCES public.temporada(id_temporada) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2056 (class 2606 OID 16421)
-- Name: fk_jornada_temporada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jornada
    ADD CONSTRAINT fk_jornada_temporada FOREIGN KEY (id_temporada) REFERENCES public.temporada(id_temporada) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2064 (class 2606 OID 16494)
-- Name: fk_liga_temp_equipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liga_temp
    ADD CONSTRAINT fk_liga_temp_equipo FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2063 (class 2606 OID 16489)
-- Name: fk_liga_temp_temporada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.liga_temp
    ADD CONSTRAINT fk_liga_temp_temporada FOREIGN KEY (id_temporada) REFERENCES public.temporada(id_temporada) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2058 (class 2606 OID 16441)
-- Name: fk_participacion_equipo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion
    ADD CONSTRAINT fk_participacion_equipo FOREIGN KEY (id_equipo) REFERENCES public.equipo(id_equipo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2057 (class 2606 OID 16436)
-- Name: fk_participacion_temporada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.participacion
    ADD CONSTRAINT fk_participacion_temporada FOREIGN KEY (id_temporada) REFERENCES public.temporada(id_temporada) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2062 (class 2606 OID 16476)
-- Name: fk_partido_jornada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT fk_partido_jornada FOREIGN KEY (id_jornada) REFERENCES public.jornada(id_jornada) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2060 (class 2606 OID 16466)
-- Name: fk_partido_local; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT fk_partido_local FOREIGN KEY (id_local) REFERENCES public.equipo(id_equipo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2061 (class 2606 OID 16471)
-- Name: fk_partido_visitante; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.partido
    ADD CONSTRAINT fk_partido_visitante FOREIGN KEY (id_visitante) REFERENCES public.equipo(id_equipo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2204 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2018-11-01 00:04:00

--
-- PostgreSQL database dump complete
--

