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
-- Name: userSeq; Type: Sequence; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.userSeq MINVALUE 1 START WITH 1 INCREMENT BY 1;

ALTER SEQUENCE public.userSeq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    userID      INT             DEFAULT nextval('userSeq'),
    neptun      CHAR(6)         NOT NULL UNIQUE,
    firstname   VARCHAR(20)     NOT NULL,
    lastname    VARCHAR(20)     NOT NULL,
    username    VARCHAR(20)     NOT NULL UNIQUE,
    PRIMARY KEY (userID)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: groupSeq; Type: Sequence; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.groupSeq MINVALUE 1 START WITH 1 INCREMENT BY 1;

ALTER SEQUENCE public.groupSeq OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    groupID     INt            DEFAULT nextval('groupSeq'),
    groupName   VARCHAR(10)    NOT NULL,
    timetable   VARCHAR(20)    UNIQUE,
    PRIMARY KEY (groupID)
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: sectionSeq; Type: Sequence; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sectionSeq MINVALUE 1 START WITH 1 INCREMENT BY 1;

ALTER SEQUENCE public.sectionSeq OWNER TO postgres;

--
-- Name: sections; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sections (
    sectionID   INT            DEFAULT nextval('sectionSeq'),
    sectionName VARCHAR(50)    NOT NULL,
    groupID     INT            REFERENCES  groups(groupID)  NOT NULL,
    PRIMARY KEY (sectionID)
);


ALTER TABLE public.sections OWNER TO postgres;

--
-- Name: taskSeq; Type: Sequence; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.taskSeq MINVALUE 1 START WITH 1 INCREMENT BY 1;

ALTER SEQUENCE public.taskSeq OWNER TO postgres;

--
-- Name: tasks; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tasks (
    taskID      INT            DEFAULT nextval('taskSeq'),
    taskName    VARCHAR(50)    NOT NULL,
    sectionID   INT            REFERENCES  sections(sectionID)  NOT NULL,
    groupID     INT            REFERENCES  groups(groupID)      NOT NULL,
    description VARCHAR(5000)  NULL, -- Task description (File/Text)
    solution    VARCHAR(5000)  NULL, -- Task solution to run the script on!
    max         INT            NULL,
    PRIMARY KEY (taskID)
);


ALTER TABLE public.tasks OWNER TO postgres;

--
-- Name: taskSeq; Type: Sequence; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gradeSeq MINVALUE 1 START WITH 1 INCREMENT BY 1;

ALTER SEQUENCE public.gradeSeq OWNER TO postgres;

--
-- Name: grades; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grades (
    gradeID     INT             DEFAULT nextval('gradeSeq'),
    userID      INT             REFERENCES  users(userID)           NOT NULL,
    taskID      INT             REFERENCES  tasks(taskID)           NOT NULL,
    sectionID   INT             REFERENCES  sections(sectionID)     NOT NULL,
    submission  VARCHAR(5000)   DEFAULT NULL, -- 5KB Storage of text. 
    grade       INT             DEFAULT NULL,
    PRIMARY KEY (gradeID)
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_to_group (
    neptun      VARCHAR(6)     REFERENCES users(neptun)    NOT NULL,
    groupID     INT            REFERENCES groups(groupID)  NOT NULL,
    PRIMARY KEY (neptun, groupID)
);


ALTER TABLE public.user_to_group OWNER TO postgres;


-- Filling the tables with dummy values

INSERT INTO users (neptun, firstname, lastname, username) VALUES ('81AMIA', 'Judita', 'Fenne', 'student-1');
INSERT INTO users (neptun, firstname, lastname, username) VALUES ('9YV5TX', 'Hannah', 'Lochana', 'HannaLocha');
INSERT INTO users (neptun, firstname, lastname, username) VALUES ('ZEADKD', 'Edan', 'Bahadur', 'demonstrator-1');
INSERT INTO users (neptun, firstname, lastname, username) VALUES ('Q50YI1', 'Dita', 'Bertók', 'Queen');
INSERT INTO users (neptun, firstname, lastname, username) VALUES ('B8WNS6', 'Georg','Vijay', 'Muscleman');
INSERT INTO users (neptun, firstname, lastname, username) VALUES ('NM82SK', 'Chaz', 'Saundra', 'Picasso');

INSERT INTO groups (groupName, timetable) VALUES ('Group_1', 'Mon, 12-14');
INSERT INTO groups (groupName, timetable) VALUES ('Group_2', 'Mon 14-16');
INSERT INTO groups (groupName, timetable) VALUES ('Group_3', 'Thu 8-10');
INSERT INTO groups (groupName, timetable) VALUES ('Group_4', 'Fri 12-14');

INSERT INTO sections (sectionName, groupID) VALUES ('Homework', 1);
INSERT INTO sections (sectionName, groupID) VALUES ('Progress Task', 1);
INSERT INTO sections (sectionName, groupID) VALUES ('Homework', 2);
INSERT INTO sections (sectionName, groupID) VALUES ('Midterm', 1);
INSERT INTO sections (sectionName, groupID) VALUES ('Endterm', 2);

INSERT INTO tasks (taskName, sectionID, groupID, description, solution, max) VALUES ('Homework 1', 1, 1, 'desc', 'sol', 1);
INSERT INTO tasks (taskName, sectionID, groupID, description, solution, max) VALUES ('Progress Task 1', 2, 1, 'desc', 'sol', 1);
INSERT INTO tasks (taskName, sectionID, groupID, description, solution, max) VALUES ('Homework 2', 3, 2, 'desc', 'sol', 2);
INSERT INTO tasks (taskName, sectionID, groupID, description, solution, max) VALUES ('Midterm', 4, 1, 'desc', 'sol', 3);
INSERT INTO tasks (taskName, sectionID, groupID, description, solution, max) VALUES ('Endterm', 5, 2, 'desc', 'sol', 4);
INSERT INTO tasks (taskName, sectionID, groupID) VALUES ('Homework 3', 3, 2);

INSERT INTO grades (userID, taskID, sectionID, submission, grade) VALUES (1, 1, 1, NULL, 5);
INSERT INTO grades (userID, taskID, sectionID, submission, grade) VALUES (2, 1, 3, NULL, 2);
INSERT INTO grades (userID, taskID, sectionID, submission, grade) VALUES (2, 4, 5, NULL, 3);
INSERT INTO grades (userID, taskID, sectionID, submission, grade) VALUES (3, 4, 5, NULL, 3);
INSERT INTO grades (userID, taskID, sectionID, submission, grade) VALUES (3, 5, 5, NULL, 4);

INSERT INTO user_to_group (neptun, groupID) VALUES ('81AMIA', 1);
INSERT INTO user_to_group (neptun, groupID) VALUES ('9YV5TX', 2);
INSERT INTO user_to_group (neptun, groupID) VALUES ('ZEADKD', 3);
INSERT INTO user_to_group (neptun, groupID) VALUES ('Q50YI1', 4);
INSERT INTO user_to_group (neptun, groupID) VALUES ('B8WNS6', 1);
INSERT INTO user_to_group (neptun, groupID) VALUES ('B8WNS6', 2);
INSERT INTO user_to_group (neptun, groupID) VALUES ('NM82SK', 3);
INSERT INTO user_to_group (neptun, groupID) VALUES ('NM82SK', 4);
