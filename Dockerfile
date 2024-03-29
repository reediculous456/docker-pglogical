ARG POSTGRESQL_MAJOR_VERSION=12
FROM postgres:${POSTGRESQL_MAJOR_VERSION}

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y postgresql-common && \
    sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y && \
    apt-get install --no-install-recommends -y postgresql-${PG_MAJOR}-pglogical && \
    rm -rf /var/lib/apt/lists/*

RUN echo "wal_level = 'logical'" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "max_worker_processes = 10" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "max_replication_slots = 10" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "max_wal_senders = 10" >> /usr/share/postgresql/postgresql.conf.sample && \
    echo "shared_preload_libraries = 'pglogical'" >> /usr/share/postgresql/postgresql.conf.sample

RUN echo "host    replication          postgres                172.18.0.0/16   trust" >> /usr/share/postgresql/${PG_MAJOR}/pg_hba.conf.sample && \
    echo "host    replication          postgres                ::1/128         trust" >> /usr/share/postgresql/${PG_MAJOR}/pg_hba.conf.sample
