--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3 (Debian 13.3-1.pgdg100+1)
-- Dumped by pg_dump version 17.0

-- Started on 2025-11-22 00:04:32

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3001 (class 1262 OID 45837)
-- Name: tinder_clone; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE tinder_clone WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE tinder_clone OWNER TO postgres;

\connect tinder_clone

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 209 (class 1259 OID 45953)
-- Name: likes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.likes (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    people_id bigint NOT NULL,
    status character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT likes_status_check CHECK (((status)::text = ANY ((ARRAY['like'::character varying, 'dislike'::character varying])::text[])))
);


ALTER TABLE public.likes OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 45951)
-- Name: likes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.likes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.likes_id_seq OWNER TO postgres;

--
-- TOC entry 3003 (class 0 OID 0)
-- Dependencies: 208
-- Name: likes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.likes_id_seq OWNED BY public.likes.id;


--
-- TOC entry 201 (class 1259 OID 45905)
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 45903)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- TOC entry 3004 (class 0 OID 0)
-- Dependencies: 200
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 205 (class 1259 OID 45927)
-- Name: people; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.people (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    age integer NOT NULL,
    location integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    bio text
);


ALTER TABLE public.people OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 45925)
-- Name: people_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.people_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.people_id_seq OWNER TO postgres;

--
-- TOC entry 3005 (class 0 OID 0)
-- Dependencies: 204
-- Name: people_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.people_id_seq OWNED BY public.people.id;


--
-- TOC entry 203 (class 1259 OID 45913)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 45911)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.personal_access_tokens_id_seq OWNER TO postgres;

--
-- TOC entry 3006 (class 0 OID 0)
-- Dependencies: 202
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 207 (class 1259 OID 45935)
-- Name: pictures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pictures (
    id bigint NOT NULL,
    people_id bigint NOT NULL,
    photo_url text NOT NULL,
    sort_order integer DEFAULT 1 NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.pictures OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 45933)
-- Name: pictures_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pictures_id_seq OWNER TO postgres;

--
-- TOC entry 3007 (class 0 OID 0)
-- Dependencies: 206
-- Name: pictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pictures_id_seq OWNED BY public.pictures.id;


--
-- TOC entry 2835 (class 2604 OID 45956)
-- Name: likes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes ALTER COLUMN id SET DEFAULT nextval('public.likes_id_seq'::regclass);


--
-- TOC entry 2830 (class 2604 OID 45908)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 2832 (class 2604 OID 45930)
-- Name: people id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people ALTER COLUMN id SET DEFAULT nextval('public.people_id_seq'::regclass);


--
-- TOC entry 2831 (class 2604 OID 45916)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 2833 (class 2604 OID 45938)
-- Name: pictures id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictures ALTER COLUMN id SET DEFAULT nextval('public.pictures_id_seq'::regclass);


--
-- TOC entry 2995 (class 0 OID 45953)
-- Dependencies: 209
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.likes VALUES (52, 1, 5, 'dislike', '2025-11-21 16:17:59', '2025-11-21 16:17:59');
INSERT INTO public.likes VALUES (53, 1, 6, 'dislike', '2025-11-21 16:18:02', '2025-11-21 16:18:02');
INSERT INTO public.likes VALUES (54, 1, 7, 'dislike', '2025-11-21 16:18:05', '2025-11-21 16:18:05');
INSERT INTO public.likes VALUES (55, 1, 8, 'dislike', '2025-11-21 16:18:07', '2025-11-21 16:18:07');
INSERT INTO public.likes VALUES (56, 1, 9, 'dislike', '2025-11-21 16:18:08', '2025-11-21 16:18:08');
INSERT INTO public.likes VALUES (57, 1, 1, 'dislike', '2025-11-21 16:57:56', '2025-11-21 16:57:56');
INSERT INTO public.likes VALUES (49, 1, 2, 'dislike', '2025-11-21 16:02:27', '2025-11-21 16:58:00');
INSERT INTO public.likes VALUES (50, 1, 3, 'dislike', '2025-11-21 16:02:28', '2025-11-21 16:58:03');
INSERT INTO public.likes VALUES (51, 1, 4, 'dislike', '2025-11-21 16:02:29', '2025-11-21 16:58:09');
INSERT INTO public.likes VALUES (58, 1, 10, 'dislike', '2025-11-21 16:58:36', '2025-11-21 16:58:36');
INSERT INTO public.likes VALUES (59, 1, 11, 'dislike', '2025-11-21 16:58:47', '2025-11-21 16:58:47');
INSERT INTO public.likes VALUES (62, 1, 12, 'like', '2025-11-21 16:59:01', '2025-11-21 16:59:01');


--
-- TOC entry 2987 (class 0 OID 45905)
-- Dependencies: 201
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migrations VALUES (1, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO public.migrations VALUES (2, '2025_11_21_000000_create_people_table', 1);
INSERT INTO public.migrations VALUES (3, '2025_11_21_000010_create_pictures_table', 1);
INSERT INTO public.migrations VALUES (4, '2025_11_21_000020_create_likes_table', 1);
INSERT INTO public.migrations VALUES (5, '2025_11_21_000030_add_bio_to_people_table', 2);


--
-- TOC entry 2991 (class 0 OID 45927)
-- Dependencies: 205
-- Data for Name: people; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.people VALUES (1, 'Sophia', 21, 1001, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Runner');
INSERT INTO public.people VALUES (2, 'Emma', 22, 1002, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Dancer');
INSERT INTO public.people VALUES (3, 'Olivia', 23, 1003, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Traveler');
INSERT INTO public.people VALUES (4, 'Ava', 24, 1004, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Coffee lover');
INSERT INTO public.people VALUES (5, 'Isabella', 25, 1005, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Bookworm');
INSERT INTO public.people VALUES (6, 'Mia', 26, 1006, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Foodie');
INSERT INTO public.people VALUES (7, 'Amelia', 27, 1007, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Yoga lover');
INSERT INTO public.people VALUES (8, 'Harper', 28, 1008, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Musician');
INSERT INTO public.people VALUES (9, 'Evelyn', 29, 1009, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Photographer');
INSERT INTO public.people VALUES (10, 'Abigail', 30, 1010, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Movie buff');
INSERT INTO public.people VALUES (11, 'Ella', 31, 1011, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Fitness junkie');
INSERT INTO public.people VALUES (12, 'Elizabeth', 32, 1012, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Animal lover');
INSERT INTO public.people VALUES (13, 'Camila', 33, 1013, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Adventurer');
INSERT INTO public.people VALUES (14, 'Luna', 34, 1014, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Chef');
INSERT INTO public.people VALUES (15, 'Sofia', 35, 1015, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Tech geek');
INSERT INTO public.people VALUES (16, 'Emily', 36, 1016, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Artist');
INSERT INTO public.people VALUES (17, 'Avery', 37, 1017, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Movie lover');
INSERT INTO public.people VALUES (18, 'Mila', 38, 1018, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Open minded');
INSERT INTO public.people VALUES (19, 'Aria', 39, 1019, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Nature lover');
INSERT INTO public.people VALUES (20, 'Scarlett', 40, 1020, '2025-11-21 15:35:18', '2025-11-21 15:35:18', 'Social butterfly');


--
-- TOC entry 2989 (class 0 OID 45913)
-- Dependencies: 203
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2993 (class 0 OID 45935)
-- Dependencies: 207
-- Data for Name: pictures; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.pictures VALUES (1, 1, 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (2, 1, 'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (3, 1, 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (4, 1, 'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-4.0.3&auto=format&fit=crop&w=688&q=80', 4, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (5, 1, 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 5, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (6, 2, 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (7, 2, 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (13, 4, 'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (14, 4, 'https://images.unsplash.com/photo-1520038163264-9739c1eae4b3?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (22, 7, 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (23, 8, 'https://images.unsplash.com/photo-1508214751195-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=634&q=80', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (9, 2, 'https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=1061&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 4, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (24, 8, 'https://images.unsplash.com/photo-1656077727614-0ddda354698e?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (25, 8, 'https://images.unsplash.com/photo-1571234018566-1d3cc5d2991a?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (26, 8, 'https://images.unsplash.com/photo-1589156191108-c762ff4b96ab?q=80&w=986&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 4, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (27, 9, 'https://images.unsplash.com/photo-1660563115496-8040aa23fc81?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (28, 9, 'https://images.unsplash.com/photo-1529218164294-0d21b06ea831?q=80&w=988&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (29, 10, 'https://images.unsplash.com/photo-1527203561188-dae1bc1a417f?q=80&w=1015&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (30, 10, 'https://images.unsplash.com/photo-1618721405821-80ebc4b63d26?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (31, 10, 'https://images.unsplash.com/photo-1631377307475-9acfa929b062?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (32, 11, 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (35, 13, 'https://images.unsplash.com/photo-1667382137349-0f5cb5818a7c?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (39, 15, 'https://images.unsplash.com/photo-1638375114566-dc1225c61e8a?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (43, 16, 'https://images.unsplash.com/photo-1581974364779-6ff14c4b0d67?q=80&w=1462&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (46, 18, 'https://images.unsplash.com/photo-1527203561188-dae1bc1a417f?q=80&w=1015&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (8, 2, 'https://images.unsplash.com/photo-1481214110143-ed630356e1bb?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (10, 3, 'https://images.unsplash.com/photo-1602442787305-decbd65be507?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (11, 3, 'https://images.unsplash.com/photo-1636517520994-efaf5120ca13?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (12, 3, 'https://images.unsplash.com/photo-1512288094938-363287817259?q=80&w=986&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (15, 5, 'https://images.unsplash.com/photo-1507101105822-7472b28e22ac?q=80&w=1473&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (16, 5, 'https://images.unsplash.com/photo-1592489295292-47fa394cebe1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (17, 5, 'https://images.unsplash.com/photo-1548186802-3cf9fc104b32?q=80&w=985&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (19, 6, 'https://images.unsplash.com/photo-1518524953969-1f1b32b3bf70?q=80&w=986&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (20, 7, 'https://images.unsplash.com/photo-1493198032510-43d174ff561d?q=80&w=1473&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (21, 7, 'https://images.unsplash.com/photo-1506935077180-46af676a2f6d?q=80&w=1473&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (18, 6, 'https://images.unsplash.com/photo-1607748877445-23f3265d0268?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (33, 12, 'https://images.unsplash.com/photo-1558227108-83a15ddbbb15?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (34, 12, 'https://images.unsplash.com/photo-1573497019189-90a00bb1f26f?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (36, 13, 'https://images.unsplash.com/photo-1722329434628-5cc2d041ff09?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (37, 13, 'https://images.unsplash.com/photo-1526510747491-58f928ec870f?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (38, 14, 'https://images.unsplash.com/flagged/photo-1576012886127-411fc2d3f141?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (40, 15, 'https://images.unsplash.com/photo-1649624963958-554d32e28c55?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (41, 16, 'https://images.unsplash.com/photo-1689666351448-569d9b8ab970?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (42, 16, 'https://images.unsplash.com/photo-1534083220759-4c3c00112ea0?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (44, 17, 'https://images.unsplash.com/photo-1489424731084-a5d8b219a5bb?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (45, 18, 'https://images.unsplash.com/photo-1529218164294-0d21b06ea831?q=80&w=988&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (47, 19, 'https://images.unsplash.com/photo-1618721405821-80ebc4b63d26?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (48, 19, 'https://images.unsplash.com/photo-1722329434628-5cc2d041ff09?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (49, 19, 'https://images.unsplash.com/photo-1526510747491-58f928ec870f?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (50, 19, 'https://images.unsplash.com/flagged/photo-1576012886127-411fc2d3f141?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 4, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (51, 20, 'https://images.unsplash.com/photo-1668191032118-50ed3e741b2b?q=80&w=988&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 1, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (52, 20, 'https://images.unsplash.com/photo-1638375114566-dc1225c61e8a?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 2, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (53, 20, 'https://images.unsplash.com/photo-1606826370124-7e75bd8c3f4d?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 3, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (54, 20, 'https://images.unsplash.com/photo-1731159177421-24080fe3ecb1?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 4, '2025-11-21 22:53:06', '2025-11-21 22:53:06');
INSERT INTO public.pictures VALUES (55, 20, 'https://images.unsplash.com/photo-1632700454633-28ad72be520b?q=80&w=1064&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 5, '2025-11-21 22:53:06', '2025-11-21 22:53:06');


--
-- TOC entry 3008 (class 0 OID 0)
-- Dependencies: 208
-- Name: likes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.likes_id_seq', 62, true);


--
-- TOC entry 3009 (class 0 OID 0)
-- Dependencies: 200
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 5, true);


--
-- TOC entry 3010 (class 0 OID 0)
-- Dependencies: 204
-- Name: people_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.people_id_seq', 1, false);


--
-- TOC entry 3011 (class 0 OID 0)
-- Dependencies: 202
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- TOC entry 3012 (class 0 OID 0)
-- Dependencies: 206
-- Name: pictures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pictures_id_seq', 1, false);


--
-- TOC entry 2850 (class 2606 OID 45958)
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- TOC entry 2852 (class 2606 OID 45960)
-- Name: likes likes_user_id_people_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_user_id_people_id_unique UNIQUE (user_id, people_id);


--
-- TOC entry 2838 (class 2606 OID 45910)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2845 (class 2606 OID 45932)
-- Name: people people_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.people
    ADD CONSTRAINT people_pkey PRIMARY KEY (id);


--
-- TOC entry 2840 (class 2606 OID 45921)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 2842 (class 2606 OID 45924)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 2848 (class 2606 OID 45944)
-- Name: pictures pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT pictures_pkey PRIMARY KEY (id);


--
-- TOC entry 2853 (class 1259 OID 45966)
-- Name: likes_user_id_status_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX likes_user_id_status_index ON public.likes USING btree (user_id, status);


--
-- TOC entry 2843 (class 1259 OID 45922)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 2846 (class 1259 OID 45950)
-- Name: pictures_people_id_sort_order_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pictures_people_id_sort_order_index ON public.pictures USING btree (people_id, sort_order);


--
-- TOC entry 2855 (class 2606 OID 45961)
-- Name: likes likes_people_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_people_id_foreign FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE CASCADE;


--
-- TOC entry 2854 (class 2606 OID 45945)
-- Name: pictures pictures_people_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT pictures_people_id_foreign FOREIGN KEY (people_id) REFERENCES public.people(id) ON DELETE CASCADE;


--
-- TOC entry 3002 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2025-11-22 00:04:33

--
-- PostgreSQL database dump complete
--

