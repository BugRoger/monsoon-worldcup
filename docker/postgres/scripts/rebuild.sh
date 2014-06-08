docker stop postgres 
docker rm postgres
docker build -t postgres /monsoon-worldcup/docker/postgres
docker run -d -v /var/lib/postgres:/var/lib/postgres -e POSTGRESQL_USER=docker -e POSTGRESQL_PASS=docker --name postgres postgres:latest
