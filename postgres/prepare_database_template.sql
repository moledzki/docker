ALTER SCHEMA public OWNER TO $POSTGRESQL_USER;
CREATE EXTENSION IF NOT EXISTS ltree SCHEMA pg_catalog VERSION '1.0';
CREATE EXTENSION IF NOT EXISTS pg_trgm SCHEMA pg_catalog VERSION '1.0;
