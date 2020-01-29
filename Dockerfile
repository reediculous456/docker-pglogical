FROM postgres:10

RUN apt install postgresql-common -y
RUN sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
RUN apt-get install postgresql-10-pglogical

RUN echo "host    replication          postgres                172.18.0.0/16   trust" >> /usr/share/postgresql/10/pg_hba.conf.sample
RUN echo "host    replication          postgres                ::1/128         trust" >> /usr/share/postgresql/10/pg_hba.conf.sample

RUN echo "wal_level = 'logical'" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_worker_processes = 10" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_replication_slots = 10" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "max_wal_senders = 10" >> /usr/share/postgresql/postgresql.conf.sample
RUN echo "shared_preload_libraries = 'pglogical'" >> /usr/share/postgresql/postgresql.conf.sample

CMD [ "postgres" ]
