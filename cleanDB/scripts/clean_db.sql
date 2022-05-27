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
    taskID          INT            DEFAULT nextval('taskSeq'),
    taskName        VARCHAR(50)    NOT NULL,
    sectionID       INT            REFERENCES  sections(sectionID)  NOT NULL,
    -- groupID         INT            REFERENCES  groups(groupID)      NOT NULL,
    description     VARCHAR(5000)  NOT NULL, -- Task description (File/Text)
    solution        VARCHAR(5000)  NOT NULL, -- Task solution to run the script on!
    testQuestions   VARCHAR(1000), -- Test cases for the configuration
    max             INT            NOT NULL,
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
    submission  VARCHAR(5000)   DEFAULT NULL, -- 5KB Storage of text. 
    grade       INT             DEFAULT NULL,
    PRIMARY KEY (gradeID)
);


ALTER TABLE public.grades OWNER TO postgres;

--
-- Name: teachers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_to_group (
    userID      INT             REFERENCES users(userID)    NOT NULL,
    groupID     INT             REFERENCES groups(groupID)  NOT NULL,
    PRIMARY KEY (userID, groupID)
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
INSERT INTO sections (sectionName, groupID) VALUES ('Midterm', 4);
INSERT INTO sections (sectionName, groupID) VALUES ('Endterm', 2);


INSERT INTO user_to_group (userID, groupID) VALUES (1, 1);
INSERT INTO user_to_group (userID, groupID) VALUES (2, 2);
INSERT INTO user_to_group (userID, groupID) VALUES (3, 3);
INSERT INTO user_to_group (userID, groupID) VALUES (4, 4);
INSERT INTO user_to_group (userID, groupID) VALUES (5, 1);
INSERT INTO user_to_group (userID, groupID) VALUES (5, 2);
INSERT INTO user_to_group (userID, groupID) VALUES (6, 3);
INSERT INTO user_to_group (userID, groupID) VALUES (6, 4);




---------------------- Teacher tasks and files Dumb data
INSERT INTO tasks (taskName, sectionID, description, solution, testQuestions,  max) VALUES ('Homework 1', 1, 'desc', 'module teacher
import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b
', 
'
test_questions:
\t- q1:
\t\t\tfunction_name: addInt
\t\t\ttest_cases:
\t\t\t\t- 1 2
\t\t\t\t- 5 13
\t\t\t\t- 12 99
\t- q2:
\t\t\tfunction_name: subInt
\t\t\ttest_cases:
\t\t\t\t- 3 4
\t\t\t\t- 3 2
\t\t\t\t- 23 32
'
, 1);
INSERT INTO tasks (taskName, sectionID, description, solution, max) VALUES ('Progress Task 1', 2, 'desc', 'module teacher
import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b
', 1);
INSERT INTO tasks (taskName, sectionID, description, solution, max) VALUES ('Homework 2', 3, 'desc', 'module teacher
import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b
', 2);
INSERT INTO tasks (taskName, sectionID, description, solution,testQuestions, max) VALUES ('Midterm', 4, 'desc', 'module teacher
import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b
', 
'
test_questions:
\t- q1:
\t\t\tfunction_name: addInt
\t\t\ttest_cases:
\t\t\t\t- 1 2
\t\t\t\t- 5 13
\t\t\t\t- 12 99
\t- q2:
\t\t\tfunction_name: subInt
\t\t\ttest_cases:
\t\t\t\t- 3 4
\t\t\t\t- 3 2
\t\t\t\t- 23 32
'
, 3);
INSERT INTO tasks (taskName, sectionID, description, solution, max) VALUES ('Endterm', 5, 'desc', 'module teacher
import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b
', 4);

---------------------- Students files Dumb data
INSERT INTO grades (userID, taskID, submission, grade) VALUES (1, 1, 'import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b', 5);
INSERT INTO grades (userID, taskID, submission, grade) VALUES (2, 1, 'import StdEnv 
addInt :: Int Int -> Int
addInt a b = a + b
subInt :: Int Int -> Int
subInt a b = a - b', 2);

-- INSERT INTO grades (userID, taskID, submission, grade) VALUES (6, 4, NULL, 3);
-- INSERT INTO grades (userID, taskID, submission, grade) VALUES (3, 5, NULL, 4);