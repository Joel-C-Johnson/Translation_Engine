CREATE TABLE roles (
	id BIGSERIAL PRIMARY KEY,
	name TEXT UNIQUE NOT NULL
);

INSERT INTO roles (name) VALUES ('superadmin');
INSERT INTO roles (name) VALUES ('admin');
INSERT INTO roles (name) VALUES ('member');

CREATE TABLE users (
	id BIGSERIAL PRIMARY KEY,
	email TEXT UNIQUE NOT NULL,
	email_verified BOOLEAN DEFAULT FALSE,
	verification_code TEXT UNIQUE,
	password_hash BYTEA UNIQUE NOT NULL,
	password_salt BYTEA UNIQUE NOT NULL,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	role_id BIGINT REFERENCES roles(id) DEFAULT 3
);

CREATE TABLE keys (
	id BIGSERIAL PRIMARY KEY,
	access_id TEXT UNIQUE NOT NULL,
	key_hash BYTEA UNIQUE NOT NULL,
	key_salt BYTEA UNIQUE NOT NULL,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	user_id BIGINT REFERENCES users(id) NOT NULL
);


CREATE TABLE other_sources (
	id BIGSERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	language TEXT NOT NULL,
	file BYTEA,
	file_type TEXT NOT NULL,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone
);

CREATE TABLE other_tokens (
	id BIGSERIAL PRIMARY KEY,
	name TEXT,
	tokens TEXT,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	source_id BIGINT REFERENCES sources(id) NOT NULL
);

CREATE TABLE other_tokentranslations (
	id BIGSERIAL PRIMARY KEY,
	token TEXT NOT NULL,
	translated_token TEXT,
	targetlang TEXT,
	created_at timestamp with time zone,
	updated_at timestamp with time zone,
	deleted_at timestamp with time zone,
	source_id BIGINT REFERENCES sources(id) NOT NULL
);

