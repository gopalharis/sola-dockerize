#!/bin/bash
docker run -p 5444:5444 -e PGPORT=5444 -d --name sola-db aequalis/sola-db:1.0
sleep 15
docker exec sola-db sh create_database.sh
