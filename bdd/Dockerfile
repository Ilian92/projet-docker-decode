FROM alpine:3.19

ENV PGDATA=/var/lib/postgresql/data
ENV POSTGRES_VERSION=15
# ENV POSTGRES_USER
# ENV POSTGRES_PASSWORD
# ENV POSTGRES_DB

RUN apk add --no-cache \
    postgresql${POSTGRES_VERSION} \
    postgresql${POSTGRES_VERSION}-contrib

RUN mkdir -p ${PGDATA} /run/postgresql /docker-entrypoint-initdb.d \
    && chown -R postgres:postgres ${PGDATA} /run/postgresql /docker-entrypoint-initdb.d \
    && chmod 700 ${PGDATA}

COPY init-scripts/*.sql /docker-entrypoint-initdb.d/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

USER postgres

EXPOSE 5432

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres", "-D", "/var/lib/postgresql/data"]
