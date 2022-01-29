docker-compose -f docker-compose-local.yml down;
docker rm -f $(docker ps -a -q);
docker volume rm $(docker volume ls -q);