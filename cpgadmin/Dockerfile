# dump build stage
FROM dpage/pgadmin4:latest

# For copying the servers.json (Initialize preconfigured connections to databases servers.)
COPY ./config/servers.json /pgadmin4/servers.json       

# servers.json connections require passwords. And these are being copied here. Though it does not work for somereason.
COPY ./config/pgpass /passes/postgres_pass 

# Container pre configuration.
COPY ./setup.sh /setup.sh

# Setup will run the entry point at the end of the setup.
# USER root
# RUN chmod 777 /setup.sh

# The setup calls the entrypoint of the image and builds it. It is used to preconfigure some stuff such as the environment variables.
ENTRYPOINT ["/bin/sh", "/setup.sh"];