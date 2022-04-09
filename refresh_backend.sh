docker-compose -f docker-compose-local.yml rm -s -f backend;
cd backend;
./build.sh;
cd ..;
docker-compose -f docker-compose-local.yml up -d;