--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Homebrew)
-- Dumped by pg_dump version 14.17 (Homebrew)

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
-- Name: appuser; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.appuser (
    userid character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    passwordhash character varying(255) NOT NULL,
    firstname character varying(50),
    lastname character varying(50),
    gender character varying(10),
    dietaryrestriction character varying(20),
    creationdate timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    lastlogin timestamp without time zone,
    isadmin boolean DEFAULT false,
    CONSTRAINT appuser_dietaryrestriction_check CHECK (((dietaryrestriction)::text = ANY ((ARRAY['none'::character varying, 'vegetarian'::character varying, 'vegan'::character varying, 'pork-free'::character varying])::text[]))),
    CONSTRAINT appuser_gender_check CHECK (((gender)::text = ANY ((ARRAY['male'::character varying, 'female'::character varying, 'other'::character varying])::text[])))
);


ALTER TABLE public.appuser OWNER TO tp_user;

--
-- Name: belongstogroup; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.belongstogroup (
    userid character varying(50) NOT NULL,
    groupname character varying(100) NOT NULL
);


ALTER TABLE public.belongstogroup OWNER TO tp_user;

--
-- Name: event; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.event (
    eventid integer NOT NULL,
    eventname character varying(100) NOT NULL,
    datetime timestamp without time zone NOT NULL,
    duration integer,
    location character varying(100),
    description text,
    userid character varying(50) NOT NULL
);


ALTER TABLE public.event OWNER TO tp_user;

--
-- Name: event_eventid_seq; Type: SEQUENCE; Schema: public; Owner: tp_user
--

CREATE SEQUENCE public.event_eventid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.event_eventid_seq OWNER TO tp_user;

--
-- Name: event_eventid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: tp_user
--

ALTER SEQUENCE public.event_eventid_seq OWNED BY public.event.eventid;


--
-- Name: instrumentsection; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.instrumentsection (
    sectionname character varying(100) NOT NULL
);


ALTER TABLE public.instrumentsection OWNER TO tp_user;

--
-- Name: participation; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.participation (
    userid character varying(50) NOT NULL,
    eventid integer NOT NULL,
    sectionname character varying(100) NOT NULL,
    status character varying(10),
    CONSTRAINT participation_status_check CHECK (((status)::text = ANY ((ARRAY['present'::character varying, 'absent'::character varying, 'uncertain'::character varying])::text[])))
);


ALTER TABLE public.participation OWNER TO tp_user;

--
-- Name: playsinsection; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.playsinsection (
    userid character varying(50) NOT NULL,
    sectionname character varying(100) NOT NULL
);


ALTER TABLE public.playsinsection OWNER TO tp_user;

--
-- Name: usergroup; Type: TABLE; Schema: public; Owner: tp_user
--

CREATE TABLE public.usergroup (
    groupname character varying(100) NOT NULL
);


ALTER TABLE public.usergroup OWNER TO tp_user;

--
-- Name: event eventid; Type: DEFAULT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.event ALTER COLUMN eventid SET DEFAULT nextval('public.event_eventid_seq'::regclass);


--
-- Data for Name: appuser; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.appuser (userid, email, passwordhash, firstname, lastname, gender, dietaryrestriction, creationdate, lastlogin, isadmin) FROM stdin;
9a4e193a-5ae6-4732-af8c-3ff335278473	admin@site.com	2af817533d66900fade12831c1764ab1f358732f4c8bfe52e05bdeca6210e458	admin1	admin2	other	pork-free	2025-05-26 00:00:00	\N	t
7424ae7c-f0c7-468b-a07b-916ff3708134	julienlrzl@icloud.com	7b3d979ca8330a94fa7e9e1b466d8b99e0bcdea1ec90596c0dcc8d7ef6b4300c	Julien2	Larzul2	male	vegan	2025-05-26 00:00:00	\N	f
a0e7dce0-24a9-46ba-a1ea-6d9c9167b667	victor.lefevre@gmail.com	7b3d979ca8330a94fa7e9e1b466d8b99e0bcdea1ec90596c0dcc8d7ef6b4300c	Victor	Lefevre	male	vegan	2025-05-26 00:00:00	\N	f
4458aa58-6b18-44d5-83d6-863724b74ec3	test@test.com	7b3d979ca8330a94fa7e9e1b466d8b99e0bcdea1ec90596c0dcc8d7ef6b4300c	<script>alert('XSS')</script>	test	male	pork-free	2025-06-03 00:00:00	\N	f
\.


--
-- Data for Name: belongstogroup; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.belongstogroup (userid, groupname) FROM stdin;
a0e7dce0-24a9-46ba-a1ea-6d9c9167b667	commission_prestation
7424ae7c-f0c7-468b-a07b-916ff3708134	commission_prestation
9a4e193a-5ae6-4732-af8c-3ff335278473	commission_prestation
\.


--
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.event (eventid, eventname, datetime, duration, location, description, userid) FROM stdin;
3	Victor en folie	2026-08-25 18:00:00	90	Martinique		a0e7dce0-24a9-46ba-a1ea-6d9c9167b667
\.


--
-- Data for Name: instrumentsection; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.instrumentsection (sectionname) FROM stdin;
clarinette
saxophone_alto
euphonium
percussion
basse
trompette
saxophone_baryton
trombone
\.


--
-- Data for Name: participation; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.participation (userid, eventid, sectionname, status) FROM stdin;
7424ae7c-f0c7-468b-a07b-916ff3708134	3	basse	present
9a4e193a-5ae6-4732-af8c-3ff335278473	3	euphonium	absent
\.


--
-- Data for Name: playsinsection; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.playsinsection (userid, sectionname) FROM stdin;
a0e7dce0-24a9-46ba-a1ea-6d9c9167b667	percussion
7424ae7c-f0c7-468b-a07b-916ff3708134	trompette
7424ae7c-f0c7-468b-a07b-916ff3708134	saxophone_baryton
\.


--
-- Data for Name: usergroup; Type: TABLE DATA; Schema: public; Owner: tp_user
--

COPY public.usergroup (groupname) FROM stdin;
commission_prestation
commission_artistique
commission_logistique
commission_communication_interne
\.


--
-- Name: event_eventid_seq; Type: SEQUENCE SET; Schema: public; Owner: tp_user
--

SELECT pg_catalog.setval('public.event_eventid_seq', 3, true);


--
-- Name: appuser appuser_email_key; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.appuser
    ADD CONSTRAINT appuser_email_key UNIQUE (email);


--
-- Name: appuser appuser_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.appuser
    ADD CONSTRAINT appuser_pkey PRIMARY KEY (userid);


--
-- Name: belongstogroup belongstogroup_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.belongstogroup
    ADD CONSTRAINT belongstogroup_pkey PRIMARY KEY (userid, groupname);


--
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (eventid);


--
-- Name: instrumentsection instrumentsection_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.instrumentsection
    ADD CONSTRAINT instrumentsection_pkey PRIMARY KEY (sectionname);


--
-- Name: participation participation_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_pkey PRIMARY KEY (userid, eventid, sectionname);


--
-- Name: playsinsection playsinsection_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.playsinsection
    ADD CONSTRAINT playsinsection_pkey PRIMARY KEY (userid, sectionname);


--
-- Name: usergroup usergroup_pkey; Type: CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.usergroup
    ADD CONSTRAINT usergroup_pkey PRIMARY KEY (groupname);


--
-- Name: belongstogroup belongstogroup_groupname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.belongstogroup
    ADD CONSTRAINT belongstogroup_groupname_fkey FOREIGN KEY (groupname) REFERENCES public.usergroup(groupname);


--
-- Name: belongstogroup belongstogroup_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.belongstogroup
    ADD CONSTRAINT belongstogroup_userid_fkey FOREIGN KEY (userid) REFERENCES public.appuser(userid);


--
-- Name: event event_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_userid_fkey FOREIGN KEY (userid) REFERENCES public.appuser(userid);


--
-- Name: participation participation_eventid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_eventid_fkey FOREIGN KEY (eventid) REFERENCES public.event(eventid);


--
-- Name: participation participation_sectionname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_sectionname_fkey FOREIGN KEY (sectionname) REFERENCES public.instrumentsection(sectionname);


--
-- Name: participation participation_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.participation
    ADD CONSTRAINT participation_userid_fkey FOREIGN KEY (userid) REFERENCES public.appuser(userid);


--
-- Name: playsinsection playsinsection_sectionname_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.playsinsection
    ADD CONSTRAINT playsinsection_sectionname_fkey FOREIGN KEY (sectionname) REFERENCES public.instrumentsection(sectionname);


--
-- Name: playsinsection playsinsection_userid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: tp_user
--

ALTER TABLE ONLY public.playsinsection
    ADD CONSTRAINT playsinsection_userid_fkey FOREIGN KEY (userid) REFERENCES public.appuser(userid);


--
-- PostgreSQL database dump complete
--

