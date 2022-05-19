--
-- PostgreSQL database dump
--

-- Dumped from database version 11.14
-- Dumped by pg_dump version 11.14

-- Started on 2022-04-09 22:29:55 UTC

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

DROP DATABASE IF EXISTS auth_db;
--
-- TOC entry 3904 (class 1262 OID 16384)
-- Name: auth_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE auth_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE auth_db OWNER TO postgres;

\connect auth_db

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

--
-- TOC entry 196 (class 1259 OID 16385)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16391)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16394)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16398)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16407)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16410)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16416)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16422)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16441)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16447)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16450)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16453)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16456)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16462)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16468)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16475)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16478)
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16484)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16487)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16493)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16496)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16499)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16505)
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16511)
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16517)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16520)
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16526)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16532)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16535)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16539)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16545)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16551)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16557)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16560)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16566)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16569)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16576)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16579)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16585)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16591)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16598)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16601)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16613)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16619)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16625)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16631)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16634)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16641)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16645)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16653)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16660)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16666)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16672)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16678)
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16712)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16718)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16721)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16724)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16727)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16733)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- TOC entry 256 (class 1259 OID 16741)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 16747)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 16750)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 16753)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 16759)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 16767)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 16774)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 16777)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 16780)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 16785)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 16791)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 16797)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 16804)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 16810)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 16813)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 16819)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 16822)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 16825)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 16832)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 16838)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 16841)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 16850)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 16856)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 16862)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 16868)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 16874)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 16877)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 16881)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 16884)
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 16891)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 16897)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 16903)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- TOC entry 3807 (class 0 OID 16385)
-- Dependencies: 196
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3808 (class 0 OID 16391)
-- Dependencies: 197
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3809 (class 0 OID 16394)
-- Dependencies: 198
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('233af217-bd0e-47fc-bec1-7b31e275a4f5', NULL, 'auth-cookie', 'master', '7a4dc86d-5716-4f62-9dca-8f350ec173be', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('33cb937e-6ee3-4180-a2fe-d5b0ae6df17b', NULL, 'auth-spnego', 'master', '7a4dc86d-5716-4f62-9dca-8f350ec173be', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4a4ce176-90a0-4264-b3eb-3d2970b80aa3', NULL, 'identity-provider-redirector', 'master', '7a4dc86d-5716-4f62-9dca-8f350ec173be', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0feea276-913d-4acb-8e89-1e59c1e2ee7f', NULL, NULL, 'master', '7a4dc86d-5716-4f62-9dca-8f350ec173be', 2, 30, true, '5de0483c-1139-4f75-a74b-6cb0cfb809c1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f9fc38a8-258f-4d1d-b624-7f6b14dc35cd', NULL, 'auth-username-password-form', 'master', '5de0483c-1139-4f75-a74b-6cb0cfb809c1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cfbd5040-af4c-410b-85f2-115a8c95e730', NULL, NULL, 'master', '5de0483c-1139-4f75-a74b-6cb0cfb809c1', 1, 20, true, 'f05b0472-e870-4f21-8227-0879867d2506', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('91961767-2734-4aa2-8ec0-c6b541e3ec43', NULL, 'conditional-user-configured', 'master', 'f05b0472-e870-4f21-8227-0879867d2506', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e813c291-6405-4262-88f5-acf456a4df56', NULL, 'auth-otp-form', 'master', 'f05b0472-e870-4f21-8227-0879867d2506', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9643aa77-5aad-42b6-a104-c256b2e76c80', NULL, 'direct-grant-validate-username', 'master', '9bb197e1-f04c-4f50-9b95-7c2d79b569cc', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('516126b9-3e97-4e55-9e0e-a7de930b38bd', NULL, 'direct-grant-validate-password', 'master', '9bb197e1-f04c-4f50-9b95-7c2d79b569cc', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e4b071f3-e0b7-4da9-9b4c-f7ba1c09d7ca', NULL, NULL, 'master', '9bb197e1-f04c-4f50-9b95-7c2d79b569cc', 1, 30, true, '3e595af1-f6a1-4f1d-9dcb-e08a53afc0a1', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1c27fc0a-e947-46dc-9c41-74a655d7bc5d', NULL, 'conditional-user-configured', 'master', '3e595af1-f6a1-4f1d-9dcb-e08a53afc0a1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('54977693-04b4-4d21-a413-a356e25b1b52', NULL, 'direct-grant-validate-otp', 'master', '3e595af1-f6a1-4f1d-9dcb-e08a53afc0a1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c73e198b-45e3-43cc-a7e5-66fde1e91da3', NULL, 'registration-page-form', 'master', '7706c58f-2cad-4239-ab0a-785249f186a9', 0, 10, true, '51150c50-61f4-44ea-9564-5181f1839e94', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('25bd8d54-2d35-4e43-bb21-9ff5c3e7e4b7', NULL, 'registration-user-creation', 'master', '51150c50-61f4-44ea-9564-5181f1839e94', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('45835b53-b924-4711-958c-4ab79fdf0084', NULL, 'registration-profile-action', 'master', '51150c50-61f4-44ea-9564-5181f1839e94', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('255e1138-b248-4e8f-8de3-710f4a6cce84', NULL, 'registration-password-action', 'master', '51150c50-61f4-44ea-9564-5181f1839e94', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b1977ef3-90b9-4d73-a056-5a0ce081b68d', NULL, 'registration-recaptcha-action', 'master', '51150c50-61f4-44ea-9564-5181f1839e94', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('00d64840-d53d-41bb-a2ba-82db09c84d65', NULL, 'reset-credentials-choose-user', 'master', 'c8a0c540-a464-4fe2-aa64-d22bbad93855', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6ce9c1c9-1a03-4400-b6d1-c04eed06c8af', NULL, 'reset-credential-email', 'master', 'c8a0c540-a464-4fe2-aa64-d22bbad93855', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('88ca112e-2e06-48e2-ae1f-1764d2727d1f', NULL, 'reset-password', 'master', 'c8a0c540-a464-4fe2-aa64-d22bbad93855', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0d4425b5-9fe4-40e7-bfb1-802c145f87c3', NULL, NULL, 'master', 'c8a0c540-a464-4fe2-aa64-d22bbad93855', 1, 40, true, 'b7391aa7-cc25-4061-81ad-7c9bcd8047df', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7d231711-c746-4cc2-90d2-7b8348a8bedf', NULL, 'conditional-user-configured', 'master', 'b7391aa7-cc25-4061-81ad-7c9bcd8047df', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6dc7db84-83c5-4a78-bd81-8e73962c3383', NULL, 'reset-otp', 'master', 'b7391aa7-cc25-4061-81ad-7c9bcd8047df', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('07cf9775-03bc-41eb-aaef-4ea15a44f290', NULL, 'client-secret', 'master', 'e93d0486-0f85-466f-b7ec-20ef85b997bc', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e3022ec3-2cd5-440b-9ace-3f8e6b0a28c8', NULL, 'client-jwt', 'master', 'e93d0486-0f85-466f-b7ec-20ef85b997bc', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3dda4c35-b944-42ce-8bda-150c690aff8c', NULL, 'client-secret-jwt', 'master', 'e93d0486-0f85-466f-b7ec-20ef85b997bc', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0491c89b-43cd-4a81-90be-645c41191b05', NULL, 'client-x509', 'master', 'e93d0486-0f85-466f-b7ec-20ef85b997bc', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('fb520cb2-e877-4841-812a-0003d50c60e2', NULL, 'idp-review-profile', 'master', '29e0e6e8-2f35-4f53-9e56-c2b587a0fb6e', 0, 10, false, NULL, '44d75399-f44d-4695-b57f-b6aa4a270220');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7a727de1-f3ba-4c61-aa19-7d76abcbd4fc', NULL, NULL, 'master', '29e0e6e8-2f35-4f53-9e56-c2b587a0fb6e', 0, 20, true, '753a2ab6-5776-47a5-a545-6c43acd8a723', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a3605c21-c81b-4c43-905f-06786d8f50db', NULL, 'idp-create-user-if-unique', 'master', '753a2ab6-5776-47a5-a545-6c43acd8a723', 2, 10, false, NULL, '33f8618e-713c-46a4-b2ac-0eff00a13bfa');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b051c7be-fb1e-411c-b120-4f6a5e983af7', NULL, NULL, 'master', '753a2ab6-5776-47a5-a545-6c43acd8a723', 2, 20, true, 'fbc06ce6-833d-4bc2-9248-563a8f4171ed', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8308c643-4e66-4913-ab8b-bb5650c6ad86', NULL, 'idp-confirm-link', 'master', 'fbc06ce6-833d-4bc2-9248-563a8f4171ed', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9b3210cc-8f86-4b9b-9a5e-fab2a47ed428', NULL, NULL, 'master', 'fbc06ce6-833d-4bc2-9248-563a8f4171ed', 0, 20, true, '1c852b00-12de-4c1a-8ef0-ab052252266d', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('b1a8c773-be75-4bca-aeb5-06729f081269', NULL, 'idp-email-verification', 'master', '1c852b00-12de-4c1a-8ef0-ab052252266d', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('62de95a7-4eca-46db-b077-b57eb48680db', NULL, NULL, 'master', '1c852b00-12de-4c1a-8ef0-ab052252266d', 2, 20, true, '3f399da2-d9f4-4326-b453-04a9b2ffe723', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cb1aad9f-e4bf-46b1-9063-679e68113ba5', NULL, 'idp-username-password-form', 'master', '3f399da2-d9f4-4326-b453-04a9b2ffe723', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d72b7cd0-3515-4f5d-acac-893c0ab4a8db', NULL, NULL, 'master', '3f399da2-d9f4-4326-b453-04a9b2ffe723', 1, 20, true, 'f5a1f08f-866a-4986-80f3-23d50f1f82fd', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9608b0cd-b565-466f-a3d7-cbdff8038467', NULL, 'conditional-user-configured', 'master', 'f5a1f08f-866a-4986-80f3-23d50f1f82fd', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e55d0785-3c14-4a97-bf96-5742e30db7c9', NULL, 'auth-otp-form', 'master', 'f5a1f08f-866a-4986-80f3-23d50f1f82fd', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('cee63120-80b4-46b3-9bee-eca7ad12c768', NULL, 'http-basic-authenticator', 'master', 'e7123130-9a60-4670-9cc4-e46e92ef3032', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2a1fae20-d062-4659-b182-c3ebf0db6284', NULL, 'docker-http-basic-authenticator', 'master', '52a66e94-bf7a-406c-bee0-01061d9c6cb5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('99b7428b-0a20-4ded-8cd9-0d24d6ced386', NULL, 'no-cookie-redirect', 'master', 'd3b8a064-e6dc-4db4-ae1f-2e14d4998b72', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e7956294-d3bb-4d27-b87b-1872517a03c5', NULL, NULL, 'master', 'd3b8a064-e6dc-4db4-ae1f-2e14d4998b72', 0, 20, true, '5675952a-f771-4b0e-ae60-0919bc41f13f', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ff536e17-e11a-4f7a-b2ce-0474af1b0e95', NULL, 'basic-auth', 'master', '5675952a-f771-4b0e-ae60-0919bc41f13f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('57af7a94-1bfb-40c5-bfe0-dda4e1563cb4', NULL, 'basic-auth-otp', 'master', '5675952a-f771-4b0e-ae60-0919bc41f13f', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('1194ceb1-cd2e-449b-b941-9571828ddf53', NULL, 'auth-spnego', 'master', '5675952a-f771-4b0e-ae60-0919bc41f13f', 3, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8bf47930-8269-4328-979c-cb257acd3f72', NULL, 'auth-cookie', 'CAP', '5b0b55da-8477-41c4-a819-9dfebdc034cc', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2fa04f32-e34e-41f9-99d6-c7fef3902274', NULL, 'auth-spnego', 'CAP', '5b0b55da-8477-41c4-a819-9dfebdc034cc', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('dc71177c-ec3c-4642-b353-84a8e39e1f50', NULL, 'identity-provider-redirector', 'CAP', '5b0b55da-8477-41c4-a819-9dfebdc034cc', 2, 25, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4a653265-fe18-4e13-a2dc-718283526af6', NULL, NULL, 'CAP', '5b0b55da-8477-41c4-a819-9dfebdc034cc', 2, 30, true, '9f4fba88-9500-4c95-a0ce-41221521c1a7', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d4f482ae-96a4-4118-a1a5-62905220767b', NULL, 'auth-username-password-form', 'CAP', '9f4fba88-9500-4c95-a0ce-41221521c1a7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4a583657-9280-414e-b007-49f7867a4a96', NULL, NULL, 'CAP', '9f4fba88-9500-4c95-a0ce-41221521c1a7', 1, 20, true, 'c5af64e8-78da-412e-b673-33560ac19d29', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('7995a45d-5694-48ff-b727-6318114b1fcb', NULL, 'conditional-user-configured', 'CAP', 'c5af64e8-78da-412e-b673-33560ac19d29', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f30443eb-1608-4715-b792-1ddaf71ccbe5', NULL, 'auth-otp-form', 'CAP', 'c5af64e8-78da-412e-b673-33560ac19d29', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('4f045a16-8649-4947-9ad6-1c2f42be6789', NULL, 'direct-grant-validate-username', 'CAP', 'd75139f6-a0ad-425a-af07-8324f27557e7', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3155c564-712a-4ddb-8cd7-7b08a58783e7', NULL, 'direct-grant-validate-password', 'CAP', 'd75139f6-a0ad-425a-af07-8324f27557e7', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('bc3ac494-4ab8-4227-9dd1-aaf15dd3b44a', NULL, NULL, 'CAP', 'd75139f6-a0ad-425a-af07-8324f27557e7', 1, 30, true, 'b6122dcb-ee52-4e8b-bcb3-f9079c4eb15b', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('96876ded-050a-45b8-9d78-43ee95733e9b', NULL, 'conditional-user-configured', 'CAP', 'b6122dcb-ee52-4e8b-bcb3-f9079c4eb15b', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('9c63c97f-8326-47ba-bad7-4e416a5c7e7a', NULL, 'direct-grant-validate-otp', 'CAP', 'b6122dcb-ee52-4e8b-bcb3-f9079c4eb15b', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('5ea23d63-a332-4c63-a2e3-9e0e531f1906', NULL, 'registration-page-form', 'CAP', '0da7e7bf-9f0e-46be-9196-0953a88382c1', 0, 10, true, 'a1fad2ae-035a-4010-a95d-1d2c1cfb7e54', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f6329265-4234-4222-94cd-61cbb880c235', NULL, 'registration-user-creation', 'CAP', 'a1fad2ae-035a-4010-a95d-1d2c1cfb7e54', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('2e3ffae0-0fa6-4fd4-909c-670d91cd2d15', NULL, 'registration-profile-action', 'CAP', 'a1fad2ae-035a-4010-a95d-1d2c1cfb7e54', 0, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('e62b5fa7-d579-47bd-931d-8be0ba8888da', NULL, 'registration-password-action', 'CAP', 'a1fad2ae-035a-4010-a95d-1d2c1cfb7e54', 0, 50, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('662dd32a-85ab-4fa6-a9db-6e1afd888a15', NULL, 'registration-recaptcha-action', 'CAP', 'a1fad2ae-035a-4010-a95d-1d2c1cfb7e54', 3, 60, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('49a0f4fd-0dea-445d-bde3-b752356dec33', NULL, 'reset-credentials-choose-user', 'CAP', '1a4dfbb9-bc1b-4e55-b5bf-c69aad806bc1', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c434d049-95b2-4818-92f3-5165fc38887f', NULL, 'reset-credential-email', 'CAP', '1a4dfbb9-bc1b-4e55-b5bf-c69aad806bc1', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('546574a7-614b-4c90-824a-16c7aa1082f7', NULL, 'reset-password', 'CAP', '1a4dfbb9-bc1b-4e55-b5bf-c69aad806bc1', 0, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('d59d3e7a-8d7f-41c8-98cf-ac76b73f0c5a', NULL, NULL, 'CAP', '1a4dfbb9-bc1b-4e55-b5bf-c69aad806bc1', 1, 40, true, 'e2787a4c-d0b4-42e0-9c46-ec4e926a4dbb', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('398818b7-fed8-418c-a8a4-6add294c2292', NULL, 'conditional-user-configured', 'CAP', 'e2787a4c-d0b4-42e0-9c46-ec4e926a4dbb', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('0ced8b26-aff2-4065-93da-30ebb958607a', NULL, 'reset-otp', 'CAP', 'e2787a4c-d0b4-42e0-9c46-ec4e926a4dbb', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('8e95ab98-61e1-45e7-97bb-a73e1c42f70f', NULL, 'client-secret', 'CAP', '0fc25843-3a94-474a-b92e-5f6b9ff9ca7d', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('a7821037-5de6-4227-a6a8-efc5ca675b1a', NULL, 'client-jwt', 'CAP', '0fc25843-3a94-474a-b92e-5f6b9ff9ca7d', 2, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('93ecc98b-f41d-40ef-a203-b03e1af2a995', NULL, 'client-secret-jwt', 'CAP', '0fc25843-3a94-474a-b92e-5f6b9ff9ca7d', 2, 30, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6f2b9b41-ee1b-4290-8265-e639513ae2e7', NULL, 'client-x509', 'CAP', '0fc25843-3a94-474a-b92e-5f6b9ff9ca7d', 2, 40, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('67d1bba1-5217-43f9-99d4-9192e908a522', NULL, 'idp-review-profile', 'CAP', '358b4564-0040-496f-bf75-a60e75a048ba', 0, 10, false, NULL, '8df9b83b-843a-48cc-8539-567bf8a5a7c4');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('09d63bc5-fa28-47f5-a1a3-6acca9e9f349', NULL, NULL, 'CAP', '358b4564-0040-496f-bf75-a60e75a048ba', 0, 20, true, 'f7814971-0f06-409b-9957-45f9cb5d85b4', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('badfa016-f4b1-403f-84b2-f69d247c78dd', NULL, 'idp-create-user-if-unique', 'CAP', 'f7814971-0f06-409b-9957-45f9cb5d85b4', 2, 10, false, NULL, '5a8b08d3-e037-48d3-a525-2a191924e7fb');
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('332d7124-e39e-4403-995b-db244e35c9bb', NULL, NULL, 'CAP', 'f7814971-0f06-409b-9957-45f9cb5d85b4', 2, 20, true, '45f539d5-5251-44c0-8ea3-9869636a3183', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('3dd264f9-1b1b-4322-92cb-bb1f1f4596b9', NULL, 'idp-confirm-link', 'CAP', '45f539d5-5251-44c0-8ea3-9869636a3183', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('bafbb002-74c9-4da7-a05d-2894341dddb9', NULL, NULL, 'CAP', '45f539d5-5251-44c0-8ea3-9869636a3183', 0, 20, true, '938b3725-822f-4501-b6dc-dccbda30959f', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c9e6c75d-4fe6-463d-bf41-b93a9e6d10c9', NULL, 'idp-email-verification', 'CAP', '938b3725-822f-4501-b6dc-dccbda30959f', 2, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('ebf55aa2-d514-4906-8302-89e49b4d85d9', NULL, NULL, 'CAP', '938b3725-822f-4501-b6dc-dccbda30959f', 2, 20, true, '85938271-09dc-4325-9e28-2e50f3cba874', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('59e9278d-ae28-487a-b603-49d61124490c', NULL, 'idp-username-password-form', 'CAP', '85938271-09dc-4325-9e28-2e50f3cba874', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('45ac3b49-2e9a-419a-9620-7f11537922a1', NULL, NULL, 'CAP', '85938271-09dc-4325-9e28-2e50f3cba874', 1, 20, true, '490fd0db-89e5-4cfa-b0ee-587632152ac5', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f412e335-89d6-49b7-89d8-9a2e78e13ef5', NULL, 'conditional-user-configured', 'CAP', '490fd0db-89e5-4cfa-b0ee-587632152ac5', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f3eabe80-b06d-4e0d-9c32-c87469c7af74', NULL, 'auth-otp-form', 'CAP', '490fd0db-89e5-4cfa-b0ee-587632152ac5', 0, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6e31b58d-132b-42a8-8a7e-90ada541ecca', NULL, 'http-basic-authenticator', 'CAP', '34a16bdb-c423-4b72-b249-2542c4cf55d0', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('6424669e-af04-4413-b7ed-3057cb5f550e', NULL, 'docker-http-basic-authenticator', 'CAP', 'beb742d5-44b0-413d-8ad8-81005a3ff0b4', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('c6459693-dea2-46a1-b527-4a5c52f1f51f', NULL, 'no-cookie-redirect', 'CAP', '0de39cf1-cc59-46d4-87f7-3fe1021bfa20', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('de7a9e72-67f2-4698-bdd8-9096f035a95f', NULL, NULL, 'CAP', '0de39cf1-cc59-46d4-87f7-3fe1021bfa20', 0, 20, true, 'abbb0a1e-ea02-485b-953a-c7916c4f103f', NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('497fc136-e31f-401f-8323-1ea1bad2701a', NULL, 'basic-auth', 'CAP', 'abbb0a1e-ea02-485b-953a-c7916c4f103f', 0, 10, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('f34eb841-b08e-4bad-b311-6ed878312a7c', NULL, 'basic-auth-otp', 'CAP', 'abbb0a1e-ea02-485b-953a-c7916c4f103f', 3, 20, false, NULL, NULL);
INSERT INTO public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) VALUES ('16ed2730-56f0-4a7d-be88-51d5e9d8569a', NULL, 'auth-spnego', 'CAP', 'abbb0a1e-ea02-485b-953a-c7916c4f103f', 3, 30, false, NULL, NULL);


--
-- TOC entry 3810 (class 0 OID 16398)
-- Dependencies: 199
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('7a4dc86d-5716-4f62-9dca-8f350ec173be', 'browser', 'browser based authentication', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5de0483c-1139-4f75-a74b-6cb0cfb809c1', 'forms', 'Username, password, otp and other auth forms.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f05b0472-e870-4f21-8227-0879867d2506', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9bb197e1-f04c-4f50-9b95-7c2d79b569cc', 'direct grant', 'OpenID Connect Resource Owner Grant', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('3e595af1-f6a1-4f1d-9dcb-e08a53afc0a1', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('7706c58f-2cad-4239-ab0a-785249f186a9', 'registration', 'registration flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('51150c50-61f4-44ea-9564-5181f1839e94', 'registration form', 'registration form', 'master', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c8a0c540-a464-4fe2-aa64-d22bbad93855', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('b7391aa7-cc25-4061-81ad-7c9bcd8047df', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e93d0486-0f85-466f-b7ec-20ef85b997bc', 'clients', 'Base authentication for clients', 'master', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('29e0e6e8-2f35-4f53-9e56-c2b587a0fb6e', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('753a2ab6-5776-47a5-a545-6c43acd8a723', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('fbc06ce6-833d-4bc2-9248-563a8f4171ed', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('1c852b00-12de-4c1a-8ef0-ab052252266d', 'Account verification options', 'Method with which to verity the existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('3f399da2-d9f4-4326-b453-04a9b2ffe723', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f5a1f08f-866a-4986-80f3-23d50f1f82fd', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e7123130-9a60-4670-9cc4-e46e92ef3032', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('52a66e94-bf7a-406c-bee0-01061d9c6cb5', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d3b8a064-e6dc-4db4-ae1f-2e14d4998b72', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'master', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5675952a-f771-4b0e-ae60-0919bc41f13f', 'Authentication Options', 'Authentication options.', 'master', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('5b0b55da-8477-41c4-a819-9dfebdc034cc', 'browser', 'browser based authentication', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('9f4fba88-9500-4c95-a0ce-41221521c1a7', 'forms', 'Username, password, otp and other auth forms.', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('c5af64e8-78da-412e-b673-33560ac19d29', 'Browser - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('d75139f6-a0ad-425a-af07-8324f27557e7', 'direct grant', 'OpenID Connect Resource Owner Grant', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('b6122dcb-ee52-4e8b-bcb3-f9079c4eb15b', 'Direct Grant - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0da7e7bf-9f0e-46be-9196-0953a88382c1', 'registration', 'registration flow', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('a1fad2ae-035a-4010-a95d-1d2c1cfb7e54', 'registration form', 'registration form', 'CAP', 'form-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('1a4dfbb9-bc1b-4e55-b5bf-c69aad806bc1', 'reset credentials', 'Reset credentials for a user if they forgot their password or something', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('e2787a4c-d0b4-42e0-9c46-ec4e926a4dbb', 'Reset - Conditional OTP', 'Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0fc25843-3a94-474a-b92e-5f6b9ff9ca7d', 'clients', 'Base authentication for clients', 'CAP', 'client-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('358b4564-0040-496f-bf75-a60e75a048ba', 'first broker login', 'Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('f7814971-0f06-409b-9957-45f9cb5d85b4', 'User creation or linking', 'Flow for the existing/non-existing user alternatives', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('45f539d5-5251-44c0-8ea3-9869636a3183', 'Handle Existing Account', 'Handle what to do if there is existing account with same email/username like authenticated identity provider', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('938b3725-822f-4501-b6dc-dccbda30959f', 'Account verification options', 'Method with which to verity the existing account', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('85938271-09dc-4325-9e28-2e50f3cba874', 'Verify Existing Account by Re-authentication', 'Reauthentication of existing account', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('490fd0db-89e5-4cfa-b0ee-587632152ac5', 'First broker login - Conditional OTP', 'Flow to determine if the OTP is required for the authentication', 'CAP', 'basic-flow', false, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('34a16bdb-c423-4b72-b249-2542c4cf55d0', 'saml ecp', 'SAML ECP Profile Authentication Flow', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('beb742d5-44b0-413d-8ad8-81005a3ff0b4', 'docker auth', 'Used by Docker clients to authenticate against the IDP', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('0de39cf1-cc59-46d4-87f7-3fe1021bfa20', 'http challenge', 'An authentication flow based on challenge-response HTTP Authentication Schemes', 'CAP', 'basic-flow', true, true);
INSERT INTO public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) VALUES ('abbb0a1e-ea02-485b-953a-c7916c4f103f', 'Authentication Options', 'Authentication options.', 'CAP', 'basic-flow', false, true);


--
-- TOC entry 3811 (class 0 OID 16407)
-- Dependencies: 200
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('44d75399-f44d-4695-b57f-b6aa4a270220', 'review profile config', 'master');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('33f8618e-713c-46a4-b2ac-0eff00a13bfa', 'create unique user config', 'master');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('8df9b83b-843a-48cc-8539-567bf8a5a7c4', 'review profile config', 'CAP');
INSERT INTO public.authenticator_config (id, alias, realm_id) VALUES ('5a8b08d3-e037-48d3-a525-2a191924e7fb', 'create unique user config', 'CAP');


--
-- TOC entry 3812 (class 0 OID 16410)
-- Dependencies: 201
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('44d75399-f44d-4695-b57f-b6aa4a270220', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('33f8618e-713c-46a4-b2ac-0eff00a13bfa', 'false', 'require.password.update.after.registration');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('8df9b83b-843a-48cc-8539-567bf8a5a7c4', 'missing', 'update.profile.on.first.login');
INSERT INTO public.authenticator_config_entry (authenticator_id, value, name) VALUES ('5a8b08d3-e037-48d3-a525-2a191924e7fb', 'false', 'require.password.update.after.registration');


--
-- TOC entry 3813 (class 0 OID 16416)
-- Dependencies: 202
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3814 (class 0 OID 16422)
-- Dependencies: 203
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, false, 'master-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'master Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', true, false, 'account', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', true, false, 'account-console', 0, true, NULL, '/realms/master/account/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', true, false, 'security-admin-console', 0, true, NULL, '/admin/master/console/', false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'master', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('255350d7-f727-49d7-a63d-e207e35e270c', true, false, 'CAP-realm', 0, false, NULL, NULL, true, NULL, false, 'master', NULL, 0, false, false, 'CAP Realm', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', true, false, 'realm-management', 0, false, NULL, NULL, true, NULL, false, 'CAP', 'openid-connect', 0, false, false, '${client_realm-management}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', true, false, 'account', 0, true, NULL, '/realms/CAP/account/', false, NULL, false, 'CAP', 'openid-connect', 0, false, false, '${client_account}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', true, false, 'account-console', 0, true, NULL, '/realms/CAP/account/', false, NULL, false, 'CAP', 'openid-connect', 0, false, false, '${client_account-console}', false, 'client-secret', '${authBaseUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', true, false, 'broker', 0, false, NULL, NULL, true, NULL, false, 'CAP', 'openid-connect', 0, false, false, '${client_broker}', false, 'client-secret', NULL, NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', true, false, 'security-admin-console', 0, true, NULL, '/admin/CAP/console/', false, NULL, false, 'CAP', 'openid-connect', 0, false, false, '${client_security-admin-console}', false, 'client-secret', '${authAdminUrl}', NULL, NULL, true, false, false, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', true, false, 'admin-cli', 0, true, NULL, NULL, false, NULL, false, 'CAP', 'openid-connect', 0, false, false, '${client_admin-cli}', false, 'client-secret', NULL, NULL, NULL, false, false, true, false);
INSERT INTO public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', true, false, 'cap-app', 0, false, 'aQX4Vdbe7PhQTPCwRdeOwIdQzbpGkOdw', NULL, false, NULL, false, 'CAP', 'openid-connect', -1, false, false, NULL, true, 'client-secret', NULL, NULL, NULL, false, false, true, false);


--
-- TOC entry 3815 (class 0 OID 16441)
-- Dependencies: 204
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_attributes (client_id, value, name) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'S256', 'pkce.code.challenge.method');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'true', 'backchannel.logout.session.required');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'backchannel.logout.revoke.offline.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.artifact.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.server.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.server.signature.keyinfo.ext');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.assertion.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.client.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.encrypt');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.authnstatement');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.onetimeuse.condition');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml_force_name_id_format');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.multivalued.roles');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'saml.force.post.binding');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'exclude.session.state.from.auth.response');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'oauth2.device.authorization.grant.enabled');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'oidc.ciba.grant.enabled');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'true', 'use.refresh.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'id.token.as.detached.signature');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'tls.client.certificate.bound.access.tokens');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'require.pushed.authorization.requests');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'client_credentials.use_refresh_token');
INSERT INTO public.client_attributes (client_id, value, name) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'false', 'display.on.consent.screen');


--
-- TOC entry 3816 (class 0 OID 16447)
-- Dependencies: 205
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3817 (class 0 OID 16450)
-- Dependencies: 206
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3818 (class 0 OID 16453)
-- Dependencies: 207
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3819 (class 0 OID 16456)
-- Dependencies: 208
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('6d4fe2d4-8bb5-4482-a53c-10a4505d3726', 'offline_access', 'master', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('be31c4f8-7872-450a-904b-c9f94a3b9086', 'role_list', 'master', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('bb9a7a16-5dbe-4381-9242-a6196338e5d6', 'profile', 'master', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('5a37afa0-faab-4183-98cd-472c3a057335', 'email', 'master', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('43a4ed8e-c8b9-48ec-a916-d704ac8240a0', 'address', 'master', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('b277fa7e-5e87-4366-b032-c5be49f78358', 'phone', 'master', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('757461f9-f109-4c05-8e35-1ae23fac8747', 'roles', 'master', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('daaa93f1-aec3-40c1-afb2-bdf43da63495', 'web-origins', 'master', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('543866b8-2b13-43d0-b6d8-b47b158e4a52', 'microprofile-jwt', 'master', 'Microprofile - JWT built-in scope', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('273ed0d5-4061-4888-af9f-d403d4ad8c8a', 'offline_access', 'CAP', 'OpenID Connect built-in scope: offline_access', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('63e8230f-3ec1-4d2c-b0c1-e3bd2c1db62f', 'role_list', 'CAP', 'SAML role list', 'saml');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('a5cc25a0-1691-486a-a7e5-916199045ee3', 'profile', 'CAP', 'OpenID Connect built-in scope: profile', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('d6d9a2af-c2b6-4d85-a5fe-3498717917f6', 'email', 'CAP', 'OpenID Connect built-in scope: email', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('fe0f51af-b5c6-45f0-acc8-df3c16af808b', 'address', 'CAP', 'OpenID Connect built-in scope: address', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('b88e08dc-64fc-4c6c-9fd5-77708c103588', 'phone', 'CAP', 'OpenID Connect built-in scope: phone', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('e64621b4-cd4c-4fa6-b24c-46092795e57c', 'roles', 'CAP', 'OpenID Connect scope for add user roles to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('f12a3cce-609a-496b-ae0d-aee5645b1417', 'web-origins', 'CAP', 'OpenID Connect scope for add allowed web origins to the access token', 'openid-connect');
INSERT INTO public.client_scope (id, name, realm_id, description, protocol) VALUES ('3229350b-9873-4c73-9027-3ef99f12b58a', 'microprofile-jwt', 'CAP', 'Microprofile - JWT built-in scope', 'openid-connect');


--
-- TOC entry 3820 (class 0 OID 16462)
-- Dependencies: 209
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('6d4fe2d4-8bb5-4482-a53c-10a4505d3726', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('6d4fe2d4-8bb5-4482-a53c-10a4505d3726', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('be31c4f8-7872-450a-904b-c9f94a3b9086', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('be31c4f8-7872-450a-904b-c9f94a3b9086', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('bb9a7a16-5dbe-4381-9242-a6196338e5d6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('bb9a7a16-5dbe-4381-9242-a6196338e5d6', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('bb9a7a16-5dbe-4381-9242-a6196338e5d6', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('5a37afa0-faab-4183-98cd-472c3a057335', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('5a37afa0-faab-4183-98cd-472c3a057335', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('5a37afa0-faab-4183-98cd-472c3a057335', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('43a4ed8e-c8b9-48ec-a916-d704ac8240a0', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('43a4ed8e-c8b9-48ec-a916-d704ac8240a0', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('43a4ed8e-c8b9-48ec-a916-d704ac8240a0', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b277fa7e-5e87-4366-b032-c5be49f78358', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b277fa7e-5e87-4366-b032-c5be49f78358', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b277fa7e-5e87-4366-b032-c5be49f78358', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('757461f9-f109-4c05-8e35-1ae23fac8747', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('757461f9-f109-4c05-8e35-1ae23fac8747', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('757461f9-f109-4c05-8e35-1ae23fac8747', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('daaa93f1-aec3-40c1-afb2-bdf43da63495', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('daaa93f1-aec3-40c1-afb2-bdf43da63495', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('daaa93f1-aec3-40c1-afb2-bdf43da63495', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('543866b8-2b13-43d0-b6d8-b47b158e4a52', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('543866b8-2b13-43d0-b6d8-b47b158e4a52', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('273ed0d5-4061-4888-af9f-d403d4ad8c8a', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('273ed0d5-4061-4888-af9f-d403d4ad8c8a', '${offlineAccessScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('63e8230f-3ec1-4d2c-b0c1-e3bd2c1db62f', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('63e8230f-3ec1-4d2c-b0c1-e3bd2c1db62f', '${samlRoleListScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('a5cc25a0-1691-486a-a7e5-916199045ee3', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('a5cc25a0-1691-486a-a7e5-916199045ee3', '${profileScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('a5cc25a0-1691-486a-a7e5-916199045ee3', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d6d9a2af-c2b6-4d85-a5fe-3498717917f6', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d6d9a2af-c2b6-4d85-a5fe-3498717917f6', '${emailScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('d6d9a2af-c2b6-4d85-a5fe-3498717917f6', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fe0f51af-b5c6-45f0-acc8-df3c16af808b', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fe0f51af-b5c6-45f0-acc8-df3c16af808b', '${addressScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('fe0f51af-b5c6-45f0-acc8-df3c16af808b', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b88e08dc-64fc-4c6c-9fd5-77708c103588', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b88e08dc-64fc-4c6c-9fd5-77708c103588', '${phoneScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('b88e08dc-64fc-4c6c-9fd5-77708c103588', 'true', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('e64621b4-cd4c-4fa6-b24c-46092795e57c', 'true', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('e64621b4-cd4c-4fa6-b24c-46092795e57c', '${rolesScopeConsentText}', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('e64621b4-cd4c-4fa6-b24c-46092795e57c', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f12a3cce-609a-496b-ae0d-aee5645b1417', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f12a3cce-609a-496b-ae0d-aee5645b1417', '', 'consent.screen.text');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('f12a3cce-609a-496b-ae0d-aee5645b1417', 'false', 'include.in.token.scope');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('3229350b-9873-4c73-9027-3ef99f12b58a', 'false', 'display.on.consent.screen');
INSERT INTO public.client_scope_attributes (scope_id, value, name) VALUES ('3229350b-9873-4c73-9027-3ef99f12b58a', 'true', 'include.in.token.scope');


--
-- TOC entry 3821 (class 0 OID 16468)
-- Dependencies: 210
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('70a681a4-553d-4188-9ec3-bee027f3c6e1', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('6de0b292-3904-4649-8e1a-748444df2949', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('c5ffd670-9084-42e0-99ec-b5fc6130c0e7', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('0831f142-6f37-4e0f-9ae1-052388f1837f', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('041e527a-554d-46c7-ab67-a27cdcae0636', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b1529da2-2468-41f0-95d3-992490e45258', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '3229350b-9873-4c73-9027-3ef99f12b58a', false);
INSERT INTO public.client_scope_client (client_id, scope_id, default_scope) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);


--
-- TOC entry 3822 (class 0 OID 16475)
-- Dependencies: 211
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('6d4fe2d4-8bb5-4482-a53c-10a4505d3726', '1e2b7fbc-37a2-4ab2-b0a5-aa70dbde6a75');
INSERT INTO public.client_scope_role_mapping (scope_id, role_id) VALUES ('273ed0d5-4061-4888-af9f-d403d4ad8c8a', '361683dc-46bb-4cd0-8f1d-f0b6f0ba4bb7');


--
-- TOC entry 3823 (class 0 OID 16478)
-- Dependencies: 212
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3824 (class 0 OID 16484)
-- Dependencies: 213
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3825 (class 0 OID 16487)
-- Dependencies: 214
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3826 (class 0 OID 16493)
-- Dependencies: 215
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3827 (class 0 OID 16496)
-- Dependencies: 216
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3828 (class 0 OID 16499)
-- Dependencies: 217
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3829 (class 0 OID 16505)
-- Dependencies: 218
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('689f1513-7817-48d6-b2ad-4b29af75e1e3', 'Trusted Hosts', 'master', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f0ee0d55-2061-425e-ba25-ec56ffb9b69f', 'Consent Required', 'master', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('8e1eef3a-f278-4314-8aab-5611bf3ea955', 'Full Scope Disabled', 'master', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('13edf3ae-0d7d-4293-9580-466d5ffd5415', 'Max Clients Limit', 'master', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2772b9b3-ad54-4e85-9073-5326f3b050e1', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('c76abc12-1bc2-4d4a-a099-98fae9f6c9fc', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'Allowed Protocol Mapper Types', 'master', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2dda5fe0-59d7-4396-bee8-a8087b43852e', 'Allowed Client Scopes', 'master', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'master', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e340463d-a092-4633-9d0e-dedcda0baeec', 'rsa-generated', 'master', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f34c50ec-77f5-48f9-9fcc-0050020fca26', 'rsa-enc-generated', 'master', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('81faa049-d5ba-447c-b402-b072725e84f5', 'hmac-generated', 'master', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('62165fe7-b095-4595-a618-547627ad3b4b', 'aes-generated', 'master', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'master', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('990ec8de-c68f-438e-ba10-0bd14f222107', 'rsa-generated', 'CAP', 'rsa-generated', 'org.keycloak.keys.KeyProvider', 'CAP', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('8fe5cdb2-64a5-4d93-9ee5-a1ba8d836fac', 'rsa-enc-generated', 'CAP', 'rsa-enc-generated', 'org.keycloak.keys.KeyProvider', 'CAP', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('a79eed74-5288-4359-8334-aa667179ab38', 'hmac-generated', 'CAP', 'hmac-generated', 'org.keycloak.keys.KeyProvider', 'CAP', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('34a074c9-c8fc-4b69-805b-615151b480d1', 'aes-generated', 'CAP', 'aes-generated', 'org.keycloak.keys.KeyProvider', 'CAP', NULL);
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('0f448590-e8e5-4015-8176-4f502b4bc7ba', 'Trusted Hosts', 'CAP', 'trusted-hosts', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('436864bf-cd90-47c5-b03e-a90451eb53dc', 'Consent Required', 'CAP', 'consent-required', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('e7bd3aa7-5544-4488-9735-ecb7356cec3f', 'Full Scope Disabled', 'CAP', 'scope', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('f3efe3ea-1190-4780-bd09-e3e6cf0b526a', 'Max Clients Limit', 'CAP', 'max-clients', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2ed81802-0174-42ad-8514-8ff262668f0b', 'Allowed Protocol Mapper Types', 'CAP', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('5f69207e-ea03-40af-83e6-d0b7f041959b', 'Allowed Client Scopes', 'CAP', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'anonymous');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('5240db50-3d56-45ad-8332-060fc958db13', 'Allowed Protocol Mapper Types', 'CAP', 'allowed-protocol-mappers', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'authenticated');
INSERT INTO public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) VALUES ('2519348d-fed1-4d7f-b29a-6ee3bd9a26cf', 'Allowed Client Scopes', 'CAP', 'allowed-client-templates', 'org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy', 'CAP', 'authenticated');


--
-- TOC entry 3830 (class 0 OID 16511)
-- Dependencies: 219
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.component_config (id, component_id, name, value) VALUES ('200128ab-3d1d-4e92-ac8e-010d4e349240', '689f1513-7817-48d6-b2ad-4b29af75e1e3', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4174bbae-2761-4c3a-99ea-d18500d7c559', '689f1513-7817-48d6-b2ad-4b29af75e1e3', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('662727a2-368d-4a71-a6e8-c9005e0d2ca3', 'c76abc12-1bc2-4d4a-a099-98fae9f6c9fc', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('9f0a9d96-44a6-4093-8acd-9b5796daa6ae', '13edf3ae-0d7d-4293-9580-466d5ffd5415', 'max-clients', '200');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5f912146-534b-456b-a335-fa8f6264cf77', '2dda5fe0-59d7-4396-bee8-a8087b43852e', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('fbd3e363-7266-4045-ac08-ae69330b8b56', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('5012818e-6849-4b3a-a5e8-efd3df00c9ca', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('20c4642f-7c6a-4985-91e1-10caf89ebf54', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f57a9f1f-8213-4ad9-9419-120b8c6b7967', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('cd6ef23f-ae81-4a2c-a1fc-fe61109847a1', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('049d6fe1-2868-4b4b-b68a-7edd98957aa9', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('64a40dfc-24f1-4813-88ef-79b8778c59e5', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('dead8ed6-1feb-4aad-bf1a-5cf213f3422b', 'bc7f21d8-a4b8-478c-93fd-8ec386fd29f2', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b4a7c07b-8df7-4b84-9dba-8b6cf74b6674', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8ea15a01-682c-4118-8c1f-20e423f34438', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c630425c-0068-470f-b147-6c14520a9ac2', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('44e85f2f-282a-4961-a557-8edf0f036175', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('7f6e6215-3de4-44ef-8498-7d03d184506b', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('0f852308-45c8-4327-a9a5-59c76503afe7', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('531ade59-024a-48c3-90a5-f3b4da69ac8d', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4acdbe37-edf0-4c53-a223-fa3b267c7bf8', '2772b9b3-ad54-4e85-9073-5326f3b050e1', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('8b6ee7d6-ace9-4dff-970f-3b7ca0348307', '81faa049-d5ba-447c-b402-b072725e84f5', 'algorithm', 'HS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4528dd95-a02b-45ac-b559-19988875a6d1', '81faa049-d5ba-447c-b402-b072725e84f5', 'kid', 'f9e880a4-380b-4ab5-bb49-e918bff214cc');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('11a93e67-8879-4869-9f1c-a39b7014ffa2', '81faa049-d5ba-447c-b402-b072725e84f5', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ff312940-b9bf-4ed5-9b04-953bdcaa20df', '81faa049-d5ba-447c-b402-b072725e84f5', 'secret', '7KnNve9E6roaWAEuRfo2ysz3y91l219vfYTPf944WH48QkJAuSc7YxZuUVU1L4qzmXCSMmf87emuc1FkoR5Pyg');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c46fa3cd-49b0-4276-a50f-9fde321aed14', 'f34c50ec-77f5-48f9-9fcc-0050020fca26', 'privateKey', 'MIIEpAIBAAKCAQEAjBy4Ej7hn4segOwcbc0P3Qou/IJ094Ye50nQeKY/fv9fcfAGr85t8GcO97lb3VjqLhczLId59uDdE0x2wyMQA+mFduPVhVRMOUgfKEmBytFqsdcqBwmQfhKG4OGfavPUjaJp3YFQn9cX04YJ4fzk1O1V/lBh2vO1kTNrpDo+hEgBySzH1iqTgrA+chASos3eTQJUKxpOVDkve+2Ssu9Rsj0kXm7OAiYdShigVRVURdoEtl7bfkzJ4yAgrFHC/aQ3ydyUi4tLTFg+jkhjMPG5c+8baPCy8zG8c0CAkpVfoIlaT7M0Hl973uGOxDTJRSpcq7WR7fyuTiH/1YStPFv01QIDAQABAoIBAC5R6ECP7UMzWNhCNnvOSSpIDZSJBGY4Psszyem4/FDd2A3wziUc15ecWoRnEQmyNWkbXl2gRB/r4upYYwLL+qVwdCED3TkAz1o4j6Rf+Lq2VNGKUmiVLuGe+lwp+uv+xAw230zNTXwqPcQ+EdJWKsiB1eYHaPJbk3D3UOSwJK7SKhXtIEpoXSwkaX7tWqdkifz73FgUdQ5w3qYBdgnC88ZItnru4TF40anGqo6KYeHf1xJcStej5jq8cSv1ekXy9dQDLHqPugkdF891Jg5rUUiw7ZL/aYY6rqwX9b0yq0FwgV0JbMgdT4+B1hTNZpXt/VtsoYevkxj+4HPQ9fbqCJkCgYEAwQRnV5ubO3Lu2n/ImsbHtXz3nOsFtiy9YKfDyXUhuVPmYxjDuj3WFcM6uUEw3T+D5/xtakigMXwyjMXqnYcQliedJ1byCsCFMLcRzkx6wWKqM9eM/ZUZKuCtmBt7D+giRFHyK+3LFnnWknzLffWcojKrZLwNiv8lLAutaKFPbgMCgYEAudTrvhOPa3sMHhNskxkGx/n3Rmkeb20yiZQAnpiDQYgjIn8NmG4OuN/Jyc7CXBTxpL8yZBhQq5thzGv77XCPSStqsKcjWPiiVrCoriLP38w9MpM+peqzcFZmjcD+X6WMLYiad7BIftwbAzIH6oAcC7OBFDZ7YbBfkPNMJucAJkcCgYA5Y7POaqfnLy8xrFjbHEt4/OUqtP6Hwhm0yWz/U2JpljakNFLN52DmK5wkROvgfOgdbAKkXV+0Fvd4v8gYenZGDxU9Ay8IX2G6sFQNANRm940fyPFU3KYVB6TV2yXl/uFhavQUd6mwzx0rhQuEMikWWPZ5BykHsQE+bWJr/7p8PQKBgQCFOWhotI01eNmPFk3YhzCdXU8xY1s2dwqsJzbqfFxdNsQ5juyoQv66+3UnANvGOB2lBo2RxPzQimzqqN/Lsc6HnmC2lJx6xIVdsPi9Hqf4wet9vqJDQKez+b08EwhKedytKCnVdMQEbrfO6qdSLtXsbZw0aXq65j8dI8+MdD9fMQKBgQCHKjAakSpwc4Em1bHiEOkrq1khCdc8RbbBWjMrqe1LQkS0ggMA7qSGxcPdm7UDdqBebM+Y1zUY8IdHfscdX4O6fyrADmSxztz/yWD1kxN6FfakfBjzfvV/aO1D/wcpIBnorlgQnbYps+MHuKfiRLALrdWDbaldpNHorvsfkDWtIA==');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b3d185e5-c901-453b-8756-c0d0cad43b0a', 'f34c50ec-77f5-48f9-9fcc-0050020fca26', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('03302d8b-730c-4aee-a636-7a10beb103c0', 'f34c50ec-77f5-48f9-9fcc-0050020fca26', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c494d68f-5874-40b7-957b-d8aeb18bea01', 'f34c50ec-77f5-48f9-9fcc-0050020fca26', 'certificate', 'MIICmzCCAYMCBgF+2e66WjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMjA4MTUyMTQ4WhcNMzIwMjA4MTUyMzI4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCMHLgSPuGfix6A7BxtzQ/dCi78gnT3hh7nSdB4pj9+/19x8Aavzm3wZw73uVvdWOouFzMsh3n24N0TTHbDIxAD6YV249WFVEw5SB8oSYHK0Wqx1yoHCZB+Eobg4Z9q89SNomndgVCf1xfThgnh/OTU7VX+UGHa87WRM2ukOj6ESAHJLMfWKpOCsD5yEBKizd5NAlQrGk5UOS977ZKy71GyPSRebs4CJh1KGKBVFVRF2gS2Xtt+TMnjICCsUcL9pDfJ3JSLi0tMWD6OSGMw8blz7xto8LLzMbxzQICSlV+giVpPszQeX3ve4Y7ENMlFKlyrtZHt/K5OIf/VhK08W/TVAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAG1yRyY6Umdtri4yhUuxBMlIXAszXSGi/2GcYG9EHBpZBKYZo8d/AtoKqTjbltRi43MGg94ItCDKoo6JY0umRAdCWJUZbvGfa//aTE3rVmnpSlfutmEgklHvS+yWcoAQaTJ51vqF+IaxDGG/SEYugl2py44uO92UR4PVUiy9C/G5MbKO3HxerJG/r0e3T18FvZ3OMgOzaxDbiI6CVVGzDQQTeW8U1A76yMD88Z8gaNPaY2XmDl9RvASsyiippvTIP32xLJQ1BxA+rArcWjXRq+99UvE/AYWfohsabzcuIv4VZsdZU220uA7BoTCRpgIUDhCZ1H5TxQIQMQxGLbfUeE=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f24db74c-d570-4bb4-a46b-0da15e9f1f03', 'f34c50ec-77f5-48f9-9fcc-0050020fca26', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d7939ef6-8cd4-42e9-8cdc-8ab54646e0ee', 'e340463d-a092-4633-9d0e-dedcda0baeec', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('2129dd48-05d6-46fd-adb0-992fd9366bb5', 'e340463d-a092-4633-9d0e-dedcda0baeec', 'certificate', 'MIICmzCCAYMCBgF+2e638DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwMjA4MTUyMTQ3WhcNMzIwMjA4MTUyMzI3WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvwnwwLHEOdZMzaUMp8vKijdzXDo3sqrQPGGuBmEOB1K8sKz1HjCjTX+wQqB+2Lh660RVPXTGoUojBuHl8+tPjIMX625RUCFdk1wWyvmarXvex4pZVkZQGpYhDcBfC4XQl25PhVJA8VwwrD3+58N2Xf2IWP65C72NX+he3MzA3e0Ul3s3ekXcaSNCa3vkPiexhzwTnPE/8j7dtLjO62NCrB6TjPi1AUpNp7mgzHRuPYXpC57fe0rHiGJqacB8gk4G5GA/0aqntuD50E5zktOpQqB073Vj/xOlVMg5ExpuTvdIkZB0nwRKs+u9zQy0PIJJEZhuEiYLoM/IhxC+wlmJ7AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF0mfyZcxPdCsFrMHxlO5dRjuOADOM0kG9TnBDpeFMuBFMLDxiSLTjChyw3+fyVh5wB7kefZYXd1IZbpQh9VjbPfdtpK3fPRyrbC6IdyYic8JXJktCImFrD6uwyk0tpb2AYbWZzCn8bFHKe4D6mEFKXiRpEzCKjD+rKlxExe3WW1yO7hWXLR6NMAvXRyL3X1SysYXfm1j7a/7UA0B8Yw/sTWc78bWlerc2kfAjdXwDQ5ojAYGyU7ZzFyHVXqnl9QgARk/an6/mPWEaLlYwrz0vEhVFK53T9DWXKsoqY9z692IJEpL+kGjtefMwaLX8okXfFP6ch9I/gjeZMCn7TuXMw=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c19381ef-a4e1-44f4-b5bf-20e77ec8586e', 'e340463d-a092-4633-9d0e-dedcda0baeec', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('006ca8af-3df6-4042-b00c-90db8a7b44b1', 'e340463d-a092-4633-9d0e-dedcda0baeec', 'privateKey', 'MIIEowIBAAKCAQEAr8J8MCxxDnWTM2lDKfLyoo3c1w6N7Kq0DxhrgZhDgdSvLCs9R4wo01/sEKgfti4eutEVT10xqFKIwbh5fPrT4yDF+tuUVAhXZNcFsr5mq173seKWVZGUBqWIQ3AXwuF0JduT4VSQPFcMKw9/ufDdl39iFj+uQu9jV/oXtzMwN3tFJd7N3pF3GkjQmt75D4nsYc8E5zxP/I+3bS4zutjQqwek4z4tQFKTae5oMx0bj2F6Que33tKx4hiamnAfIJOBuRgP9Gqp7bg+dBOc5LTqUKgdO91Y/8TpVTIORMabk73SJGQdJ8ESrPrvc0MtDyCSRGYbhImC6DPyIcQvsJZiewIDAQABAoIBAAobnDrFA4d6WYnWXud1smCI2g+AJcdbldlcZSph0FgSHDTlE7QeqmZlmNToZlJ62oeR6LDUwjtU68qASnRWlIL2aoxfvmsKw8Pn3csGyi7G2mXfixfGtIWhVXHTa3port5Sf3GxBE6EDw4W6RiPcp7403JGHUZ6L/NqTZzak8ZM9r7wG9UpxRQZEOsTp1cyjcnxUhnRFHJ5/n/MKozb24elGCy4pv863EugWiGvKdip8gT/Vgk5qs+K8X5+yYubiVB3vo3h2hvDIispe+NvClA1e7sg2REr6+FdY7ZPeZsOVgQ4iAJTmRYSI5HdQB+Nz4Kz/tXBkPy1k7vQsHZGfXECgYEA/zv5t1aU5+V7Ob/aIYD6dNq79oYkKKYqznwaW+Y0IPIvuOgKfIozkj12+pyHB28NpAXlpDEw86Kv2Tu/H4Kgfy/vbrtaBu4IhRDW/kBLjcwY6NAf84BLRMGI2u6gPTeWsXc08UYm+UEQoKkar1D/azlarxY7doxpzxQq6k8qr9MCgYEAsEl4xGT3LVbBKIom+owN8IgnXK9CyoR7zSzworapaiKf1H4ZsfEnzIArx2EcdhURBcm4LMV+JjkKi1d49axpRLEpPVWQmnd8Plwg52SRuXygU0i4bMOrj/oR3SnIpCX0YnSisSeoIZhA3ZAHWIjQl45N83pMxnKSv/7UrzTMgbkCgYACPkSzl883Oo0atNT19mw9Gq8MO6GVueAmcHDK3fsXTwmcVm3BKnXJk0C4cye8qP01s9eQ2d3URlnFTwEfBcbjV0iDcKIZ7X2lrcA1+9quJF0TrsCZI0eGEy1gvzgpUZPBe4q7lCJDjo7W2qWhZNTZ3GcvosJjCFjluQenh4qYgQKBgQCuIIR3iTtVv2GgB4Yk6P5D3ljzBfK1U1NuALvYHREOUxEItV3wE8I6D0gu8k9Im9pqmyuenZzTaHhv1oEWOazpOwz/Fmt1CBzjA+FEbmQ6kU1TtnrkhAoMdvf6OvGCojLYpVimIAPE2z0HHOMEom9XpCp/GwiG5Fjr6Gxwe3idkQKBgDPbU2j13xZG0NesCsQ5GW9gBjMDTbakyzxk59ZwWa6AOEdsGJx7eNBU3ecYjdIdprnFAaaWALUJyTJPGVrLDgWKQFfakaVTpAqSDqEk3OxLAJ5Cm6N+CHV5DQGLkp0OtzjN3mrkggQCbmUSUYTsyqkg/depg18df5OvVB/ORwqa');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c61f1802-3134-47ca-9b42-a0edfb351b1d', '62165fe7-b095-4595-a618-547627ad3b4b', 'kid', '5197265d-4663-4264-9f82-552298d584c3');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1cd5c454-70f0-4fb5-b534-3b59ce344613', '62165fe7-b095-4595-a618-547627ad3b4b', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b94e7414-fa07-4719-b172-fb5fa36773a9', '62165fe7-b095-4595-a618-547627ad3b4b', 'secret', 'LjZBnUku2WtiMxV2-OI2gQ');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('836cda17-d860-4e6f-80b8-39f63bd2aa72', '34a074c9-c8fc-4b69-805b-615151b480d1', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('3d39892c-9c59-4814-a624-2ad641c5a1c3', '34a074c9-c8fc-4b69-805b-615151b480d1', 'kid', '291e7f9a-5e64-448c-b78c-e058194a9b5f');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e5c35f82-7eae-4644-8ca7-f1ee7b27ded3', '34a074c9-c8fc-4b69-805b-615151b480d1', 'secret', 'Py8AcZ8CgeFz1m7s4qwIJA');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a06987c0-4685-4ed4-acb0-7813e34a7491', '990ec8de-c68f-438e-ba10-0bd14f222107', 'keyUse', 'SIG');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('b30ec37f-6e5e-466f-87da-193aa37d4df5', '990ec8de-c68f-438e-ba10-0bd14f222107', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d1902bd0-2b8a-4e3d-8908-412d53f197db', '990ec8de-c68f-438e-ba10-0bd14f222107', 'certificate', 'MIIClTCCAX0CBgF/LakzBTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANDQVAwHhcNMjIwMjI0MjEzMzU3WhcNMzIwMjI0MjEzNTM3WjAOMQwwCgYDVQQDDANDQVAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCG1stmdAlbQjOMwwOf0oLVFjgi36kluadLDoHWk9cRsJTRsRhKPU9aejUaki13ZvXgq2ea6Ukok7cbkrb3rKHLFUgPNch46rmBjhcyaoIL7QADgWQajc4mByZa4eO462eGh19n630LfO/Vpae5nrmOIaD+/bDruIhRvG0i16PUHzXK+CHPRcExoLM9WcEcicKnwgDL3JrxEPfFVGPFGV+634KNH35yDS81sRWi/Q8PEV1qO8mXgpErGoXCjTYcCsevYz77rp8ouSD/wXtv0Yb1tU+9ogHi/Yvycm9kqqe/rKTFsNKdhMBA29nFnqCWQCv2ckXaKB+gD4kSXvBfpnX5AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAA6jmciiRTKgbs2UEEeqYVzfuvTduPlFROf1Ijv5vbAYEeyCAKEsIfnBxz3eqJtZtEslBUCWUhEkr6r+tDcIvenUA5deTfzXtgCHFIFAwmSZNiAJXTiXPEy2W4wJLWOdLBl0R7yQdiOKMjgMI2Yk5L+Wm2qw0sebARPTlyPFrfBMdK312L9im8HTErh/MZa37CivkhL15T42tCxpNKR2PiOQYHBMHU+ENebbTewBf9DjCD/6kQKx2C1q8GsVm2M9249ErUm53L+MMIY5Iz6IlMz1Uabxl/nuaoCNAtNLDoQ6mmownDEkVSs5/P6Ia8zVCZ9sIPeSr9eq052jazb7m98=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('844f4562-2c29-428b-8e1c-ab79937ac1bd', '990ec8de-c68f-438e-ba10-0bd14f222107', 'privateKey', 'MIIEowIBAAKCAQEAhtbLZnQJW0IzjMMDn9KC1RY4It+pJbmnSw6B1pPXEbCU0bEYSj1PWno1GpItd2b14KtnmulJKJO3G5K296yhyxVIDzXIeOq5gY4XMmqCC+0AA4FkGo3OJgcmWuHjuOtnhodfZ+t9C3zv1aWnuZ65jiGg/v2w67iIUbxtItej1B81yvghz0XBMaCzPVnBHInCp8IAy9ya8RD3xVRjxRlfut+CjR9+cg0vNbEVov0PDxFdajvJl4KRKxqFwo02HArHr2M++66fKLkg/8F7b9GG9bVPvaIB4v2L8nJvZKqnv6ykxbDSnYTAQNvZxZ6glkAr9nJF2igfoA+JEl7wX6Z1+QIDAQABAoIBAG1gROPZklFldP1kn0cAcsI44NZhCQsh+rMmlGmjyNx/mWgzOFnYO8tPwE3Kb3kgmqhhQYxmWcLBd9G1BBgJ/8AFhktYPELhXBLcWLK7tLvJxq4RQktL5gHw4Mrt21QAGB0HKHvaiLdN5Bow4snuF+RUIQ1WajH7oRB0QS73Ltx8NOUNaucB9msR7a2A9gmFgl8gb+kln5MKzztaulP0VtWpCRKU3b9JFxqDda3PWywLHuzQcQ4pJ7YoAaKQKMJeB9bBUqVm7dORZmALlYMo/zdG0pTdxShrtcYwA6rSeBG+TW49o36OPy/84u7cNYQUcCtFT54H+7J1VUu4xYqGNAECgYEA490FUdP5mdqKHHO9pNyECoXxwbgqs8MwcaPjjZLmacdFGrNf0IbrBAIkXueYW3ofy5UyIIdI3WAv6YqN2UO63tPsUAufKxXXpGKhwzv+hiuXR/LFtjt+K7PEVk8xmLy+WuTH8etwU3UxP+6IjKoC8XEC9RqANxUNRInSyJvB1YECgYEAl30vkhDgbDeMqbcmEFzq+p4R/jkUk0FW9hnrR1bWYy7Ukbz4pBvEP78XniIAzr6VFkPlHaF4qCC7KKDLcwrLb/azW2jYprdzlN4a8w83/Qb55mSof85OilkIJlAhbPPO4+qEMfx1FYqS+eb2Y76ATuM8HLNPi01Pzx2Fdd9GjHkCgYEAtJP24EdN+nivlSbANwOu/Kvz0GLELJvWK2kHL64oPdH22NcoaphRbWbJLhD5tB0PT4ZYKGEuBIpyzfDIw1KiqG5oS3M6W6m+sH6d1ZwY9HldNV6XAvkY30dipEe0dWe2r0+5iOXdqbYpJpJB0r/0/yRhhJ7Q11Yuoo9a5TJSpYECgYBBI18VG5Skc65UO6BuYMXZRabO/ZRPTUUrRTHZ1wkQVM6qa+suBZJ5Jp3tLQnT3DcW/9LAzvGmuYxAiANzUCzx086De63M4g0c8fP8l4qnjhxeaOHbMsaqzmWms8Xrp1pKvkhhhgCCZreUJS/E6+EYCrWKUb/eUjwC/tqoOH2JYQKBgBvLZ57BFT3nXPZVRf+3Fduf9Vv0MkY4neL3w/eWSh8gtVKuSxh5zYjWLqR0muPPri8wTvQutRMEldVxMTBiYd31ek5itMFTrnuECPIzp28cQO31/rYzuoR/wncXTvaeTB8fDQeI+nTof6gjxO61aUUZvPBE6NBF7v2ZKXwTbeou');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ddf6b120-aa7f-4381-8dd6-c9374043048d', '8fe5cdb2-64a5-4d93-9ee5-a1ba8d836fac', 'certificate', 'MIIClTCCAX0CBgF/Lak0ajANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANDQVAwHhcNMjIwMjI0MjEzMzU4WhcNMzIwMjI0MjEzNTM4WjAOMQwwCgYDVQQDDANDQVAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC7V7yz6CFpObCZOcCnoeaLrS9etrXUS2aH6FII82klSR9RmEmhO+iXECyST7EHZK13YI+ze7KZqhd26Cr090z1fiN+HLS+fu0evupANFrpWi18AJ1lA4+j88nODYT08mSnS4Uz4juAPfEYOmopSgWQvAcKJpN6+7H9i1PmWmHc+pl1TFYyag7hLCjuoy7cwakQR61Kl2vjQB+6R5oHvexSwKMhdbQv7mgx3ON0QofxWAyg2AJ/6EOYG2o2vJPiJyMO0KDe2ttTTEp28Vfqd4eyElfDQqsmrnpa5faLUUSKSkHko8TTG3Asn5KmdCj9clkoZxpX0ObOgTvG23qEcxNhAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHeqSU+POLmO5xl5PbhX8eh4lA2tKLIVUkAOjuPa5IPeptHw+JD5JEFIh0BiAmguxtxOF2HgzLMen+rO897WzUKGTXLypS9to1Ed+eEwxO+41ZyWakuLE0lzS28LA4ynkRqtip7ZIi/IbsEp/oHSzXAz8fPvX9AjfXilm3xONU2aMYCFkolNsSfIFS/2PuuXwr+JKgvMMYh8jTFGcmIt9DxnAKVZOjT8fHsx4pfMEAsbxBJZqUhCxoOqQZjNj1Ba0zMZV+ACIaVJv1nPEdPFMy6v6Aa1vf4zrs1Llvjs4c/iGDYBHdot9I9JtHN2Eb/StOYIYvlmxFcYFFyDSP2N6Jk=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('c018b136-ae67-4f1b-8a02-60206504048e', '8fe5cdb2-64a5-4d93-9ee5-a1ba8d836fac', 'algorithm', 'RSA-OAEP');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('07027595-3dea-40fd-87c5-d6177b9b917a', '8fe5cdb2-64a5-4d93-9ee5-a1ba8d836fac', 'keyUse', 'ENC');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('83703357-8a10-428c-8bff-696fa8b4c181', '8fe5cdb2-64a5-4d93-9ee5-a1ba8d836fac', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ccc5ab08-4b20-4e63-b79c-127d046aaaed', '8fe5cdb2-64a5-4d93-9ee5-a1ba8d836fac', 'privateKey', 'MIIEpQIBAAKCAQEAu1e8s+ghaTmwmTnAp6Hmi60vXra11Etmh+hSCPNpJUkfUZhJoTvolxAskk+xB2Std2CPs3uymaoXdugq9PdM9X4jfhy0vn7tHr7qQDRa6VotfACdZQOPo/PJzg2E9PJkp0uFM+I7gD3xGDpqKUoFkLwHCiaTevux/YtT5lph3PqZdUxWMmoO4Swo7qMu3MGpEEetSpdr40AfukeaB73sUsCjIXW0L+5oMdzjdEKH8VgMoNgCf+hDmBtqNryT4icjDtCg3trbU0xKdvFX6neHshJXw0KrJq56WuX2i1FEikpB5KPE0xtwLJ+SpnQo/XJZKGcaV9DmzoE7xtt6hHMTYQIDAQABAoIBAQChYktkj6t4ggHnfSDBR27bFC2iYbLxVqLUoQVKQKVrQTqBh7al9n2+5GgBAjV2MPxdwgkIjJ6mUSg1fnrC2+an9CmPEhuBnsWVntEczf0i2FQmZkEwK4kpq3FE19CZUdXzZ9MvhsvLBZETVf7t4p44uEE4NVMGtpv11nhID8QOHzmG0PQg60O8XSGz4Um0tBnysKFwMEeRQZ6wbJq4duZ914paxMfMHxKSzbMd+rGUTjvkRnjb4BZunvad99ONIouyrjzEMeQtAHATlzTK0BuW4p8QWBOxTXC5XNLEUaRzcH3QZoHqFOQVO/UMLsfMGYyPXakpUQHCAPiFcZAEqaIhAoGBAN6Z/uhHOYhIAU/3MQfBVMCF6qLHODbfvjvnlMN/K6CtGMQr7Xe+CLXOst5R14Zp83EGJ+9p565VX+BmNJEQnAfo5DQ3is1glMqFG9ylSd4QRCHH9QQcdlYGGhGhX9aMmWaqE+lxr9EAmKj6mcTK1yC2K6dbfybBnlldevN3PYknAoGBANdzeBzn5CTDdhfBfWjGnzq2EHrbOYRzhbxF3C2ui42KBbdV0A0QdwZJC02+DVfe0bBhCNGY2HzRBN1fSNj4Qi/7sH+5RoMf7p3IFVyk43xBWwsy4dJiLv29LHqC05t1RUGF7Igf1reKMwzlCwT/DU4+dMyXkimZlrF7gXEA+gQ3AoGAQPrdMXsRLVovn+M92dCy59xvyQK0wzf/NUd94q+t0aKV9zYHhQvhSQlEp6dmbeNh4B127OmSaw6bBUtwjuQ1WA3BCAkqqJdH9/JxVrCdZoiDCwVu3btdQ/FWDM15x4yVfyWo2F2KgE1XQwScfJjlwbPL/He2H18n1Vh3erjVKsMCgYEAidjUMdJgUvFIPnzKy13BhOP1+VUIIOl02HfuHsA9g4qai6l42tL9BGV5uPzvNphWmz4KUWg0ou9s6GJNjpyQZHjpfV7CcaTdm8/ncwYAkoCSSsD8YQn2vNvreFr6Hs3SSNDx/Eo6q+XdMdPd0A2LqtMlEb2sg7dEBjxaHj4cuNMCgYEA1cl92Er00dD1gFcPXIJory6f3dzO0npfQKrj+R5iBIArPEXQz5+XgwzU7WF/pQOdGZFJljSdIj/W/QEqrJWtf8Ovp7rig7ue/qJIOedGdM5mGVZfAkmv1VREkupHsog9l4fNnRz2YSJD3H1XxBj3s9Q5y6eFbEBcpT5bJrYOBME=');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d90c9455-a785-4d7a-828a-c6340c0996a4', 'a79eed74-5288-4359-8334-aa667179ab38', 'kid', 'c64bcc34-8f98-4eea-ad0b-65e919b3bbd6');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('735299d5-f5f8-4ae2-9c91-5283d42b7b84', 'a79eed74-5288-4359-8334-aa667179ab38', 'priority', '100');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('64a7d1e9-5a92-4c67-8398-af9795573f0a', 'a79eed74-5288-4359-8334-aa667179ab38', 'secret', '5wo-hF9JY-TSjC94IGCgj-aoVu8psqMhcLtfmaNAdTuPu-e9BLJIQallmlttDOw2OiaJPJOzJj765spUZu0JXg');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d10f5dea-3072-412b-8ee8-2c23bf2a47a7', 'a79eed74-5288-4359-8334-aa667179ab38', 'algorithm', 'HS256');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('23315b85-04b3-4930-aece-6fb54275cac5', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('4ec1f30e-0b3f-423a-97c6-54613ca656e4', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d64f8b7b-dab3-4382-bcee-a0ed43719a6b', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('beb1c20a-11e8-45a1-a13e-4b0565a67659', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('98ad90c6-9410-474e-9bb0-aa79d8767675', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('e031c119-3442-453b-b973-c93e0e18cf5f', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('6faf7b43-5c35-490c-872a-6f04b62b1d78', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('d7216e23-2308-4759-8b2f-7b63eee262b4', '2ed81802-0174-42ad-8514-8ff262668f0b', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('ca8edded-cf74-4246-b1f6-542612673a56', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'saml-user-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('9c9ab15e-172a-43de-8366-cb4da867c2b6', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'oidc-usermodel-attribute-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('f1d00bc3-b17e-4ca5-b024-8bb4df704173', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'oidc-usermodel-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('bd54f4c7-3128-4c7d-9a24-cd369aaccfdf', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'oidc-sha256-pairwise-sub-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('1d9b0b33-1401-4333-9881-73b25f12dc38', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'oidc-full-name-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('652eb4da-9bb0-40ee-82f4-757f5cc9e43f', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'saml-user-property-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('29a2146b-a29b-49c7-a3ac-824cbbcc82f1', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'oidc-address-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('74aabce1-695b-4401-811a-fb1400148143', '5240db50-3d56-45ad-8332-060fc958db13', 'allowed-protocol-mapper-types', 'saml-role-list-mapper');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('64692b04-799a-47f1-ada2-9f7ad0a4fc55', '5f69207e-ea03-40af-83e6-d0b7f041959b', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('88c1b4c4-ac8d-41af-8ba9-0271d0d77da0', '0f448590-e8e5-4015-8176-4f502b4bc7ba', 'client-uris-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('93b89e73-1e4a-4605-8a6b-86e43201278c', '0f448590-e8e5-4015-8176-4f502b4bc7ba', 'host-sending-registration-request-must-match', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('194204fc-fd5e-4286-a738-a19897175747', '2519348d-fed1-4d7f-b29a-6ee3bd9a26cf', 'allow-default-scopes', 'true');
INSERT INTO public.component_config (id, component_id, name, value) VALUES ('a5510149-6729-4dc5-a175-d5d166ead95c', 'f3efe3ea-1190-4780-bd09-e3e6cf0b526a', 'max-clients', '200');


--
-- TOC entry 3831 (class 0 OID 16517)
-- Dependencies: 220
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'f9b2498c-4372-4450-ba3d-990b9d5f8270');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'd3a0d4ef-4f19-42ec-80cc-891e953e510e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '1e607371-8b99-4d64-88d1-ff8a53be8875');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '61724c59-1b95-487d-82cd-1c35ea112029');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'b0e2d400-519c-456c-8df4-015026a408c6');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'fa8f0cb9-17d1-4c47-a743-5205021f59e7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '9c08805e-9ade-424c-b9ce-d8b70155cd75');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'f60c2f49-3d86-4d63-a07f-c9c9b5b06e54');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '0d29ff92-37df-47cb-9b71-0d2a34201e61');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '8f1e0b0f-3f64-410c-91d3-fbf89f350487');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'a31a80ee-090c-4a46-8d94-83d9a4f2ba1b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '055267f0-3ca4-4dab-8c02-a41f47c3d8ea');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'c8a909f7-0a39-4ec2-890c-fe5d711d02b1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '5086b878-b600-417b-b8f1-be3b9f90d8fb');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'a4029f2f-4a6f-40be-a199-b896877c4ad9');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '584123a6-9caa-4428-bc21-1121437ca831');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '4e235f28-68de-4724-aea8-3ead9c063c69');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '744d0e85-5ae1-4dfa-865c-bbcd97b6e265');
INSERT INTO public.composite_role (composite, child_role) VALUES ('b0e2d400-519c-456c-8df4-015026a408c6', '584123a6-9caa-4428-bc21-1121437ca831');
INSERT INTO public.composite_role (composite, child_role) VALUES ('61724c59-1b95-487d-82cd-1c35ea112029', '744d0e85-5ae1-4dfa-865c-bbcd97b6e265');
INSERT INTO public.composite_role (composite, child_role) VALUES ('61724c59-1b95-487d-82cd-1c35ea112029', 'a4029f2f-4a6f-40be-a199-b896877c4ad9');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8f5e4cf5-67e9-425a-81f2-94f848a56b19', '1568110d-9484-4ad8-9b47-a7717cbcfcd1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8f5e4cf5-67e9-425a-81f2-94f848a56b19', '29a0c8f3-87a5-4675-b716-fea8f460dcc6');
INSERT INTO public.composite_role (composite, child_role) VALUES ('29a0c8f3-87a5-4675-b716-fea8f460dcc6', '67a24e46-af75-45d6-b4c9-9d10d1411251');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0ae32fa4-8991-4137-8094-47fa46328fe9', 'e6961c98-db7b-4ea8-b97e-e137a6c4c280');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'afd8874f-a142-4027-9ab8-06b9aa9b2d58');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8f5e4cf5-67e9-425a-81f2-94f848a56b19', '1e2b7fbc-37a2-4ab2-b0a5-aa70dbde6a75');
INSERT INTO public.composite_role (composite, child_role) VALUES ('8f5e4cf5-67e9-425a-81f2-94f848a56b19', '73a4b3b5-859b-4c0c-b731-9f5f0edf313e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'c48df4a0-ae36-4a93-9a3f-2ed6094f2b5b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'd6aa6cd7-33e9-4c30-af3a-dd24795a7269');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'fe944dfd-b6ac-4e34-8140-66136ae7abf1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'cb2ed9e3-731d-4c34-9ff8-1710e284fd30');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '76c534e6-2676-4bd9-8330-d7518bea12f3');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'fd987e7e-923b-4e89-b142-8a2f8754e206');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'a30c0bb4-6fab-4ce0-9401-af18c6c6737f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'b3d8ef32-0dea-4768-a17a-6ab98a427335');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '9d45c19e-8972-4876-9ce8-f9cb5dee4a3d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '0273b4a9-ab4b-44f1-9767-736ce5b2189d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '4d8ea773-34b3-4870-8290-e53b767b8897');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '5117ea07-695c-48bd-a8ba-bf8af42ef814');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '48d256a2-5a3c-4289-a200-ecc41092920a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'dd69ea87-1502-4fbb-a6d7-075b7f41df11');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '9c51296a-bd3e-4b55-83e4-4d82758d801b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'e4a5be7b-214c-4c29-87fb-a061cb068be1');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '9bf618ce-e060-40d7-abd8-7dd6407a1e28');
INSERT INTO public.composite_role (composite, child_role) VALUES ('cb2ed9e3-731d-4c34-9ff8-1710e284fd30', '9c51296a-bd3e-4b55-83e4-4d82758d801b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('fe944dfd-b6ac-4e34-8140-66136ae7abf1', 'dd69ea87-1502-4fbb-a6d7-075b7f41df11');
INSERT INTO public.composite_role (composite, child_role) VALUES ('fe944dfd-b6ac-4e34-8140-66136ae7abf1', '9bf618ce-e060-40d7-abd8-7dd6407a1e28');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '25aff87c-fa6f-411d-9a05-6584a8c12656');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '1905f91c-f426-46ca-ba80-8e5d2d33790f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '7de77c1d-6c2d-4c69-9bfc-2ab1f0d9da05');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '2812bfdc-e7f4-43f4-b181-f87e58ed366f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '0064cc3a-bf73-42b0-b60e-16e16bc2dd72');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '24264fa6-c177-414b-a7c8-758dedf1826f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '4387cac5-2eb3-4bef-a084-d823db9f0256');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '9dcbc208-8189-440a-9e59-70502602e600');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '2ac3adc9-9d31-45cf-b30a-7b8c9adce32e');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '27f196c5-4b16-457d-bd36-27f64c57be7d');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '35a0a801-fe4d-4bfd-8479-24f88b60474a');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '74b6e62e-d8c3-4325-8a91-a0195c227155');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', 'ee7fdcef-8980-44c0-ac47-e0cf0bf175dc');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', 'fe08e3b7-c3c0-4306-97b2-3b470c7afbaa');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '4e8b5514-b8da-4739-9816-5113a2968004');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '3a834293-9a93-4e05-92d9-d9e80d0b7a7f');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', 'e8619a55-badc-4b41-911c-3e03396c0394');
INSERT INTO public.composite_role (composite, child_role) VALUES ('2812bfdc-e7f4-43f4-b181-f87e58ed366f', '4e8b5514-b8da-4739-9816-5113a2968004');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7de77c1d-6c2d-4c69-9bfc-2ab1f0d9da05', 'fe08e3b7-c3c0-4306-97b2-3b470c7afbaa');
INSERT INTO public.composite_role (composite, child_role) VALUES ('7de77c1d-6c2d-4c69-9bfc-2ab1f0d9da05', 'e8619a55-badc-4b41-911c-3e03396c0394');
INSERT INTO public.composite_role (composite, child_role) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', 'e5ba4966-e73e-4dd5-b51a-7c443b3a8a54');
INSERT INTO public.composite_role (composite, child_role) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', '81fd0b8a-d6d1-422f-affe-59da332a56af');
INSERT INTO public.composite_role (composite, child_role) VALUES ('81fd0b8a-d6d1-422f-affe-59da332a56af', '45b294b9-6637-447e-99c2-22a5fd2b8586');
INSERT INTO public.composite_role (composite, child_role) VALUES ('96e86293-4802-4a12-b693-127bbda25279', '4a035e29-c0aa-4c90-acbe-de0705d20a8b');
INSERT INTO public.composite_role (composite, child_role) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', '30057f1d-4196-4594-aec0-1ef86985f003');
INSERT INTO public.composite_role (composite, child_role) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '15de1118-7e55-4d2b-968a-22349e1b5b72');
INSERT INTO public.composite_role (composite, child_role) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', '361683dc-46bb-4cd0-8f1d-f0b6f0ba4bb7');
INSERT INTO public.composite_role (composite, child_role) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', '327112d1-da27-46a7-9f4b-cbbbb50be59b');


--
-- TOC entry 3832 (class 0 OID 16520)
-- Dependencies: 221
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('8a729c25-dc00-46a2-8625-0c2b9cea1947', NULL, 'password', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f', 1644333809510, NULL, '{"value":"XvE1QUrcBDa0uo5ZayBP77LaG1MVs0ntvo4d1X0bsk0szuVtS5eEYZbN7IBfH9h5MjOEcXa2mXZxdNT4u9Em2A==","salt":"w0Oywgnll9Z/KXnV3ag3fw==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('5e04ede4-9b89-4d3d-848d-69eacc6ba40b', NULL, 'password', '474a96af-2dea-4fb0-9ba9-c183b7776c13', 1645738735990, NULL, '{"value":"c7bDYdWJb+jCjNt9xLzePUIEzSDY8512SZXQRtFGIDara3Lrc3g1aFuA9JQLu0/oc/0Ws6B46ZuYbBpu5xcYXQ==","salt":"0tcjq9RliYvKovoinODb8w==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);
INSERT INTO public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) VALUES ('ed5808f3-4949-4761-9fc4-270d369a383f', NULL, 'password', 'fa9667dd-2549-4464-8bef-8cb57adc8796', 1645738878449, NULL, '{"value":"3OWpqhZb+HklhN8UPmyqzhGpFu0AkZzJYYHndIzB0J2UbKuVPtLa6bxjHI2i/ZG9M9LxVyGE6drd4+m58qgiuA==","salt":"GydK3NHhY0tUU2KvjcHWGA==","additionalParameters":{}}', '{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}', 10);


--
-- TOC entry 3833 (class 0 OID 16526)
-- Dependencies: 222
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.0.0.Final.xml', '2022-02-08 15:23:15.002467', 1, 'EXECUTED', '7:4e70412f24a3f382c82183742ec79317', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.0.0.Final-KEYCLOAK-5461', 'sthorger@redhat.com', 'META-INF/db2-jpa-changelog-1.0.0.Final.xml', '2022-02-08 15:23:15.02542', 2, 'MARK_RAN', '7:cb16724583e9675711801c6875114f28', 'createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Beta1', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Beta1.xml', '2022-02-08 15:23:15.095409', 3, 'EXECUTED', '7:0310eb8ba07cec616460794d42ade0fa', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.1.0.Final', 'sthorger@redhat.com', 'META-INF/jpa-changelog-1.1.0.Final.xml', '2022-02-08 15:23:15.100548', 4, 'EXECUTED', '7:5d25857e708c3233ef4439df1f93f012', 'renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/jpa-changelog-1.2.0.Beta1.xml', '2022-02-08 15:23:15.218312', 5, 'EXECUTED', '7:c7a54a1041d58eb3817a4a883b4d4e84', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Beta1', 'psilva@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.Beta1.xml', '2022-02-08 15:23:15.222501', 6, 'MARK_RAN', '7:2e01012df20974c1c2a605ef8afe25b7', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.2.0.CR1.xml', '2022-02-08 15:23:15.335754', 7, 'EXECUTED', '7:0f08df48468428e0f30ee59a8ec01a41', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.RC1', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.2.0.CR1.xml', '2022-02-08 15:23:15.340484', 8, 'MARK_RAN', '7:a77ea2ad226b345e7d689d366f185c8c', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.2.0.Final', 'keycloak', 'META-INF/jpa-changelog-1.2.0.Final.xml', '2022-02-08 15:23:15.352691', 9, 'EXECUTED', '7:a3377a2059aefbf3b90ebb4c4cc8e2ab', 'update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.3.0.xml', '2022-02-08 15:23:15.491697', 10, 'EXECUTED', '7:04c1dbedc2aa3e9756d1a1668e003451', 'delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.4.0.xml', '2022-02-08 15:23:15.55845', 11, 'EXECUTED', '7:36ef39ed560ad07062d956db861042ba', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.4.0', 'bburke@redhat.com', 'META-INF/db2-jpa-changelog-1.4.0.xml', '2022-02-08 15:23:15.561858', 12, 'MARK_RAN', '7:d909180b2530479a716d3f9c9eaea3d7', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.5.0.xml', '2022-02-08 15:23:15.581855', 13, 'EXECUTED', '7:cf12b04b79bea5152f165eb41f3955f6', 'delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from15', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-08 15:23:15.608636', 14, 'EXECUTED', '7:7e32c8f05c755e8675764e7d5f514509', 'addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16-pre', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-08 15:23:15.611338', 15, 'MARK_RAN', '7:980ba23cc0ec39cab731ce903dd01291', 'delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1_from16', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-08 15:23:15.613792', 16, 'MARK_RAN', '7:2fa220758991285312eb84f3b4ff5336', 'dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.6.1', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.6.1.xml', '2022-02-08 15:23:15.616173', 17, 'EXECUTED', '7:d41d8cd98f00b204e9800998ecf8427e', 'empty', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.7.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-1.7.0.xml', '2022-02-08 15:23:15.67557', 18, 'EXECUTED', '7:91ace540896df890cc00a0490ee52bbc', 'createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-08 15:23:15.735069', 19, 'EXECUTED', '7:c31d1646dfa2618a9335c00e07f89f24', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/jpa-changelog-1.8.0.xml', '2022-02-08 15:23:15.741532', 20, 'EXECUTED', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part1', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-08 15:23:17.673808', 45, 'EXECUTED', '7:6a48ce645a3525488a90fbf76adf3bb3', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0', 'mposolda@redhat.com', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-08 15:23:15.74523', 21, 'MARK_RAN', '7:f987971fe6b37d963bc95fee2b27f8df', 'addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.8.0-2', 'keycloak', 'META-INF/db2-jpa-changelog-1.8.0.xml', '2022-02-08 15:23:15.750275', 22, 'MARK_RAN', '7:df8bc21027a4f7cbbb01f6344e89ce07', 'dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.0', 'mposolda@redhat.com', 'META-INF/jpa-changelog-1.9.0.xml', '2022-02-08 15:23:15.805885', 23, 'EXECUTED', '7:ed2dc7f799d19ac452cbcda56c929e47', 'update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/jpa-changelog-1.9.1.xml', '2022-02-08 15:23:15.812001', 24, 'EXECUTED', '7:80b5db88a5dda36ece5f235be8757615', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.1', 'keycloak', 'META-INF/db2-jpa-changelog-1.9.1.xml', '2022-02-08 15:23:15.814597', 25, 'MARK_RAN', '7:1437310ed1305a9b93f8848f301726ce', 'modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('1.9.2', 'keycloak', 'META-INF/jpa-changelog-1.9.2.xml', '2022-02-08 15:23:16.164083', 26, 'EXECUTED', '7:b82ffb34850fa0836be16deefc6a87c4', 'createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.0.0', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.0.0.xml', '2022-02-08 15:23:16.276699', 27, 'EXECUTED', '7:9cc98082921330d8d9266decdd4bd658', 'createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-2.5.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-2.5.1.xml', '2022-02-08 15:23:16.281878', 28, 'EXECUTED', '7:03d64aeed9cb52b969bd30a7ac0db57e', 'update tableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.1.0-KEYCLOAK-5461', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.1.0.xml', '2022-02-08 15:23:16.380353', 29, 'EXECUTED', '7:f1f9fd8710399d725b780f463c6b21cd', 'createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.2.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.2.0.xml', '2022-02-08 15:23:16.399508', 30, 'EXECUTED', '7:53188c3eb1107546e6f765835705b6c1', 'addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.3.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.3.0.xml', '2022-02-08 15:23:16.419584', 31, 'EXECUTED', '7:d6e6f3bc57a0c5586737d1351725d4d4', 'createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.4.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.4.0.xml', '2022-02-08 15:23:16.426679', 32, 'EXECUTED', '7:454d604fbd755d9df3fd9c6329043aa5', 'customChange', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-08 15:23:16.434379', 33, 'EXECUTED', '7:57e98a3077e29caf562f7dbf80c72600', 'customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-oracle', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-08 15:23:16.437636', 34, 'MARK_RAN', '7:e4c7e8f2256210aee71ddc42f538b57a', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unicode-other-dbs', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-08 15:23:16.47683', 35, 'EXECUTED', '7:09a43c97e49bc626460480aa1379b522', 'modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-duplicate-email-support', 'slawomir@dabek.name', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-08 15:23:16.483555', 36, 'EXECUTED', '7:26bfc7c74fefa9126f2ce702fb775553', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.0-unique-group-names', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-2.5.0.xml', '2022-02-08 15:23:16.503867', 37, 'EXECUTED', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('2.5.1', 'bburke@redhat.com', 'META-INF/jpa-changelog-2.5.1.xml', '2022-02-08 15:23:16.508808', 38, 'EXECUTED', '7:37fc1781855ac5388c494f1442b3f717', 'addColumn tableName=FED_USER_CONSENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.0.0', 'bburke@redhat.com', 'META-INF/jpa-changelog-3.0.0.xml', '2022-02-08 15:23:16.513709', 39, 'EXECUTED', '7:13a27db0dae6049541136adad7261d27', 'addColumn tableName=IDENTITY_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-08 15:23:16.517934', 40, 'MARK_RAN', '7:550300617e3b59e8af3a6294df8248a3', 'addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-with-keycloak-5416', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-08 15:23:16.521555', 41, 'MARK_RAN', '7:e3a9482b8931481dc2772a5c07c44f17', 'dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fix-offline-sessions', 'hmlnarik', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-08 15:23:16.529404', 42, 'EXECUTED', '7:72b07d85a2677cb257edb02b408f332d', 'customChange', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.2.0-fixed', 'keycloak', 'META-INF/jpa-changelog-3.2.0.xml', '2022-02-08 15:23:17.662633', 43, 'EXECUTED', '7:a72a7858967bd414835d19e04d880312', 'addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.3.0', 'keycloak', 'META-INF/jpa-changelog-3.3.0.xml', '2022-02-08 15:23:17.66861', 44, 'EXECUTED', '7:94edff7cf9ce179e7e85f0cd78a3cf2c', 'addColumn tableName=USER_ENTITY', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-08 15:23:17.67931', 46, 'EXECUTED', '7:e64b5dcea7db06077c6e57d3b9e5ca14', 'customChange', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-08 15:23:17.681597', 47, 'MARK_RAN', '7:fd8cf02498f8b1e72496a20afc75178c', 'dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-08 15:23:17.802243', 48, 'EXECUTED', '7:542794f25aa2b1fbabb7e577d6646319', 'addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authn-3.4.0.CR1-refresh-token-max-reuse', 'glavoie@gmail.com', 'META-INF/jpa-changelog-authz-3.4.0.CR1.xml', '2022-02-08 15:23:17.809206', 49, 'EXECUTED', '7:edad604c882df12f74941dac3cc6d650', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0', 'keycloak', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-08 15:23:17.875542', 50, 'EXECUTED', '7:0f88b78b7b46480eb92690cbf5e44900', 'addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.0-KEYCLOAK-5230', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-3.4.0.xml', '2022-02-08 15:23:18.275231', 51, 'EXECUTED', '7:d560e43982611d936457c327f872dd59', 'createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.1', 'psilva@redhat.com', 'META-INF/jpa-changelog-3.4.1.xml', '2022-02-08 15:23:18.280805', 52, 'EXECUTED', '7:c155566c42b4d14ef07059ec3b3bbd8e', 'modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2', 'keycloak', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-08 15:23:18.284943', 53, 'EXECUTED', '7:b40376581f12d70f3c89ba8ddf5b7dea', 'update tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('3.4.2-KEYCLOAK-5172', 'mkanis@redhat.com', 'META-INF/jpa-changelog-3.4.2.xml', '2022-02-08 15:23:18.288951', 54, 'EXECUTED', '7:a1132cc395f7b95b3646146c2e38f168', 'update tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6335', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-08 15:23:18.299037', 55, 'EXECUTED', '7:d8dc5d89c789105cfa7ca0e82cba60af', 'createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-CLEANUP-UNUSED-TABLE', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-08 15:23:18.306414', 56, 'EXECUTED', '7:7822e0165097182e8f653c35517656a3', 'dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-6228', 'bburke@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-08 15:23:18.357656', 57, 'EXECUTED', '7:c6538c29b9c9a08f9e9ea2de5c2b6375', 'dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.0.0-KEYCLOAK-5579-fixed', 'mposolda@redhat.com', 'META-INF/jpa-changelog-4.0.0.xml', '2022-02-08 15:23:18.718137', 58, 'EXECUTED', '7:6d4893e36de22369cf73bcb051ded875', 'dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.CR1', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.CR1.xml', '2022-02-08 15:23:18.756798', 59, 'EXECUTED', '7:57960fc0b0f0dd0563ea6f8b2e4a1707', 'createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.0.0.Beta3', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-4.0.0.Beta3.xml', '2022-02-08 15:23:18.764996', 60, 'EXECUTED', '7:2b4b8bff39944c7097977cc18dbceb3b', 'addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final', 'mhajas@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-08 15:23:18.774829', 61, 'EXECUTED', '7:2aa42a964c59cd5b8ca9822340ba33a8', 'createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-4.2.0.Final-KEYCLOAK-9944', 'hmlnarik@redhat.com', 'META-INF/jpa-changelog-authz-4.2.0.Final.xml', '2022-02-08 15:23:18.783083', 62, 'EXECUTED', '7:9ac9e58545479929ba23f4a3087a0346', 'addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.2.0-KEYCLOAK-6313', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.2.0.xml', '2022-02-08 15:23:18.787454', 63, 'EXECUTED', '7:14d407c35bc4fe1976867756bcea0c36', 'addColumn tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.3.0-KEYCLOAK-7984', 'wadahiro@gmail.com', 'META-INF/jpa-changelog-4.3.0.xml', '2022-02-08 15:23:18.790442', 64, 'EXECUTED', '7:241a8030c748c8548e346adee548fa93', 'update tableName=REQUIRED_ACTION_PROVIDER', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-7950', 'psilva@redhat.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-08 15:23:18.793494', 65, 'EXECUTED', '7:7d3182f65a34fcc61e8d23def037dc3f', 'update tableName=RESOURCE_SERVER_RESOURCE', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8377', 'keycloak', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-08 15:23:18.828331', 66, 'EXECUTED', '7:b30039e00a0b9715d430d1b0636728fa', 'createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.6.0-KEYCLOAK-8555', 'gideonray@gmail.com', 'META-INF/jpa-changelog-4.6.0.xml', '2022-02-08 15:23:18.847842', 67, 'EXECUTED', '7:3797315ca61d531780f8e6f82f258159', 'createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-1267', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-08 15:23:18.853067', 68, 'EXECUTED', '7:c7aa4c8d9573500c2d347c1941ff0301', 'addColumn tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.7.0-KEYCLOAK-7275', 'keycloak', 'META-INF/jpa-changelog-4.7.0.xml', '2022-02-08 15:23:18.877043', 69, 'EXECUTED', '7:b207faee394fc074a442ecd42185a5dd', 'renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('4.8.0-KEYCLOAK-8835', 'sguilhen@redhat.com', 'META-INF/jpa-changelog-4.8.0.xml', '2022-02-08 15:23:18.884487', 70, 'EXECUTED', '7:ab9a9762faaba4ddfa35514b212c4922', 'addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('authz-7.0.0-KEYCLOAK-10443', 'psilva@redhat.com', 'META-INF/jpa-changelog-authz-7.0.0.xml', '2022-02-08 15:23:18.889611', 71, 'EXECUTED', '7:b9710f74515a6ccb51b72dc0d19df8c4', 'addColumn tableName=RESOURCE_SERVER', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-adding-credential-columns', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-08 15:23:18.896478', 72, 'EXECUTED', '7:ec9707ae4d4f0b7452fee20128083879', 'addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-not-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-08 15:23:18.913695', 73, 'EXECUTED', '7:3979a0ae07ac465e920ca696532fc736', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-updating-credential-data-oracle-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-08 15:23:18.916576', 74, 'MARK_RAN', '7:5abfde4c259119d143bd2fbf49ac2bca', 'update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-credential-cleanup-fixed', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-08 15:23:18.9452', 75, 'EXECUTED', '7:b48da8c11a3d83ddd6b7d0c8c2219345', 'dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('8.0.0-resource-tag-support', 'keycloak', 'META-INF/jpa-changelog-8.0.0.xml', '2022-02-08 15:23:18.980088', 76, 'EXECUTED', '7:a73379915c23bfad3e8f5c6d5c0aa4bd', 'addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-always-display-client', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-08 15:23:18.986064', 77, 'EXECUTED', '7:39e0073779aba192646291aa2332493d', 'addColumn tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-drop-constraints-for-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-08 15:23:18.989033', 78, 'MARK_RAN', '7:81f87368f00450799b4bf42ea0b3ec34', 'dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-increase-column-size-federated-fk', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-08 15:23:19.020345', 79, 'EXECUTED', '7:20b37422abb9fb6571c618148f013a15', 'modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.0-recreate-constraints-after-column-increase', 'keycloak', 'META-INF/jpa-changelog-9.0.0.xml', '2022-02-08 15:23:19.023422', 80, 'MARK_RAN', '7:1970bb6cfb5ee800736b95ad3fb3c78a', 'addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-client.client_id', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-08 15:23:19.052282', 81, 'EXECUTED', '7:45d9b25fc3b455d522d8dcc10a0f4c80', 'createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-08 15:23:19.055256', 82, 'MARK_RAN', '7:890ae73712bc187a66c2813a724d037f', 'dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-add-not-null-constraint', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-08 15:23:19.059988', 83, 'EXECUTED', '7:0a211980d27fafe3ff50d19a3a29b538', 'addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-KEYCLOAK-12579-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-08 15:23:19.062551', 84, 'MARK_RAN', '7:a161e2ae671a9020fff61e996a207377', 'addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('9.0.1-add-index-to-events', 'keycloak', 'META-INF/jpa-changelog-9.0.1.xml', '2022-02-08 15:23:19.085017', 85, 'EXECUTED', '7:01c49302201bdf815b0a18d1f98a55dc', 'createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-11.0.0.xml', '2022-02-08 15:23:19.090818', 86, 'EXECUTED', '7:3dace6b144c11f53f1ad2c0361279b86', 'dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-08 15:23:19.099439', 87, 'EXECUTED', '7:578d0b92077eaf2ab95ad0ec087aa903', 'dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('12.1.0-add-realm-localization-table', 'keycloak', 'META-INF/jpa-changelog-12.0.0.xml', '2022-02-08 15:23:19.112945', 88, 'EXECUTED', '7:c95abe90d962c57a09ecaee57972835d', 'createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.12102', 89, 'EXECUTED', '7:f1313bcc2994a5c4dc1062ed6d8282d3', 'addColumn tableName=REALM; customChange', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('default-roles-cleanup', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.128805', 90, 'EXECUTED', '7:90d763b52eaffebefbcbde55f269508b', 'dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-16844', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.149279', 91, 'EXECUTED', '7:d554f0cb92b764470dccfa5e0014a7dd', 'createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('map-remove-ri-13.0.0', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.158601', 92, 'EXECUTED', '7:73193e3ab3c35cf0f37ccea3bf783764', 'dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-drop-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.161164', 93, 'MARK_RAN', '7:90a1e74f92e9cbaa0c5eab80b8a037f3', 'dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-increase-column-size-federated', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.171511', 94, 'EXECUTED', '7:5b9248f29cd047c200083cc6d8388b16', 'modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('13.0.0-KEYCLOAK-17992-recreate-constraints', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.174117', 95, 'MARK_RAN', '7:64db59e44c374f13955489e8990d17a1', 'addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('json-string-accomodation-fixed', 'keycloak', 'META-INF/jpa-changelog-13.0.0.xml', '2022-02-08 15:23:19.180066', 96, 'EXECUTED', '7:329a578cdb43262fff975f0a7f6cda60', 'addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-11019', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.230728', 97, 'EXECUTED', '7:fae0de241ac0fd0bbc2b380b85e4f567', 'createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.233199', 98, 'MARK_RAN', '7:075d54e9180f49bb0c64ca4218936e81', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-revert', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.246698', 99, 'MARK_RAN', '7:06499836520f4f6b3d05e35a59324910', 'dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-supported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.290602', 100, 'EXECUTED', '7:fad08e83c77d0171ec166bc9bc5d390a', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('14.0.0-KEYCLOAK-18286-unsupported-dbs', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.293605', 101, 'MARK_RAN', '7:3d2b23076e59c6f70bae703aa01be35b', 'createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-17267-add-index-to-user-attributes', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.321958', 102, 'EXECUTED', '7:1a7f28ff8d9e53aeb879d76ea3d9341a', 'createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('KEYCLOAK-18146-add-saml-art-binding-identifier', 'keycloak', 'META-INF/jpa-changelog-14.0.0.xml', '2022-02-08 15:23:19.326454', 103, 'EXECUTED', '7:2fd554456fed4a82c698c555c5b751b6', 'customChange', '', NULL, '3.5.4', NULL, NULL, '4333794431');
INSERT INTO public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) VALUES ('15.0.0-KEYCLOAK-18467', 'keycloak', 'META-INF/jpa-changelog-15.0.0.xml', '2022-02-08 15:23:19.331937', 104, 'EXECUTED', '7:b06356d66c2790ecc2ae54ba0458397a', 'addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...', '', NULL, '3.5.4', NULL, NULL, '4333794431');


--
-- TOC entry 3834 (class 0 OID 16532)
-- Dependencies: 223
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1000, false, NULL, NULL);
INSERT INTO public.databasechangeloglock (id, locked, lockgranted, lockedby) VALUES (1001, false, NULL, NULL);


--
-- TOC entry 3835 (class 0 OID 16535)
-- Dependencies: 224
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '6d4fe2d4-8bb5-4482-a53c-10a4505d3726', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'be31c4f8-7872-450a-904b-c9f94a3b9086', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'bb9a7a16-5dbe-4381-9242-a6196338e5d6', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '5a37afa0-faab-4183-98cd-472c3a057335', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '43a4ed8e-c8b9-48ec-a916-d704ac8240a0', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'b277fa7e-5e87-4366-b032-c5be49f78358', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '757461f9-f109-4c05-8e35-1ae23fac8747', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', 'daaa93f1-aec3-40c1-afb2-bdf43da63495', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('master', '543866b8-2b13-43d0-b6d8-b47b158e4a52', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', '273ed0d5-4061-4888-af9f-d403d4ad8c8a', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', '63e8230f-3ec1-4d2c-b0c1-e3bd2c1db62f', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', 'a5cc25a0-1691-486a-a7e5-916199045ee3', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', 'fe0f51af-b5c6-45f0-acc8-df3c16af808b', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', 'b88e08dc-64fc-4c6c-9fd5-77708c103588', false);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', 'e64621b4-cd4c-4fa6-b24c-46092795e57c', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', 'f12a3cce-609a-496b-ae0d-aee5645b1417', true);
INSERT INTO public.default_client_scope (realm_id, scope_id, default_scope) VALUES ('CAP', '3229350b-9873-4c73-9027-3ef99f12b58a', false);


--
-- TOC entry 3836 (class 0 OID 16539)
-- Dependencies: 225
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3837 (class 0 OID 16545)
-- Dependencies: 226
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3838 (class 0 OID 16551)
-- Dependencies: 227
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3839 (class 0 OID 16557)
-- Dependencies: 228
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3840 (class 0 OID 16560)
-- Dependencies: 229
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3841 (class 0 OID 16566)
-- Dependencies: 230
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3842 (class 0 OID 16569)
-- Dependencies: 231
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3843 (class 0 OID 16576)
-- Dependencies: 232
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3844 (class 0 OID 16579)
-- Dependencies: 233
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3845 (class 0 OID 16585)
-- Dependencies: 234
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3846 (class 0 OID 16591)
-- Dependencies: 235
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3847 (class 0 OID 16598)
-- Dependencies: 236
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3848 (class 0 OID 16601)
-- Dependencies: 237
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3849 (class 0 OID 16613)
-- Dependencies: 238
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3850 (class 0 OID 16619)
-- Dependencies: 239
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3851 (class 0 OID 16625)
-- Dependencies: 240
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3852 (class 0 OID 16631)
-- Dependencies: 241
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3853 (class 0 OID 16634)
-- Dependencies: 242
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8f5e4cf5-67e9-425a-81f2-94f848a56b19', 'master', false, '${role_default-roles}', 'default-roles-master', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'master', false, '${role_admin}', 'admin', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f9b2498c-4372-4450-ba3d-990b9d5f8270', 'master', false, '${role_create-realm}', 'create-realm', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d3a0d4ef-4f19-42ec-80cc-891e953e510e', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_create-client}', 'create-client', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1e607371-8b99-4d64-88d1-ff8a53be8875', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_view-realm}', 'view-realm', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('61724c59-1b95-487d-82cd-1c35ea112029', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_view-users}', 'view-users', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b0e2d400-519c-456c-8df4-015026a408c6', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_view-clients}', 'view-clients', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fa8f0cb9-17d1-4c47-a743-5205021f59e7', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_view-events}', 'view-events', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9c08805e-9ade-424c-b9ce-d8b70155cd75', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('f60c2f49-3d86-4d63-a07f-c9c9b5b06e54', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_view-authorization}', 'view-authorization', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0d29ff92-37df-47cb-9b71-0d2a34201e61', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_manage-realm}', 'manage-realm', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('8f1e0b0f-3f64-410c-91d3-fbf89f350487', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_manage-users}', 'manage-users', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a31a80ee-090c-4a46-8d94-83d9a4f2ba1b', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_manage-clients}', 'manage-clients', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('055267f0-3ca4-4dab-8c02-a41f47c3d8ea', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_manage-events}', 'manage-events', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c8a909f7-0a39-4ec2-890c-fe5d711d02b1', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5086b878-b600-417b-b8f1-be3b9f90d8fb', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_manage-authorization}', 'manage-authorization', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a4029f2f-4a6f-40be-a199-b896877c4ad9', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_query-users}', 'query-users', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('584123a6-9caa-4428-bc21-1121437ca831', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_query-clients}', 'query-clients', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4e235f28-68de-4724-aea8-3ead9c063c69', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_query-realms}', 'query-realms', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('744d0e85-5ae1-4dfa-865c-bbcd97b6e265', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_query-groups}', 'query-groups', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1568110d-9484-4ad8-9b47-a7717cbcfcd1', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_view-profile}', 'view-profile', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('29a0c8f3-87a5-4675-b716-fea8f460dcc6', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_manage-account}', 'manage-account', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('67a24e46-af75-45d6-b4c9-9d10d1411251', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_manage-account-links}', 'manage-account-links', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0dae5961-f4e6-4d1e-a244-b3180a926bc9', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_view-applications}', 'view-applications', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e6961c98-db7b-4ea8-b97e-e137a6c4c280', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_view-consent}', 'view-consent', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0ae32fa4-8991-4137-8094-47fa46328fe9', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_manage-consent}', 'manage-consent', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('25b83ea7-7760-4dba-b8c6-f174495435e0', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', true, '${role_delete-account}', 'delete-account', 'master', 'b201cd92-399a-47a2-b745-c2dc4e34bd62', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fead2a99-726c-47cf-91fe-421c840ca8a6', '6de0b292-3904-4649-8e1a-748444df2949', true, '${role_read-token}', 'read-token', 'master', '6de0b292-3904-4649-8e1a-748444df2949', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('afd8874f-a142-4027-9ab8-06b9aa9b2d58', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', true, '${role_impersonation}', 'impersonation', 'master', 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1e2b7fbc-37a2-4ab2-b0a5-aa70dbde6a75', 'master', false, '${role_offline-access}', 'offline_access', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('73a4b3b5-859b-4c0c-b731-9f5f0edf313e', 'master', false, '${role_uma_authorization}', 'uma_authorization', 'master', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', 'CAP', false, '${role_default-roles}', 'default-roles-cap', 'CAP', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('c48df4a0-ae36-4a93-9a3f-2ed6094f2b5b', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_create-client}', 'create-client', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d6aa6cd7-33e9-4c30-af3a-dd24795a7269', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_view-realm}', 'view-realm', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fe944dfd-b6ac-4e34-8140-66136ae7abf1', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_view-users}', 'view-users', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('cb2ed9e3-731d-4c34-9ff8-1710e284fd30', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_view-clients}', 'view-clients', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('76c534e6-2676-4bd9-8330-d7518bea12f3', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_view-events}', 'view-events', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fd987e7e-923b-4e89-b142-8a2f8754e206', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_view-identity-providers}', 'view-identity-providers', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('a30c0bb4-6fab-4ce0-9401-af18c6c6737f', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_view-authorization}', 'view-authorization', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b3d8ef32-0dea-4768-a17a-6ab98a427335', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_manage-realm}', 'manage-realm', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9d45c19e-8972-4876-9ce8-f9cb5dee4a3d', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_manage-users}', 'manage-users', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0273b4a9-ab4b-44f1-9767-736ce5b2189d', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_manage-clients}', 'manage-clients', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4d8ea773-34b3-4870-8290-e53b767b8897', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_manage-events}', 'manage-events', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('5117ea07-695c-48bd-a8ba-bf8af42ef814', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('48d256a2-5a3c-4289-a200-ecc41092920a', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_manage-authorization}', 'manage-authorization', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('dd69ea87-1502-4fbb-a6d7-075b7f41df11', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_query-users}', 'query-users', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9c51296a-bd3e-4b55-83e4-4d82758d801b', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_query-clients}', 'query-clients', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e4a5be7b-214c-4c29-87fb-a061cb068be1', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_query-realms}', 'query-realms', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9bf618ce-e060-40d7-abd8-7dd6407a1e28', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_query-groups}', 'query-groups', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_realm-admin}', 'realm-admin', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('25aff87c-fa6f-411d-9a05-6584a8c12656', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_create-client}', 'create-client', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1905f91c-f426-46ca-ba80-8e5d2d33790f', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_view-realm}', 'view-realm', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('7de77c1d-6c2d-4c69-9bfc-2ab1f0d9da05', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_view-users}', 'view-users', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2812bfdc-e7f4-43f4-b181-f87e58ed366f', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_view-clients}', 'view-clients', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('0064cc3a-bf73-42b0-b60e-16e16bc2dd72', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_view-events}', 'view-events', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('24264fa6-c177-414b-a7c8-758dedf1826f', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_view-identity-providers}', 'view-identity-providers', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4387cac5-2eb3-4bef-a084-d823db9f0256', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_view-authorization}', 'view-authorization', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('9dcbc208-8189-440a-9e59-70502602e600', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_manage-realm}', 'manage-realm', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('2ac3adc9-9d31-45cf-b30a-7b8c9adce32e', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_manage-users}', 'manage-users', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('27f196c5-4b16-457d-bd36-27f64c57be7d', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_manage-clients}', 'manage-clients', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('35a0a801-fe4d-4bfd-8479-24f88b60474a', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_manage-events}', 'manage-events', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('74b6e62e-d8c3-4325-8a91-a0195c227155', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_manage-identity-providers}', 'manage-identity-providers', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('ee7fdcef-8980-44c0-ac47-e0cf0bf175dc', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_manage-authorization}', 'manage-authorization', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('fe08e3b7-c3c0-4306-97b2-3b470c7afbaa', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_query-users}', 'query-users', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4e8b5514-b8da-4739-9816-5113a2968004', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_query-clients}', 'query-clients', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('3a834293-9a93-4e05-92d9-d9e80d0b7a7f', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_query-realms}', 'query-realms', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e8619a55-badc-4b41-911c-3e03396c0394', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_query-groups}', 'query-groups', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('e5ba4966-e73e-4dd5-b51a-7c443b3a8a54', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_view-profile}', 'view-profile', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('81fd0b8a-d6d1-422f-affe-59da332a56af', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_manage-account}', 'manage-account', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('45b294b9-6637-447e-99c2-22a5fd2b8586', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_manage-account-links}', 'manage-account-links', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('d42bec70-fd43-41d7-aae1-b53b50616399', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_view-applications}', 'view-applications', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4a035e29-c0aa-4c90-acbe-de0705d20a8b', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_view-consent}', 'view-consent', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('96e86293-4802-4a12-b693-127bbda25279', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_manage-consent}', 'manage-consent', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('1df3bb3e-a7ca-4b5a-99fe-7663b1ba7640', '273cd6ca-70d7-4000-8a51-a421ccd86682', true, '${role_delete-account}', 'delete-account', 'CAP', '273cd6ca-70d7-4000-8a51-a421ccd86682', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('30057f1d-4196-4594-aec0-1ef86985f003', '255350d7-f727-49d7-a63d-e207e35e270c', true, '${role_impersonation}', 'impersonation', 'master', '255350d7-f727-49d7-a63d-e207e35e270c', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('15de1118-7e55-4d2b-968a-22349e1b5b72', 'b1529da2-2468-41f0-95d3-992490e45258', true, '${role_impersonation}', 'impersonation', 'CAP', 'b1529da2-2468-41f0-95d3-992490e45258', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('b2d80461-2d85-4666-83da-48863cd46c60', '041e527a-554d-46c7-ab67-a27cdcae0636', true, '${role_read-token}', 'read-token', 'CAP', '041e527a-554d-46c7-ab67-a27cdcae0636', NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('361683dc-46bb-4cd0-8f1d-f0b6f0ba4bb7', 'CAP', false, '${role_offline-access}', 'offline_access', 'CAP', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('327112d1-da27-46a7-9f4b-cbbbb50be59b', 'CAP', false, '${role_uma_authorization}', 'uma_authorization', 'CAP', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4666aae2-4feb-4111-91ac-ff88bd5bb5d4', 'CAP', false, 'Users have this role will have access to some api endpoints that the student role can''t access.', 'demonstrator', 'CAP', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('4ccc6c3e-0dcc-4a5b-8ae7-79619cf40b15', 'CAP', false, 'Users assigned to this role will have access to some endpoints that are only available for them.', 'student', 'CAP', NULL, NULL);
INSERT INTO public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) VALUES ('785040b2-3102-49a3-adc8-0c545beea043', 'CAP', false, '', 'admin', 'CAP', NULL, NULL);


--
-- TOC entry 3854 (class 0 OID 16641)
-- Dependencies: 243
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.migration_model (id, version, update_time) VALUES ('n2rqe', '16.1.0', 1644333804);


--
-- TOC entry 3855 (class 0 OID 16645)
-- Dependencies: 244
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3856 (class 0 OID 16653)
-- Dependencies: 245
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3857 (class 0 OID 16660)
-- Dependencies: 246
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3858 (class 0 OID 16666)
-- Dependencies: 247
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4e953b0f-0f03-4877-8338-540bf5e1f3fe', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', '31fab5fd-a6c4-472a-a737-83b0cb38ceee', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', '5b896a97-4553-4c23-bdd3-738d5fb06e6b', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6996922b-c7a9-4ada-a884-be521ff975ff', 'role list', 'saml', 'saml-role-list-mapper', NULL, 'be31c4f8-7872-450a-904b-c9f94a3b9086');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3a24a027-a22e-4308-8c01-3e2acde50e7a', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'bb9a7a16-5dbe-4381-9242-a6196338e5d6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '5a37afa0-faab-4183-98cd-472c3a057335');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '5a37afa0-faab-4183-98cd-472c3a057335');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'address', 'openid-connect', 'oidc-address-mapper', NULL, '43a4ed8e-c8b9-48ec-a916-d704ac8240a0');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b277fa7e-5e87-4366-b032-c5be49f78358');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b277fa7e-5e87-4366-b032-c5be49f78358');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e1e4b53f-6c62-4846-b461-8b46262632f8', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '757461f9-f109-4c05-8e35-1ae23fac8747');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2f151f40-485b-4217-b2b9-76b5578e3023', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, '757461f9-f109-4c05-8e35-1ae23fac8747');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7fb4a71a-0ab4-406a-a912-ae2867727e70', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, '757461f9-f109-4c05-8e35-1ae23fac8747');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7fe930bb-4781-459e-9dcf-2445991e4e55', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'daaa93f1-aec3-40c1-afb2-bdf43da63495');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '543866b8-2b13-43d0-b6d8-b47b158e4a52');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '543866b8-2b13-43d0-b6d8-b47b158e4a52');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b47ca284-268f-4be2-a216-3cfad545b045', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', 'b7ebb818-40f4-4272-ad17-85a3af269c14', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('653ee9fe-16f0-4e49-b8e1-30325b919bbe', 'role list', 'saml', 'saml-role-list-mapper', NULL, '63e8230f-3ec1-4d2c-b0c1-e3bd2c1db62f');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3e6bdf96-24c8-4f90-a7fb-8b3db5ead718', 'full name', 'openid-connect', 'oidc-full-name-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'family name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'given name', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'middle name', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'nickname', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'username', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'profile', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'picture', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'website', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'gender', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'birthdate', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'zoneinfo', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'updated at', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'a5cc25a0-1691-486a-a7e5-916199045ee3');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'email', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'email verified', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, 'd6d9a2af-c2b6-4d85-a5fe-3498717917f6');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'address', 'openid-connect', 'oidc-address-mapper', NULL, 'fe0f51af-b5c6-45f0-acc8-df3c16af808b');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'phone number', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b88e08dc-64fc-4c6c-9fd5-77708c103588');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'phone number verified', 'openid-connect', 'oidc-usermodel-attribute-mapper', NULL, 'b88e08dc-64fc-4c6c-9fd5-77708c103588');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('872939ba-caaf-4ddb-99cd-0ae9604c39b2', 'realm roles', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, 'e64621b4-cd4c-4fa6-b24c-46092795e57c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('c22075b4-d745-4c88-a814-633b24155ed2', 'client roles', 'openid-connect', 'oidc-usermodel-client-role-mapper', NULL, 'e64621b4-cd4c-4fa6-b24c-46092795e57c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('9dbec5aa-79a0-4cac-b8b9-647a1e045476', 'audience resolve', 'openid-connect', 'oidc-audience-resolve-mapper', NULL, 'e64621b4-cd4c-4fa6-b24c-46092795e57c');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('516d0efd-a338-459a-9024-a8703c767ca4', 'allowed web origins', 'openid-connect', 'oidc-allowed-origins-mapper', NULL, 'f12a3cce-609a-496b-ae0d-aee5645b1417');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'upn', 'openid-connect', 'oidc-usermodel-property-mapper', NULL, '3229350b-9873-4c73-9027-3ef99f12b58a');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'groups', 'openid-connect', 'oidc-usermodel-realm-role-mapper', NULL, '3229350b-9873-4c73-9027-3ef99f12b58a');
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'locale', 'openid-connect', 'oidc-usermodel-attribute-mapper', 'b41a94a8-63bc-4371-9a1d-59e02f446012', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('77c1ced5-bce3-4b2d-a111-f3602c1972b0', 'Client ID', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '92c59aec-0896-4840-adae-3f291ad1c9ad', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('7013a586-d808-429f-b048-94360a81d1fa', 'Client Host', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '92c59aec-0896-4840-adae-3f291ad1c9ad', NULL);
INSERT INTO public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) VALUES ('95d74a9a-63d7-4307-b0bc-e33b0486f681', 'Client IP Address', 'openid-connect', 'oidc-usersessionmodel-note-mapper', '92c59aec-0896-4840-adae-3f291ad1c9ad', NULL);


--
-- TOC entry 3859 (class 0 OID 16672)
-- Dependencies: 248
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ad590c60-cfdc-47d3-9bc5-3eede8ba5033', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6996922b-c7a9-4ada-a884-be521ff975ff', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6996922b-c7a9-4ada-a884-be521ff975ff', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6996922b-c7a9-4ada-a884-be521ff975ff', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a24a027-a22e-4308-8c01-3e2acde50e7a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a24a027-a22e-4308-8c01-3e2acde50e7a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a24a027-a22e-4308-8c01-3e2acde50e7a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ef66b0e2-cc27-4dd1-9de2-d2a28eb80f8c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f9f6b749-e769-4285-bb56-49a7ac5860e1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e2dd6ac-d713-4101-813e-84d048fd4f0a', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('eeb0b48f-4d5f-486c-ba3e-f23c60c44021', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('bc573a6b-d506-408b-986f-0d6178afff64', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8fb0a627-a9fd-40cc-94c9-599ce9c796c1', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b05a3bbf-caeb-4f0d-82d4-1f004736d079', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('6d6cbfac-7bd0-46ec-81a3-22db8d7fa8f5', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4ebda03c-4aba-4241-ad87-89111addc9b3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('537b1b1e-0587-42ad-9715-1eb46839ec24', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b08831b-f65f-480a-8003-271fe0c853ed', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('0b4f2eca-37b4-44b3-9f9a-fc15bff1332c', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3bb1a9af-25d0-4290-b42b-c10d9026d499', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8b2f74d4-584b-42c9-8ad3-6ff522f300a7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('756423c6-acbb-42fc-9e5f-7cf728973aaf', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f8e03cfe-19f9-40df-8ce1-34dc988b7ede', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('024e8514-027b-4907-aa99-5068bea8e2df', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('1a3f95ed-95eb-4464-a256-4c39ea344f30', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e1e4b53f-6c62-4846-b461-8b46262632f8', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e1e4b53f-6c62-4846-b461-8b46262632f8', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e1e4b53f-6c62-4846-b461-8b46262632f8', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e1e4b53f-6c62-4846-b461-8b46262632f8', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e1e4b53f-6c62-4846-b461-8b46262632f8', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f151f40-485b-4217-b2b9-76b5578e3023', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f151f40-485b-4217-b2b9-76b5578e3023', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f151f40-485b-4217-b2b9-76b5578e3023', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f151f40-485b-4217-b2b9-76b5578e3023', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2f151f40-485b-4217-b2b9-76b5578e3023', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('8e52660c-631c-472a-a169-39d29894cf53', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('02362dd8-8bf4-44a3-a796-d47ee483b4dc', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('653ee9fe-16f0-4e49-b8e1-30325b919bbe', 'false', 'single');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('653ee9fe-16f0-4e49-b8e1-30325b919bbe', 'Basic', 'attribute.nameformat');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('653ee9fe-16f0-4e49-b8e1-30325b919bbe', 'Role', 'attribute.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e6bdf96-24c8-4f90-a7fb-8b3db5ead718', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e6bdf96-24c8-4f90-a7fb-8b3db5ead718', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3e6bdf96-24c8-4f90-a7fb-8b3db5ead718', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'lastName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'family_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('67c51e3b-6487-48cc-88b7-84dc030c5119', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'firstName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'given_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4b763f14-d570-45ec-9420-81e2dab08319', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'middleName', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'middle_name', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a296d2f7-ca15-481b-b806-e4e9b20d6a5b', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'nickname', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'nickname', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('241aad6c-b5ee-44ec-ade1-9ddd466d844d', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'preferred_username', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('cdf5890f-6acf-4168-a095-385366d943e3', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'profile', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'profile', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('3a29b1bf-c500-4eb0-87a3-664e596f486f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'picture', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'picture', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('aa740f8d-4d26-4696-bc71-99d9f690b562', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'website', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'website', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('a25eda95-6c72-4d40-9e42-082e16988d87', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'gender', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'gender', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('576c61d9-f640-4c78-931c-b579ee23426f', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'birthdate', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'birthdate', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('45371408-14d2-411c-9317-589228e9c048', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'zoneinfo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'zoneinfo', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('f67ef182-0cea-4b5d-b1f0-a740f98aa662', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('837e5b47-227b-42d6-a72e-c650ad9a8f39', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'updatedAt', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'updated_at', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('035918f9-68b8-4291-81dd-655ec3bda146', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'email', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'email', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b028136d-6bde-4710-ba0d-6f892f5e9137', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'emailVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'email_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('465125a5-4bcd-491c-867d-fc363ff34038', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'formatted', 'user.attribute.formatted');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'country', 'user.attribute.country');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'postal_code', 'user.attribute.postal_code');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'street', 'user.attribute.street');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'region', 'user.attribute.region');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7c46f5be-995e-4b41-a396-7a3ff6dc4f55', 'locality', 'user.attribute.locality');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'phoneNumber', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'phone_number', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('2004b29e-770e-4801-9f83-a348bfc4e221', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'phoneNumberVerified', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'phone_number_verified', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('4f90a78e-4ab4-49f1-9195-0082f4f9fa53', 'boolean', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('872939ba-caaf-4ddb-99cd-0ae9604c39b2', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('872939ba-caaf-4ddb-99cd-0ae9604c39b2', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('872939ba-caaf-4ddb-99cd-0ae9604c39b2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('872939ba-caaf-4ddb-99cd-0ae9604c39b2', 'realm_access.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('872939ba-caaf-4ddb-99cd-0ae9604c39b2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22075b4-d745-4c88-a814-633b24155ed2', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22075b4-d745-4c88-a814-633b24155ed2', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22075b4-d745-4c88-a814-633b24155ed2', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22075b4-d745-4c88-a814-633b24155ed2', 'resource_access.${client_id}.roles', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('c22075b4-d745-4c88-a814-633b24155ed2', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'username', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'upn', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('b2649e87-358b-4656-ac3e-2914c0a8fb02', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'true', 'multivalued');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'foo', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'groups', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('e39d08fd-a61a-4d7d-a368-bfc6195326a7', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'true', 'userinfo.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'locale', 'user.attribute');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'locale', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('ab09cd10-1269-4e46-98cf-ce917173da34', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77c1ced5-bce3-4b2d-a111-f3602c1972b0', 'clientId', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77c1ced5-bce3-4b2d-a111-f3602c1972b0', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77c1ced5-bce3-4b2d-a111-f3602c1972b0', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77c1ced5-bce3-4b2d-a111-f3602c1972b0', 'clientId', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('77c1ced5-bce3-4b2d-a111-f3602c1972b0', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7013a586-d808-429f-b048-94360a81d1fa', 'clientHost', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7013a586-d808-429f-b048-94360a81d1fa', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7013a586-d808-429f-b048-94360a81d1fa', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7013a586-d808-429f-b048-94360a81d1fa', 'clientHost', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('7013a586-d808-429f-b048-94360a81d1fa', 'String', 'jsonType.label');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('95d74a9a-63d7-4307-b0bc-e33b0486f681', 'clientAddress', 'user.session.note');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('95d74a9a-63d7-4307-b0bc-e33b0486f681', 'true', 'id.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('95d74a9a-63d7-4307-b0bc-e33b0486f681', 'true', 'access.token.claim');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('95d74a9a-63d7-4307-b0bc-e33b0486f681', 'clientAddress', 'claim.name');
INSERT INTO public.protocol_mapper_config (protocol_mapper_id, value, name) VALUES ('95d74a9a-63d7-4307-b0bc-e33b0486f681', 'String', 'jsonType.label');


--
-- TOC entry 3860 (class 0 OID 16678)
-- Dependencies: 249
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('master', 60, 300, 60, NULL, NULL, NULL, true, false, 0, NULL, 'master', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, 'c5ffd670-9084-42e0-99ec-b5fc6130c0e7', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '7a4dc86d-5716-4f62-9dca-8f350ec173be', '7706c58f-2cad-4239-ab0a-785249f186a9', '9bb197e1-f04c-4f50-9b95-7c2d79b569cc', 'c8a0c540-a464-4fe2-aa64-d22bbad93855', 'e93d0486-0f85-466f-b7ec-20ef85b997bc', 2592000, false, 900, true, false, '52a66e94-bf7a-406c-bee0-01061d9c6cb5', 0, false, 0, 0, '8f5e4cf5-67e9-425a-81f2-94f848a56b19');
INSERT INTO public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) VALUES ('CAP', 60, 300, 300, NULL, NULL, NULL, true, false, 0, NULL, 'CAP', 0, NULL, false, false, false, false, 'EXTERNAL', 1800, 36000, false, false, '255350d7-f727-49d7-a63d-e207e35e270c', 1800, false, NULL, false, false, false, false, 0, 1, 30, 6, 'HmacSHA1', 'totp', '5b0b55da-8477-41c4-a819-9dfebdc034cc', '0da7e7bf-9f0e-46be-9196-0953a88382c1', 'd75139f6-a0ad-425a-af07-8324f27557e7', '1a4dfbb9-bc1b-4e55-b5bf-c69aad806bc1', '0fc25843-3a94-474a-b92e-5f6b9ff9ca7d', 2592000, false, 900, true, false, 'beb742d5-44b0-413d-8ad8-81005a3ff0b4', 0, false, 0, 0, '3d493227-1aa1-481d-8f5c-d5ccc788460a');


--
-- TOC entry 3861 (class 0 OID 16712)
-- Dependencies: 250
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'master', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', 'master', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', 'master', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', 'master', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', 'master', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', 'master', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', 'master', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', 'master', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', 'master', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', 'master', '900');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', 'master', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', 'master', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', 'master', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', 'master', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('failureFactor', 'master', '30');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayName', 'master', 'Keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('displayNameHtml', 'master', '<div class="kc-logo-text"><span>Keycloak</span></div>');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', 'master', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', 'master', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', 'master', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicyReportOnly', 'CAP', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xContentTypeOptions', 'CAP', 'nosniff');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xRobotsTag', 'CAP', 'none');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xFrameOptions', 'CAP', 'SAMEORIGIN');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.contentSecurityPolicy', 'CAP', 'frame-src ''self''; frame-ancestors ''self''; object-src ''none'';');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.xXSSProtection', 'CAP', '1; mode=block');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('_browser_header.strictTransportSecurity', 'CAP', 'max-age=31536000; includeSubDomains');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('bruteForceProtected', 'CAP', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('permanentLockout', 'CAP', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxFailureWaitSeconds', 'CAP', '900');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('minimumQuickLoginWaitSeconds', 'CAP', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('waitIncrementSeconds', 'CAP', '60');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('quickLoginCheckMilliSeconds', 'CAP', '1000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('maxDeltaTimeSeconds', 'CAP', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('failureFactor', 'CAP', '30');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('defaultSignatureAlgorithm', 'CAP', 'RS256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespanEnabled', 'CAP', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('offlineSessionMaxLifespan', 'CAP', '5184000');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByAdminLifespan', 'CAP', '43200');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('actionTokenGeneratedByUserLifespan', 'CAP', '300');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('oauth2DeviceCodeLifespan', 'CAP', '600');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('oauth2DevicePollingInterval', 'CAP', '5');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityName', 'CAP', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithms', 'CAP', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpId', 'CAP', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreference', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachment', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKey', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirement', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeout', 'CAP', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegister', 'CAP', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpEntityNamePasswordless', 'CAP', 'keycloak');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicySignatureAlgorithmsPasswordless', 'CAP', 'ES256');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRpIdPasswordless', 'CAP', '');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAttestationConveyancePreferencePasswordless', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAuthenticatorAttachmentPasswordless', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyRequireResidentKeyPasswordless', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyUserVerificationRequirementPasswordless', 'CAP', 'not specified');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyCreateTimeoutPasswordless', 'CAP', '0');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless', 'CAP', 'false');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaBackchannelTokenDeliveryMode', 'CAP', 'poll');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaExpiresIn', 'CAP', '120');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaInterval', 'CAP', '5');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('cibaAuthRequestedUserHint', 'CAP', 'login_hint');
INSERT INTO public.realm_attribute (name, realm_id, value) VALUES ('parRequestUriLifespan', 'CAP', '60');


--
-- TOC entry 3862 (class 0 OID 16718)
-- Dependencies: 251
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3863 (class 0 OID 16721)
-- Dependencies: 252
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3864 (class 0 OID 16724)
-- Dependencies: 253
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('master', 'jboss-logging');
INSERT INTO public.realm_events_listeners (realm_id, value) VALUES ('CAP', 'jboss-logging');


--
-- TOC entry 3865 (class 0 OID 16727)
-- Dependencies: 254
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3866 (class 0 OID 16733)
-- Dependencies: 255
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'master');
INSERT INTO public.realm_required_credential (type, form_label, input, secret, realm_id) VALUES ('password', 'password', true, true, 'CAP');


--
-- TOC entry 3867 (class 0 OID 16741)
-- Dependencies: 256
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3868 (class 0 OID 16747)
-- Dependencies: 257
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3869 (class 0 OID 16750)
-- Dependencies: 258
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.redirect_uris (client_id, value) VALUES ('b201cd92-399a-47a2-b745-c2dc4e34bd62', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '/realms/master/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '/admin/master/console/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('273cd6ca-70d7-4000-8a51-a421ccd86682', '/realms/CAP/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', '/realms/CAP/account/*');
INSERT INTO public.redirect_uris (client_id, value) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', '/admin/CAP/console/*');


--
-- TOC entry 3870 (class 0 OID 16753)
-- Dependencies: 259
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3871 (class 0 OID 16759)
-- Dependencies: 260
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a8ea36cf-d244-482c-a099-dbfaae003d1a', 'VERIFY_EMAIL', 'Verify Email', 'master', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('0a73c073-10cf-4fae-b549-1b32414c6822', 'UPDATE_PROFILE', 'Update Profile', 'master', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('c9be84b0-a70a-4f50-8d4c-becbca23edb6', 'CONFIGURE_TOTP', 'Configure OTP', 'master', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a81e38f1-607b-40da-ab8a-11b38fc11e54', 'UPDATE_PASSWORD', 'Update Password', 'master', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('5e42d531-411c-4d19-ace1-e8848c0854a2', 'terms_and_conditions', 'Terms and Conditions', 'master', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('82b7b13a-b8fc-470d-8200-8eb6f3c9958f', 'update_user_locale', 'Update User Locale', 'master', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('49b6c0d0-0d2a-427a-a9b3-c800a3b8b81f', 'delete_account', 'Delete Account', 'master', false, false, 'delete_account', 60);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('db4dc5d6-7bda-4f8f-bd41-dd4300c01ad1', 'VERIFY_EMAIL', 'Verify Email', 'CAP', true, false, 'VERIFY_EMAIL', 50);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('4c788267-35f3-4a72-8262-8814e84c2589', 'UPDATE_PROFILE', 'Update Profile', 'CAP', true, false, 'UPDATE_PROFILE', 40);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('a934e621-7081-4689-afa7-4c28bfd3ce82', 'CONFIGURE_TOTP', 'Configure OTP', 'CAP', true, false, 'CONFIGURE_TOTP', 10);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('76975d49-e6e2-4581-baae-45f08849ee0d', 'UPDATE_PASSWORD', 'Update Password', 'CAP', true, false, 'UPDATE_PASSWORD', 30);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('952533f7-7238-4a48-a2b9-f8053d4d3ed5', 'terms_and_conditions', 'Terms and Conditions', 'CAP', false, false, 'terms_and_conditions', 20);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('e9a194a1-50ab-4800-ae87-a355195e859d', 'update_user_locale', 'Update User Locale', 'CAP', true, false, 'update_user_locale', 1000);
INSERT INTO public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) VALUES ('2087bdf9-9517-4098-88e3-9eb90718cfae', 'delete_account', 'Delete Account', 'CAP', false, false, 'delete_account', 60);


--
-- TOC entry 3872 (class 0 OID 16767)
-- Dependencies: 261
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3873 (class 0 OID 16774)
-- Dependencies: 262
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3874 (class 0 OID 16777)
-- Dependencies: 263
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3875 (class 0 OID 16780)
-- Dependencies: 264
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3876 (class 0 OID 16785)
-- Dependencies: 265
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3877 (class 0 OID 16791)
-- Dependencies: 266
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3878 (class 0 OID 16797)
-- Dependencies: 267
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3879 (class 0 OID 16804)
-- Dependencies: 268
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3880 (class 0 OID 16810)
-- Dependencies: 269
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3881 (class 0 OID 16813)
-- Dependencies: 270
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3882 (class 0 OID 16819)
-- Dependencies: 271
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('31fab5fd-a6c4-472a-a737-83b0cb38ceee', '29a0c8f3-87a5-4675-b716-fea8f460dcc6');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('b7ebb818-40f4-4272-ad17-85a3af269c14', '81fd0b8a-d6d1-422f-affe-59da332a56af');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '4666aae2-4feb-4111-91ac-ff88bd5bb5d4');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '3d493227-1aa1-481d-8f5c-d5ccc788460a');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '361683dc-46bb-4cd0-8f1d-f0b6f0ba4bb7');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '327112d1-da27-46a7-9f4b-cbbbb50be59b');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '4ccc6c3e-0dcc-4a5b-8ae7-79619cf40b15');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '25aff87c-fa6f-411d-9a05-6584a8c12656');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '4e8b5514-b8da-4739-9816-5113a2968004');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'e8619a55-badc-4b41-911c-3e03396c0394');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '0e4bdb96-a0d9-496c-a725-14f03ef730b9');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '1905f91c-f426-46ca-ba80-8e5d2d33790f');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '7de77c1d-6c2d-4c69-9bfc-2ab1f0d9da05');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '2812bfdc-e7f4-43f4-b181-f87e58ed366f');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '27f196c5-4b16-457d-bd36-27f64c57be7d');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'ee7fdcef-8980-44c0-ac47-e0cf0bf175dc');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', 'fe08e3b7-c3c0-4306-97b2-3b470c7afbaa');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '9dcbc208-8189-440a-9e59-70502602e600');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '3a834293-9a93-4e05-92d9-d9e80d0b7a7f');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '0064cc3a-bf73-42b0-b60e-16e16bc2dd72');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '35a0a801-fe4d-4bfd-8479-24f88b60474a');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '2ac3adc9-9d31-45cf-b30a-7b8c9adce32e');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '15de1118-7e55-4d2b-968a-22349e1b5b72');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '74b6e62e-d8c3-4325-8a91-a0195c227155');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '4387cac5-2eb3-4bef-a084-d823db9f0256');
INSERT INTO public.scope_mapping (client_id, role_id) VALUES ('92c59aec-0896-4840-adae-3f291ad1c9ad', '24264fa6-c177-414b-a7c8-758dedf1826f');


--
-- TOC entry 3883 (class 0 OID 16822)
-- Dependencies: 272
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3884 (class 0 OID 16825)
-- Dependencies: 273
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3885 (class 0 OID 16832)
-- Dependencies: 274
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3886 (class 0 OID 16838)
-- Dependencies: 275
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3887 (class 0 OID 16841)
-- Dependencies: 276
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('b3e2d387-81e8-4fb9-a74e-a941a8c4804f', NULL, '80adcd6b-afe6-4e08-9e69-09ba23edcc01', false, true, NULL, NULL, NULL, 'master', 'admin', 1644333809399, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('3e4386c0-6580-4b79-b2ab-5021406d3cd6', NULL, '2c34abc3-a7f9-4322-95cc-d47331044929', false, true, NULL, NULL, NULL, 'CAP', 'service-account-cap-app', 1645738672200, '92c59aec-0896-4840-adae-3f291ad1c9ad', 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('474a96af-2dea-4fb0-9ba9-c183b7776c13', NULL, '773a4d00-3625-4978-aae4-50484d024352', false, true, NULL, NULL, NULL, 'CAP', 'teacher-1', 1645738723637, NULL, 0);
INSERT INTO public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) VALUES ('fa9667dd-2549-4464-8bef-8cb57adc8796', NULL, 'd0befb4e-c8a8-4850-8370-0ddd54ea1d55', false, true, NULL, NULL, NULL, 'CAP', 'student-1', 1645738867953, NULL, 0);


--
-- TOC entry 3888 (class 0 OID 16850)
-- Dependencies: 277
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3889 (class 0 OID 16856)
-- Dependencies: 278
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3890 (class 0 OID 16862)
-- Dependencies: 279
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3891 (class 0 OID 16868)
-- Dependencies: 280
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3892 (class 0 OID 16874)
-- Dependencies: 281
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3893 (class 0 OID 16877)
-- Dependencies: 282
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3894 (class 0 OID 16881)
-- Dependencies: 283
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('8f5e4cf5-67e9-425a-81f2-94f848a56b19', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('74c2b1c5-fea4-4191-82f0-83552f718734', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('c48df4a0-ae36-4a93-9a3f-2ed6094f2b5b', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('d6aa6cd7-33e9-4c30-af3a-dd24795a7269', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('fe944dfd-b6ac-4e34-8140-66136ae7abf1', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('cb2ed9e3-731d-4c34-9ff8-1710e284fd30', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('76c534e6-2676-4bd9-8330-d7518bea12f3', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('fd987e7e-923b-4e89-b142-8a2f8754e206', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('a30c0bb4-6fab-4ce0-9401-af18c6c6737f', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('b3d8ef32-0dea-4768-a17a-6ab98a427335', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9d45c19e-8972-4876-9ce8-f9cb5dee4a3d', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('0273b4a9-ab4b-44f1-9767-736ce5b2189d', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('4d8ea773-34b3-4870-8290-e53b767b8897', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('5117ea07-695c-48bd-a8ba-bf8af42ef814', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('48d256a2-5a3c-4289-a200-ecc41092920a', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('dd69ea87-1502-4fbb-a6d7-075b7f41df11', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9c51296a-bd3e-4b55-83e4-4d82758d801b', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('e4a5be7b-214c-4c29-87fb-a061cb068be1', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9bf618ce-e060-40d7-abd8-7dd6407a1e28', 'b3e2d387-81e8-4fb9-a74e-a941a8c4804f');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', '474a96af-2dea-4fb0-9ba9-c183b7776c13');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('4666aae2-4feb-4111-91ac-ff88bd5bb5d4', '474a96af-2dea-4fb0-9ba9-c183b7776c13');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3d493227-1aa1-481d-8f5c-d5ccc788460a', 'fa9667dd-2549-4464-8bef-8cb57adc8796');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('4ccc6c3e-0dcc-4a5b-8ae7-79619cf40b15', 'fa9667dd-2549-4464-8bef-8cb57adc8796');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('25aff87c-fa6f-411d-9a05-6584a8c12656', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('15de1118-7e55-4d2b-968a-22349e1b5b72', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('ee7fdcef-8980-44c0-ac47-e0cf0bf175dc', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('27f196c5-4b16-457d-bd36-27f64c57be7d', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('35a0a801-fe4d-4bfd-8479-24f88b60474a', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('74b6e62e-d8c3-4325-8a91-a0195c227155', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('9dcbc208-8189-440a-9e59-70502602e600', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('2ac3adc9-9d31-45cf-b30a-7b8c9adce32e', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('4e8b5514-b8da-4739-9816-5113a2968004', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('e8619a55-badc-4b41-911c-3e03396c0394', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('3a834293-9a93-4e05-92d9-d9e80d0b7a7f', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('fe08e3b7-c3c0-4306-97b2-3b470c7afbaa', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('0e4bdb96-a0d9-496c-a725-14f03ef730b9', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('4387cac5-2eb3-4bef-a084-d823db9f0256', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('2812bfdc-e7f4-43f4-b181-f87e58ed366f', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('0064cc3a-bf73-42b0-b60e-16e16bc2dd72', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('24264fa6-c177-414b-a7c8-758dedf1826f', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('1905f91c-f426-46ca-ba80-8e5d2d33790f', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');
INSERT INTO public.user_role_mapping (role_id, user_id) VALUES ('7de77c1d-6c2d-4c69-9bfc-2ab1f0d9da05', '3e4386c0-6580-4b79-b2ab-5021406d3cd6');


--
-- TOC entry 3895 (class 0 OID 16884)
-- Dependencies: 284
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3896 (class 0 OID 16891)
-- Dependencies: 285
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3897 (class 0 OID 16897)
-- Dependencies: 286
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3898 (class 0 OID 16903)
-- Dependencies: 287
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.web_origins (client_id, value) VALUES ('5b896a97-4553-4c23-bdd3-738d5fb06e6b', '+');
INSERT INTO public.web_origins (client_id, value) VALUES ('b41a94a8-63bc-4371-9a1d-59e02f446012', '+');


--
-- TOC entry 3608 (class 2606 OID 16907)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3462 (class 2606 OID 16909)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3349 (class 2606 OID 16911)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3364 (class 2606 OID 16913)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3351 (class 2606 OID 16915)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3497 (class 2606 OID 16917)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3339 (class 2606 OID 16919)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3383 (class 2606 OID 16921)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3389 (class 2606 OID 16923)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3385 (class 2606 OID 16925)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3426 (class 2606 OID 16927)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3408 (class 2606 OID 16929)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3411 (class 2606 OID 16931)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3418 (class 2606 OID 16933)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 16935)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3430 (class 2606 OID 16937)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3438 (class 2606 OID 16939)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3499 (class 2606 OID 16941)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3502 (class 2606 OID 16943)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3505 (class 2606 OID 16945)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3514 (class 2606 OID 16947)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3446 (class 2606 OID 16949)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3346 (class 2606 OID 16951)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3405 (class 2606 OID 16953)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3434 (class 2606 OID 16955)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3489 (class 2606 OID 16957)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3381 (class 2606 OID 16959)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3604 (class 2606 OID 16961)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3592 (class 2606 OID 16963)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3377 (class 2606 OID 16965)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3341 (class 2606 OID 16967)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3372 (class 2606 OID 16969)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3559 (class 2606 OID 16971)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3354 (class 2606 OID 16973)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3494 (class 2606 OID 16975)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3510 (class 2606 OID 16977)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3464 (class 2606 OID 16979)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 16981)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3337 (class 2606 OID 16983)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3327 (class 2606 OID 16985)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3331 (class 2606 OID 16987)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3334 (class 2606 OID 16989)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3375 (class 2606 OID 16991)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3601 (class 2606 OID 16993)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3392 (class 2606 OID 16995)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3379 (class 2606 OID 16997)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3451 (class 2606 OID 16999)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3481 (class 2606 OID 17001)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3512 (class 2606 OID 17003)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3396 (class 2606 OID 17005)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3584 (class 2606 OID 17007)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3535 (class 2606 OID 17009)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3544 (class 2606 OID 17011)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3539 (class 2606 OID 17013)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3324 (class 2606 OID 17015)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3527 (class 2606 OID 17017)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3549 (class 2606 OID 17019)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3530 (class 2606 OID 17021)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3562 (class 2606 OID 17023)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3577 (class 2606 OID 17025)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3590 (class 2606 OID 17027)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3586 (class 2606 OID 17029)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3416 (class 2606 OID 17031)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3574 (class 2606 OID 17033)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3569 (class 2606 OID 17035)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 17037)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3440 (class 2606 OID 17039)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3443 (class 2606 OID 17041)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3453 (class 2606 OID 17043)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3456 (class 2606 OID 17045)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3468 (class 2606 OID 17047)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3471 (class 2606 OID 17049)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3475 (class 2606 OID 17051)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3483 (class 2606 OID 17053)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3487 (class 2606 OID 17055)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3517 (class 2606 OID 17057)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3520 (class 2606 OID 17059)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3522 (class 2606 OID 17061)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3598 (class 2606 OID 17063)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3554 (class 2606 OID 17065)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3556 (class 2606 OID 17067)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3565 (class 2606 OID 17069)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3595 (class 2606 OID 17071)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3606 (class 2606 OID 17073)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3610 (class 2606 OID 17075)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3362 (class 2606 OID 17077)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3357 (class 2606 OID 17079)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3399 (class 2606 OID 17081)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3533 (class 2606 OID 17083)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3370 (class 2606 OID 17085)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3403 (class 2606 OID 17087)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3508 (class 2606 OID 17089)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3525 (class 2606 OID 17091)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3460 (class 2606 OID 17093)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3449 (class 2606 OID 17095)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3344 (class 2606 OID 17097)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3359 (class 2606 OID 17099)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3580 (class 2606 OID 17101)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3547 (class 2606 OID 17103)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3537 (class 2606 OID 17105)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3542 (class 2606 OID 17107)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3552 (class 2606 OID 17109)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3572 (class 2606 OID 17111)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3492 (class 2606 OID 17113)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3582 (class 2606 OID 17115)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3325 (class 1259 OID 17116)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3335 (class 1259 OID 17117)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3328 (class 1259 OID 17118)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3329 (class 1259 OID 17119)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3332 (class 1259 OID 17120)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3365 (class 1259 OID 17121)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3347 (class 1259 OID 17122)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3342 (class 1259 OID 17123)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3352 (class 1259 OID 17124)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3373 (class 1259 OID 17125)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3360 (class 1259 OID 17126)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3366 (class 1259 OID 17127)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3484 (class 1259 OID 17128)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3367 (class 1259 OID 17129)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3390 (class 1259 OID 17130)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3386 (class 1259 OID 17131)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3387 (class 1259 OID 17132)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3393 (class 1259 OID 17133)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3394 (class 1259 OID 17134)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3400 (class 1259 OID 17135)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3401 (class 1259 OID 17136)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3406 (class 1259 OID 17137)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3435 (class 1259 OID 17138)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3436 (class 1259 OID 17139)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3409 (class 1259 OID 17140)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3412 (class 1259 OID 17141)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3413 (class 1259 OID 17142)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3414 (class 1259 OID 17143)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3419 (class 1259 OID 17144)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3420 (class 1259 OID 17145)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3423 (class 1259 OID 17146)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3424 (class 1259 OID 17147)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3427 (class 1259 OID 17148)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3428 (class 1259 OID 17149)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3431 (class 1259 OID 17150)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3432 (class 1259 OID 17151)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3441 (class 1259 OID 17152)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3444 (class 1259 OID 17153)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3454 (class 1259 OID 17154)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3447 (class 1259 OID 17155)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3465 (class 1259 OID 17156)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3466 (class 1259 OID 17157)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3472 (class 1259 OID 17158)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3476 (class 1259 OID 17159)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3477 (class 1259 OID 17160)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3478 (class 1259 OID 17161)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3479 (class 1259 OID 17162)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3485 (class 1259 OID 17163)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3495 (class 1259 OID 17164)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3355 (class 1259 OID 17165)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3500 (class 1259 OID 17166)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3506 (class 1259 OID 17167)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3503 (class 1259 OID 17168)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3490 (class 1259 OID 17169)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3515 (class 1259 OID 17170)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3518 (class 1259 OID 17171)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3523 (class 1259 OID 17172)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3528 (class 1259 OID 17173)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3531 (class 1259 OID 17174)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3540 (class 1259 OID 17175)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3545 (class 1259 OID 17176)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3550 (class 1259 OID 17177)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3557 (class 1259 OID 17178)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3368 (class 1259 OID 17179)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3560 (class 1259 OID 17180)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3563 (class 1259 OID 17181)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3469 (class 1259 OID 17182)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3473 (class 1259 OID 17183)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3575 (class 1259 OID 17184)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3566 (class 1259 OID 17185)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3567 (class 1259 OID 17186)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3570 (class 1259 OID 17187)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3397 (class 1259 OID 17188)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3578 (class 1259 OID 17189)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3596 (class 1259 OID 17190)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3599 (class 1259 OID 17191)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3602 (class 1259 OID 17192)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3587 (class 1259 OID 17193)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3588 (class 1259 OID 17194)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3593 (class 1259 OID 17195)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3611 (class 1259 OID 17196)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3624 (class 2606 OID 17197)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3638 (class 2606 OID 17202)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3618 (class 2606 OID 17207)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3635 (class 2606 OID 17212)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3620 (class 2606 OID 17217)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3625 (class 2606 OID 17222)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3684 (class 2606 OID 17227)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3627 (class 2606 OID 17232)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3654 (class 2606 OID 17237)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3680 (class 2606 OID 17242)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3626 (class 2606 OID 17247)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3651 (class 2606 OID 17252)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3656 (class 2606 OID 17257)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3673 (class 2606 OID 17262)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3682 (class 2606 OID 17267)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3642 (class 2606 OID 17272)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3652 (class 2606 OID 17277)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3647 (class 2606 OID 17282)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3631 (class 2606 OID 17287)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3614 (class 2606 OID 17292)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3615 (class 2606 OID 17297)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3616 (class 2606 OID 17302)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3617 (class 2606 OID 17307)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3623 (class 2606 OID 17312)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3683 (class 2606 OID 17317)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3621 (class 2606 OID 17322)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3622 (class 2606 OID 17327)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3628 (class 2606 OID 17332)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3644 (class 2606 OID 17337)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3619 (class 2606 OID 17342)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3630 (class 2606 OID 17347)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3629 (class 2606 OID 17352)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3648 (class 2606 OID 17357)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3679 (class 2606 OID 17362)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3677 (class 2606 OID 17367)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3678 (class 2606 OID 17372)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3612 (class 2606 OID 17377)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3671 (class 2606 OID 17382)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3661 (class 2606 OID 17387)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3666 (class 2606 OID 17392)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3662 (class 2606 OID 17397)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3663 (class 2606 OID 17402)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3613 (class 2606 OID 17407)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3672 (class 2606 OID 17412)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3664 (class 2606 OID 17417)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3665 (class 2606 OID 17422)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3659 (class 2606 OID 17427)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3657 (class 2606 OID 17432)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3658 (class 2606 OID 17437)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3660 (class 2606 OID 17442)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3667 (class 2606 OID 17447)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3632 (class 2606 OID 17452)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3675 (class 2606 OID 17457)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3674 (class 2606 OID 17462)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3636 (class 2606 OID 17467)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3637 (class 2606 OID 17472)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3649 (class 2606 OID 17477)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3650 (class 2606 OID 17482)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3640 (class 2606 OID 17487)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3641 (class 2606 OID 17492)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3685 (class 2606 OID 17497)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3670 (class 2606 OID 17502)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3645 (class 2606 OID 17507)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3633 (class 2606 OID 17512)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3646 (class 2606 OID 17517)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3634 (class 2606 OID 17522)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3655 (class 2606 OID 17527)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3668 (class 2606 OID 17532)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3669 (class 2606 OID 17537)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3653 (class 2606 OID 17542)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3676 (class 2606 OID 17547)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3681 (class 2606 OID 17552)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3643 (class 2606 OID 17557)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3639 (class 2606 OID 17562)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);
