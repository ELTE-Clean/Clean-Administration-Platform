--
-- Removing default connect privileges
--

REVOKE CONNECT ON DATABASE template0 FROM PUBLIC;
REVOKE CONNECT ON DATABASE template1 FROM PUBLIC;
REVOKE CONNECT ON DATABASE postgres FROM PUBLIC;
REVOKE CONNECT ON DATABASE auth_db FROM PUBLIC;
REVOKE CONNECT ON DATABASE clean_db FROM PUBLIC;

--
-- Defining keycloaker role with access to everything in auth_db
--

\connect auth_db

CREATE ROLE keycloaker WITH LOGIN ENCRYPTED PASSWORD 'password1';
GRANT CONNECT ON DATABASE auth_db TO keycloaker;

-- Granting priviliges for existing objects

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO keycloaker;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO keycloaker;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO keycloaker;

-- Granting priviliges for future objects

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO keycloaker;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO keycloaker;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO keycloaker;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TYPES TO keycloaker;

--
-- Defining demonstrator role with access to everything in clean_db
--

\connect clean_db

CREATE ROLE demonstrator WITH LOGIN ENCRYPTED PASSWORD 'password2';
GRANT CONNECT ON DATABASE clean_db TO demonstrator;

-- Granting priviliges for existing objects

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO demonstrator;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO demonstrator;
GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public TO demonstrator;

-- Granting priviliges for future objects

ALTER DEFAULT PRIVILEGES FOR ROLE demonstrator IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO demonstrator;
ALTER DEFAULT PRIVILEGES FOR ROLE demonstrator IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO demonstrator;
ALTER DEFAULT PRIVILEGES FOR ROLE demonstrator IN SCHEMA public GRANT ALL PRIVILEGES ON FUNCTIONS TO demonstrator;
ALTER DEFAULT PRIVILEGES FOR ROLE demonstrator IN SCHEMA public GRANT ALL PRIVILEGES ON TYPES TO demonstrator;
