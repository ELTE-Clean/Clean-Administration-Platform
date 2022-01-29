#! /bin/sh


if [ $# -eq 0 ]
then
    echo "ERROR: "
    echo "  Please specify a building option as an argument."
    echo "      0 : For building and deploying the project";
    echo "      N : For building the project only. (Call the script with any number)";
    exit;
fi;


# Building the clean database
echo "Building the cleanDB powered by postgres...";
cd cleanDB;
docker build . -t cleandb:latest;
if [ $? -ne 0 ]
then 
    echo "Failed to build the image... Exitting with code $?";
    exit;
fi;
cd ..;

echo "----------------------------------------------------------------------------------- ";

# Building the cpgadmin
echo "Building the clean pgadmin...";
cd cpgadmin;
docker build . -t cpgadmin:latest;
if [ $? -ne 0 ]
then 
    echo "Failed to build the image... Exitting with code $?";
    exit;
fi;
cd ..;

echo "----------------------------------------------------------------------------------- ";

# Final step to make your "docker images" command outputs pretty stuff. 
echo "Deleting all <none> images in docker...";
docker images | grep "<none>" | awk '{ print $3; }' | xargs docker rmi -f; # cleaning the docker junk docker images.

echo "----------------------------------------------------------------------------------- ";


if [ $1 -eq 0 ]
then
    echo "Deploying the project locally...";
    docker-compose -f docker-compose-local.yml up -d --force-recreate;
    echo "Project has been deployed by running the docker-compose on the docker-compose-local.yml file.";
fi;
