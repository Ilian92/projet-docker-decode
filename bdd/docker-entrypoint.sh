#!/bin/sh
set -e

if [ ! -s "${PGDATA}/PG_VERSION" ]; then
    echo "Initializing PostgreSQL database..."
    initdb -D ${PGDATA}
    
    echo "host all all 0.0.0.0/0 md5" >> ${PGDATA}/pg_hba.conf
    echo "listen_addresses='*'" >> ${PGDATA}/postgresql.conf
fi

echo "Starting PostgreSQL..."
pg_ctl -D ${PGDATA} -w start

if [ ! -f ${PGDATA}/.initialized ]; then
    echo "Creating database and user..."
    psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
        CREATE DATABASE ${POSTGRES_DB};
        CREATE USER ${POSTGRES_USER} WITH PASSWORD '${POSTGRES_PASSWORD}';
        GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_USER};
EOSQL

    echo "Running initialization scripts..."
    for f in /docker-entrypoint-initdb.d/*.sql; do
        if [ -f "$f" ]; then
            echo "Executing $f..."
            psql -v ON_ERROR_STOP=1 --username ${POSTGRES_USER} --dbname ${POSTGRES_DB} -f "$f"
        fi
    done
    
    touch ${PGDATA}/.initialized
    echo "Database initialized successfully!"
fi

pg_ctl -D ${PGDATA} stop

exec postgres -D ${PGDATA}
