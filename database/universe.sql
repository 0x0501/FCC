--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: blackhole; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.blackhole (
    blackhole_id integer NOT NULL,
    name character varying(60) NOT NULL,
    speicial_code integer
);


ALTER TABLE public.blackhole OWNER TO freecodecamp;

--
-- Name: blackhole_blackhole_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.blackhole_blackhole_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.blackhole_blackhole_id_seq OWNER TO freecodecamp;

--
-- Name: blackhole_blackhole_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.blackhole_blackhole_id_seq OWNED BY public.blackhole.blackhole_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(60) NOT NULL,
    weight integer,
    gravity integer,
    is_black_hole boolean DEFAULT false
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(60) NOT NULL,
    planet_id integer,
    orbit_altitude numeric,
    weight integer,
    tag text
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(60) NOT NULL,
    radius numeric,
    weight integer,
    is_neutron_star boolean DEFAULT false,
    star_id integer
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(60) NOT NULL,
    radius numeric,
    is_fixed_star boolean DEFAULT false,
    galaxy_id integer
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: blackhole blackhole_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.blackhole ALTER COLUMN blackhole_id SET DEFAULT nextval('public.blackhole_blackhole_id_seq'::regclass);


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Data for Name: blackhole; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.blackhole VALUES (1, 'B1', 501);
INSERT INTO public.blackhole VALUES (2, 'C21', 652);
INSERT INTO public.blackhole VALUES (3, 'K85', 102);
INSERT INTO public.blackhole VALUES (4, 'L9', 245);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'T1', 256, 1200, false);
INSERT INTO public.galaxy VALUES (2, 'T2', 100, 1000, false);
INSERT INTO public.galaxy VALUES (3, 'T3', 160, 1100, false);
INSERT INTO public.galaxy VALUES (4, 'T4', 248, 900, false);
INSERT INTO public.galaxy VALUES (5, 'T5', 100, 2000, false);
INSERT INTO public.galaxy VALUES (6, 'T6', 300, 1425, false);
INSERT INTO public.galaxy VALUES (7, 'T7', 230, 658, false);
INSERT INTO public.galaxy VALUES (8, 'T8', 324, 1000, false);
INSERT INTO public.galaxy VALUES (9, 'T9', 2454, 2486, false);
INSERT INTO public.galaxy VALUES (10, 'T10', 3465, 45566, false);
INSERT INTO public.galaxy VALUES (11, 'T11', 2345, 3781, false);
INSERT INTO public.galaxy VALUES (12, 'T12', 346, 275, false);
INSERT INTO public.galaxy VALUES (13, 'T13', 2455, 245, false);
INSERT INTO public.galaxy VALUES (14, 'T14', 34523, 24810, false);
INSERT INTO public.galaxy VALUES (15, 'T15', 54655, 4514, false);
INSERT INTO public.galaxy VALUES (16, 'T16', 2455, 2450, false);
INSERT INTO public.galaxy VALUES (17, 'T17', 492, 2495, false);
INSERT INTO public.galaxy VALUES (18, 'T18', 4838, 24931, false);
INSERT INTO public.galaxy VALUES (19, 'T19', 545, 4784, false);
INSERT INTO public.galaxy VALUES (20, 'T20', 7554, 7855, false);
INSERT INTO public.galaxy VALUES (21, 'T21', 5757, 24620, false);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 'Apollo 21', 1, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (2, 'Space 1', 2, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (3, 'Space 2', 3, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (4, 'Shining Dog Cloud', 4, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (5, 'Apollo 20', 5, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (6, 'Apollo 18', 6, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (7, 'Buster', 7, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (8, 'Blood Moon', 8, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (10, 'K1', 9, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (11, 'K2', 10, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (12, 'K3', 11, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (13, 'K4', 12, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (14, 'K5', 13, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (15, 'K6', 14, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (16, 'K7', 15, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (17, 'K8', 16, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (18, 'K9', 17, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (19, 'K10', 18, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (20, 'K11', 19, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (21, 'K12', 20, NULL, NULL, NULL);
INSERT INTO public.moon VALUES (22, 'K13', 21, NULL, NULL, NULL);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, '0x01', 1256.5, 64525, false, 1);
INSERT INTO public.planet VALUES (2, '0x02', 48465.56, 64552, false, 2);
INSERT INTO public.planet VALUES (3, 'Black Star', 65452.25, 756515, false, 3);
INSERT INTO public.planet VALUES (4, '0x03', 4656.57, 6652, false, 4);
INSERT INTO public.planet VALUES (5, 'Queen Z21', 46856.22, 64542, false, 5);
INSERT INTO public.planet VALUES (6, 'Z 82', 485.16, 3146, false, 6);
INSERT INTO public.planet VALUES (7, '0x04', 234554.15, 24575, false, 7);
INSERT INTO public.planet VALUES (8, 'JacK 2180', 4648.165, 2655, false, 8);
INSERT INTO public.planet VALUES (9, 'Uksak', 2456.25, 45686, false, 9);
INSERT INTO public.planet VALUES (10, 'Salura', 4567.25, 256, false, 10);
INSERT INTO public.planet VALUES (11, 'Kebusaka', 2565.21, 32323, false, 11);
INSERT INTO public.planet VALUES (12, 'Wakasude', 3245.2, 1645, false, 12);
INSERT INTO public.planet VALUES (13, 'Immogula', 257.25, 42545, false, 13);
INSERT INTO public.planet VALUES (14, 'Opinia', 864.5, 5755, false, 14);
INSERT INTO public.planet VALUES (15, 'Lilly 1', 2349.16, 2976, false, 15);
INSERT INTO public.planet VALUES (16, 'Hijki', 2468.1, 4655, false, 16);
INSERT INTO public.planet VALUES (17, 'Googdy', 8373.232, 2772, false, 17);
INSERT INTO public.planet VALUES (18, 'Eddy 2', 892.2, 292, false, 18);
INSERT INTO public.planet VALUES (19, 'Musk', 24568.15, 2468941, false, 19);
INSERT INTO public.planet VALUES (20, 'Ketta', 2456.25, 8643, false, 20);
INSERT INTO public.planet VALUES (21, 'Nika', 246.25, 120, false, 21);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Kelly N1', 2550, false, 1);
INSERT INTO public.star VALUES (3, 'Vet Yat', 8600, false, 3);
INSERT INTO public.star VALUES (5, 'Oscar Star', 21402, false, 5);
INSERT INTO public.star VALUES (6, 'Tiddy 215', 6654, false, 6);
INSERT INTO public.star VALUES (7, 'Lake Shnne', 2456, false, 7);
INSERT INTO public.star VALUES (8, 'Ave 8', 65458, false, 8);
INSERT INTO public.star VALUES (4, 'Keple Z1', 45220, true, 4);
INSERT INTO public.star VALUES (2, 'Bulk Star', 6000, true, 2);
INSERT INTO public.star VALUES (9, 'Keple Z2', 4545, false, 9);
INSERT INTO public.star VALUES (10, 'Jekky', 7946, false, 10);
INSERT INTO public.star VALUES (11, 'Omini Star', 4552, false, 11);
INSERT INTO public.star VALUES (12, 'Kelly 29', 2495, false, 12);
INSERT INTO public.star VALUES (13, 'Frigile Darck', 17846, false, 13);
INSERT INTO public.star VALUES (14, 'Quennsland 215', 1987, false, 14);
INSERT INTO public.star VALUES (15, 'High 98', 2458, false, 15);
INSERT INTO public.star VALUES (16, 'Sad Bug', 24586, false, 16);
INSERT INTO public.star VALUES (17, 'Hug Wing', 1458, false, 17);
INSERT INTO public.star VALUES (18, 'Yuuki', 4575, false, 18);
INSERT INTO public.star VALUES (19, 'Illing', 455, false, 19);
INSERT INTO public.star VALUES (20, 'Polling', 2456, false, 20);
INSERT INTO public.star VALUES (21, 'Hall Ting', 9867, false, 21);


--
-- Name: blackhole_blackhole_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.blackhole_blackhole_id_seq', 4, true);


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 21, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 22, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 21, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 21, true);


--
-- Name: blackhole blackhole_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.blackhole
    ADD CONSTRAINT blackhole_pkey PRIMARY KEY (blackhole_id);


--
-- Name: blackhole blackhole_speicial_code_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.blackhole
    ADD CONSTRAINT blackhole_speicial_code_key UNIQUE (speicial_code);


--
-- Name: galaxy galaxy_galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: moon moon_planet_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_key UNIQUE (planet_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet planet_star_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_key UNIQUE (star_id);


--
-- Name: star star_galaxy_id_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_key UNIQUE (galaxy_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

