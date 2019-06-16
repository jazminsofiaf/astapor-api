DROP ROLE IF EXISTS astapor;
CREATE ROLE astapor WITH LOGIN PASSWORD 'astapor'  CREATEDB;

CREATE DATABASE astapor_development;
CREATE DATABASE astapor_test;

GRANT ALL PRIVILEGES ON DATABASE "astapor_development" to astapor;
GRANT ALL PRIVILEGES ON DATABASE "astapor_test" to astapor;
