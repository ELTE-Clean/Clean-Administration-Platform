-- More info at https://cadu.dev/creating-a-docker-image-with-database-preloaded/

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.3

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
-- Name: clean_db; Type: DATABASE; Schema: -; Owner: postgres
--

-- Creating the CAP database
CREATE DATABASE clean_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';
ALTER DATABASE clean_db OWNER TO postgres;

\connect clean_db

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

SET default_with_oids = false;


\connect clean_db

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    id       CHAR(6)    NOT NULL,
    group_id INT        NOT NULL,
    PRIMARY KEY(id)
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections (
    id         CHAR(50)    NOT NULL,
    group_id   INT         NOT NULL,
    PRIMARY KEY (id, group_id)
);


ALTER TABLE public.sections OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    id      CHAR(50)    NOT NULL,
    section CHAR(50)    NOT NULL,
    max     INT         NOT NULL,
    PRIMARY KEY (id, section)
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    student_id  CHAR(6)     REFERENCES  students(id) NOT NULL,
    task_id     CHAR(50)    NOT NULL,
    grade       INT         NOT NULL,
    PRIMARY KEY (student_id, task_id)
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teachers (
    id          CHAR(6)     REFERENCES students(id) NOT NULL,
    group_id    INT         NOT NULL,
    PRIMARY KEY (id, group_id)
);


ALTER TABLE public.teachers OWNER TO postgres;


-- Filling the tables with dummy values

INSERT INTO students VALUES ('81AMIA', 1);
INSERT INTO students VALUES ('9YV5TX', 1);
INSERT INTO students VALUES ('ZEADKD', 2);
INSERT INTO students VALUES ('B8WNS6', 3);
INSERT INTO students VALUES ('NM82SK', 4);

INSERT INTO sections VALUES ('Homework', 1);
INSERT INTO sections VALUES ('Progress Task', 1);
INSERT INTO sections VALUES ('Homework', 2);
INSERT INTO sections VALUES ('Midterm', 3);
INSERT INTO sections VALUES ('Endterm', 4);

INSERT INTO tasks VALUES ('Homework 1', 'Homework', 1);
INSERT INTO tasks VALUES ('Progress Task 1', 'Progress Task', 1);
INSERT INTO tasks VALUES ('Homework 2', 'Homework', 2);
INSERT INTO tasks VALUES ('Midterm', 'Midterm', 3);
INSERT INTO tasks VALUES ('Endterm', 'Endterm', 4);

INSERT INTO grades VALUES ('81AMIA', 'Homework 1', 5);
INSERT INTO grades VALUES ('9YV5TX', 'Homework 1', 2);
INSERT INTO grades VALUES ('9YV5TX', 'Midterm', 3);
INSERT INTO grades VALUES ('ZEADKD', 'Midterm', 3);
INSERT INTO grades VALUES ('ZEADKD', 'Endterm', 4);

INSERT INTO teachers VALUES ('B8WNS6', 1);
INSERT INTO teachers VALUES ('B8WNS6', 2);
INSERT INTO teachers VALUES ('NM82SK', 3);
INSERT INTO teachers VALUES ('NM82SK', 4);
