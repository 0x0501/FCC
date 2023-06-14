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

DROP DATABASE worldcup;
--
-- Name: worldcup; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE worldcup WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE worldcup OWNER TO freecodecamp;

\connect worldcup

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying(20) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (65, 2018, 'Final', 241, 243, 4, 2);
INSERT INTO public.games VALUES (66, 2018, 'Third Place', 242, 245, 2, 0);
INSERT INTO public.games VALUES (67, 2018, 'Semi-Final', 243, 245, 2, 1);
INSERT INTO public.games VALUES (68, 2018, 'Semi-Final', 241, 242, 1, 0);
INSERT INTO public.games VALUES (69, 2018, 'Quarter-Final', 243, 244, 3, 2);
INSERT INTO public.games VALUES (70, 2018, 'Quarter-Final', 245, 249, 2, 0);
INSERT INTO public.games VALUES (71, 2018, 'Quarter-Final', 242, 246, 2, 1);
INSERT INTO public.games VALUES (72, 2018, 'Quarter-Final', 241, 247, 2, 0);
INSERT INTO public.games VALUES (73, 2018, 'Eighth-Final', 245, 248, 2, 1);
INSERT INTO public.games VALUES (74, 2018, 'Eighth-Final', 249, 263, 1, 0);
INSERT INTO public.games VALUES (75, 2018, 'Eighth-Final', 242, 250, 3, 2);
INSERT INTO public.games VALUES (76, 2018, 'Eighth-Final', 246, 251, 2, 0);
INSERT INTO public.games VALUES (77, 2018, 'Eighth-Final', 243, 252, 2, 1);
INSERT INTO public.games VALUES (78, 2018, 'Eighth-Final', 244, 253, 2, 1);
INSERT INTO public.games VALUES (79, 2018, 'Eighth-Final', 247, 254, 2, 1);
INSERT INTO public.games VALUES (80, 2018, 'Eighth-Final', 241, 255, 4, 3);
INSERT INTO public.games VALUES (81, 2014, 'Final', 256, 255, 1, 0);
INSERT INTO public.games VALUES (82, 2014, 'Third Place', 257, 246, 3, 0);
INSERT INTO public.games VALUES (83, 2014, 'Semi-Final', 255, 257, 1, 0);
INSERT INTO public.games VALUES (84, 2014, 'Semi-Final', 256, 246, 7, 1);
INSERT INTO public.games VALUES (85, 2014, 'Quarter-Final', 257, 258, 1, 0);
INSERT INTO public.games VALUES (86, 2014, 'Quarter-Final', 255, 242, 1, 0);
INSERT INTO public.games VALUES (87, 2014, 'Quarter-Final', 246, 248, 2, 1);
INSERT INTO public.games VALUES (88, 2014, 'Quarter-Final', 256, 241, 1, 0);
INSERT INTO public.games VALUES (89, 2014, 'Eighth-Final', 246, 259, 2, 1);
INSERT INTO public.games VALUES (90, 2014, 'Eighth-Final', 248, 247, 2, 0);
INSERT INTO public.games VALUES (91, 2014, 'Eighth-Final', 241, 260, 2, 0);
INSERT INTO public.games VALUES (92, 2014, 'Eighth-Final', 256, 261, 2, 1);
INSERT INTO public.games VALUES (93, 2014, 'Eighth-Final', 257, 251, 2, 1);
INSERT INTO public.games VALUES (94, 2014, 'Eighth-Final', 258, 262, 2, 1);
INSERT INTO public.games VALUES (95, 2014, 'Eighth-Final', 255, 263, 1, 0);
INSERT INTO public.games VALUES (96, 2014, 'Eighth-Final', 242, 264, 2, 1);


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.teams VALUES (241, 'France');
INSERT INTO public.teams VALUES (242, 'Belgium');
INSERT INTO public.teams VALUES (243, 'Croatia');
INSERT INTO public.teams VALUES (244, 'Russia');
INSERT INTO public.teams VALUES (245, 'England');
INSERT INTO public.teams VALUES (246, 'Brazil');
INSERT INTO public.teams VALUES (247, 'Uruguay');
INSERT INTO public.teams VALUES (248, 'Colombia');
INSERT INTO public.teams VALUES (249, 'Sweden');
INSERT INTO public.teams VALUES (250, 'Japan');
INSERT INTO public.teams VALUES (251, 'Mexico');
INSERT INTO public.teams VALUES (252, 'Denmark');
INSERT INTO public.teams VALUES (253, 'Spain');
INSERT INTO public.teams VALUES (254, 'Portugal');
INSERT INTO public.teams VALUES (255, 'Argentina');
INSERT INTO public.teams VALUES (256, 'Germany');
INSERT INTO public.teams VALUES (257, 'Netherlands');
INSERT INTO public.teams VALUES (258, 'Costa Rica');
INSERT INTO public.teams VALUES (259, 'Chile');
INSERT INTO public.teams VALUES (260, 'Nigeria');
INSERT INTO public.teams VALUES (261, 'Algeria');
INSERT INTO public.teams VALUES (262, 'Greece');
INSERT INTO public.teams VALUES (263, 'Switzerland');
INSERT INTO public.teams VALUES (264, 'United States');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 96, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 264, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

