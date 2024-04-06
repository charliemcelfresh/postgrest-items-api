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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- Name: get_header(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_header(item text) RETURNS text
    LANGUAGE sql STABLE
    AS $$
SELECT (current_setting('request.headers', true)::json)->>item
$$;


--
-- Name: get_headers(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.get_headers() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
SELECT current_setting('request.headers', true)::json
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.items (
    id bigint NOT NULL,
    name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: user_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_items (
    id bigint NOT NULL,
    user_id bigint,
    item_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: get_user_items; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.get_user_items AS
 SELECT i.id,
    i.name,
    i.created_at,
    i.updated_at
   FROM (public.items i
     JOIN public.user_items ui ON ((ui.item_id = i.id)))
  WHERE (ui.user_id = (public.get_header('x-user-id'::text))::bigint)
 OFFSET (current_setting('postgrest.offset'::text, true))::bigint
 LIMIT (current_setting('postgrest.limit'::text, true))::bigint;


--
-- Name: items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.items_id_seq OWNED BY public.items.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: user_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_items_id_seq OWNED BY public.user_items.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email text NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items ALTER COLUMN id SET DEFAULT nextval('public.items_id_seq'::regclass);


--
-- Name: user_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_items ALTER COLUMN id SET DEFAULT nextval('public.user_items_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: items items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: user_items user_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_items
    ADD CONSTRAINT user_items_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_items_name_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_items_name_uniq ON public.items USING btree (name);


--
-- Name: idx_user__email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX idx_user__email ON public.users USING btree (email);


--
-- Name: idx_user_items_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_items_item_id ON public.user_items USING btree (item_id);


--
-- Name: idx_user_items_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_items_user_id ON public.user_items USING btree (user_id);


--
-- Name: user_items user_items_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_items
    ADD CONSTRAINT user_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES public.items(id);


--
-- Name: user_items user_items_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_items
    ADD CONSTRAINT user_items_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20240403223719'),
    ('20240403223736'),
    ('20240403223810'),
    ('20240405225921'),
    ('20240405230011'),
    ('20240405230712'),
    ('20240406204157'),
    ('20240406204730');
