# Database component

The database is powered by PostgreSQL and contains 2 databases: auth_db and clean_db.

The auth_db database is used by keycloak to store all of its necessary information and should not be touched directly. Instead, the Keycloak UI and API should be used.

The clean_db database is used and designed by us to store website and user data. You can view the tables either through the pgadmin web UI or by accessing the cleanDB container directly. 

Commands needed to get to the tables in the container:
```
docker exec -it clean-administration-platform_cleanDB_1 bin/sh
psql -U postgres
(enter password "postgres" when prompted)
\c clean_db
```
From here execute ```\dt``` to see a table of all tables and ```select * from <table_name>;``` to see a table's contents.

## Roles

In the database, there exists keycloaker and demonstrator roles which only have access to auth_db and clean_db respectively. They have full privileges within their databases.

Example:
```
psql -U keycloaker -d auth_db
psql -U demonstrator -d clean_db
```

## Clean Database Architecture

![cleanDB diag drawio (3)](https://user-images.githubusercontent.com/80112646/173668399-af16720c-ad58-41b2-b9ac-c5f01c4a9c50.png)
