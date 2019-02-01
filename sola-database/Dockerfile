FROM postgres

ENV PGPORT 5444

WORKDIR /sola-db
COPY ./ /sola-db/
RUN apt-get update && apt-get install postgis -y && apt-get install p7zip-full -y
