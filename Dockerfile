FROM postgres:9.6

RUN apt install postgresql-common -y
RUN sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
RUN apt-get install postgresql-9.6-pglogical

CMD [ "postgres" ]