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

CREATE TABLE public.users (
    userid      CHAR(6)         NOT NULL,
    firstname   VARCHAR(20)     NOT NULL,
    lastname    VARCHAR(20)     NOT NULL,
    username    VARCHAR(20)     NOT NULL UNIQUE,
    PRIMARY KEY(userid)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    groupid     VARCHAR(10)    NOT NULL,
    timetable   VARCHAR(20)    UNIQUE,
    PRIMARY KEY(groupid)
);


ALTER TABLE public.groups OWNER TO postgres;
--
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections (
    sectionid  VARCHAR(50)    NOT NULL,
    groupid    VARCHAR(10)    REFERENCES  groups(groupid)  NOT NULL,
    PRIMARY KEY (sectionid, groupid)
);


ALTER TABLE public.sections OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    taskid      VARCHAR(50)    NOT NULL,
    sectionid   VARCHAR(50)    NOT NULL,
    groupid     VARCHAR(10)    NOT NULL,
    max         INT            NOT NULL,
    FOREIGN KEY (sectionid, groupid) REFERENCES sections(sectionid, groupid),
    PRIMARY KEY (taskid, sectionid, groupid)
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    studentid   CHAR(6)         REFERENCES  users(userid)   NOT NULL,
    taskid      VARCHAR(50)     NOT NULL,
    sectionid   VARCHAR(50)     NOT NULL,
    submission  VARCHAR(5000)   DEFAULT NULL, -- 5KB Storage of text. 
    grade       INT             DEFAULT NULL,
    -- groupid     CHAR(10)    NOT NULL,                                                # Omitted because having groupid would be redundant
    -- FOREIGN KEY (taskid, sectionid) REFERENCES tasks(taskid, sectionid, groupid),    # Does not work without groupid
    PRIMARY KEY (studentid, taskid, sectionid)
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_to_group (
    userid      CHAR(6)         REFERENCES users(userid)    NOT NULL,
    groupid     VARCHAR(10)     REFERENCES groups(groupid)  NOT NULL,
    PRIMARY KEY (userid, groupid)
);


ALTER TABLE public.user_to_group OWNER TO postgres;


-- Filling the tables with dummy values

INSERT INTO users VALUES ('81AMIA', 'Judita', 'Fenne', 'student-1');
INSERT INTO users VALUES ('9YV5TX', 'Hannah', 'Lochana', 'HannaLocha');
INSERT INTO users VALUES ('ZEADKD', 'Edan', 'Bahadur', 'demonstrator-1');
INSERT INTO users VALUES ('Q50YI1', 'Dita', 'Bertók', 'Queen');
INSERT INTO users VALUES ('B8WNS6', 'Georg','Vijay', 'Muscleman');
INSERT INTO users VALUES ('NM82SK', 'Chaz', 'Saundra', 'Picasso');

INSERT INTO groups VALUES ('Group_1', 'Mon, 12-14');
INSERT INTO groups VALUES ('Group_2', 'Mon 14-16');
INSERT INTO groups VALUES ('Group_3', 'Thu 8-10');
INSERT INTO groups VALUES ('Group_4', 'Fri 12-14');

INSERT INTO sections VALUES ('Homework', 'Group_1');
INSERT INTO sections VALUES ('Progress Task', 'Group_1');
INSERT INTO sections VALUES ('Homework', 'Group_2');
INSERT INTO sections VALUES ('Midterm', 'Group_1');
INSERT INTO sections VALUES ('Endterm', 'Group_2');

INSERT INTO tasks VALUES ('Homework 1', 'Homework', 'Group_1', 1);
INSERT INTO tasks VALUES ('Progress Task 1', 'Progress Task', 'Group_1', 1);
INSERT INTO tasks VALUES ('Homework 2', 'Homework', 'Group_2', 2);
INSERT INTO tasks VALUES ('Midterm', 'Midterm', 'Group_1', 3);
INSERT INTO tasks VALUES ('Endterm', 'Endterm', 'Group_2', 4);

INSERT INTO grades VALUES ('81AMIA', 'Homework 1', 'Homework', NULL, 5);
INSERT INTO grades VALUES ('9YV5TX', 'Homework 1', 'Homework', NULL, 2);
INSERT INTO grades VALUES ('9YV5TX', 'Midterm', 'Exam', NULL, 3);
INSERT INTO grades VALUES ('ZEADKD', 'Midterm', 'Exam', NULL, 3);
INSERT INTO grades VALUES ('ZEADKD', 'Endterm', 'Exam', NULL, 4);

INSERT INTO user_to_group VALUES ('81AMIA', 'Group_1');
INSERT INTO user_to_group VALUES ('9YV5TX', 'Group_2');
INSERT INTO user_to_group VALUES ('ZEADKD', 'Group_3');
INSERT INTO user_to_group VALUES ('Q50YI1', 'Group_4');
INSERT INTO user_to_group VALUES ('B8WNS6', 'Group_1');
INSERT INTO user_to_group VALUES ('B8WNS6', 'Group_2');
INSERT INTO user_to_group VALUES ('NM82SK', 'Group_3');
INSERT INTO user_to_group VALUES ('NM82SK', 'Group_4');
