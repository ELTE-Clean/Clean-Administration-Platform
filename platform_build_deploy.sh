#! /bin/sh


if [ $# -ne 1 ] || [ $1 -gt 2 ]
then
    echo "ERROR: "
    echo "  Please specify a building option as an argument."
    echo "      0 : For building and deploying the project";
    echo "      1 : For building the project only.";
    echo "      2 : For deploying the project only.";
    exit;
fi;


# Building the images
if [ $1 -ne 2 ]
then
    # Building the backend
    echo "Building the express backend...";
    cd backend;
    npm install;
    npm run build;
    cd dist;
    npm install --only=production
    docker build . -t backend:latest;
    if [ $? -ne 0 ]
    then 
        echo "Failed to build the image... Exitting with code $?";
        exit;
    fi;
    cd ..;
    cd ..;

    echo "----------------------------------------------------------------------------------- ";

    # Building the frontend
    echo "Building the react frontend...";
    cd frontend;
    docker build . -t frontend:latest;
    if [ $? -ne 0 ]
    then 
        echo "Failed to build the image... Exitting with code $?";
        exit;
    fi;
    cd ..;

    echo "----------------------------------------------------------------------------------- ";

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
fi;


if [ $1 -ne 1 ]
then
    echo "Shutting down the old deployment...";
    docker-compose -f docker-compose-local.yml down --remove-orphans;
    echo "Deploying the project locally...";
    docker-compose -f docker-compose-local.yml up -d --force-recreate;
    echo "Project has been deployed by running the docker-compose on the docker-compose-local.yml file.";
fi;
