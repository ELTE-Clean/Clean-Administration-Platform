# cpgAdmin Component

Maintainers have the ability to view the database and its components through the *cpgAdmin* platform which encapsulates the *pgAdmin* image but with custom configuration. The *pgAdmin* third party UI interface enables the manipulation of any database that it is connected to. In our implementation, it has only 1 postgresql server with 2 databases (auth_db and clean_db -more on these in the cleanDB-). This platform is provided for mainteners when it is required to edit the database entries manually in extra-ordinary cases. See/Change the `env` and `config` to learn more about the credentials required for logging in and such. However, the default configurations are used. 

To login into the platform, you can use the default configuration:
```
username: admin@admin.com
password: admin
```
and to connect to the postgres server, `postgres` is used as a password.


## Build
This platform requires no building process, only a docker image must be generated. To generate a docker image, run the following command:
```
docker build . -t cpgadmin:latest
```
The docker uses the setup.sh to initialize the server with the given configuration defined in the `config` folder.
