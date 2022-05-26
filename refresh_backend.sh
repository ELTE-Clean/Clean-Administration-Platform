docker-compose -f docker-compose-local.yml rm -s -f backend;
cd backend;
./buil--- d.sh;
cd ..;
docker-compose -f docker-compose-local.yml up -d;