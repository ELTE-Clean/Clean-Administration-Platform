#! /bin/sh

# This file is used to setup the environment variables of the container before running the entrypoint.sh withen the container.
echo "Setting up the environment varaibles ......";
export PGADMIN_DEFAULT_EMAIL=admin@admin.com;
export PGADMIN_DEFAULT_PASSWORD=admin;

echo "Default username of the container: $PGADMIN_DEFAULT_EMAIL";
echo "Default password of the container: $PGADMIN_DEFAULT_PASSWORD";

echo "Firing up the pgadmin4 container ......";
exec /entrypoint.sh