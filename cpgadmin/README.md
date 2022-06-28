# pgAdmin Component

Maintainers have the ability to view the database and its components through the *pgAdmin* platform. This third party UI interface enables the manipulation of any database that it is connected to. By default, it has only 1 server with 2 databases (auth_db and clean_db -more on these in the cleanDB-). This platform is provided for mainteners when it is required to edit the database entries manually in extra-ordinary cases. See/Change the `env` and `config` to learn more about the credentials required for logging in and such. However, the default configurations are used. 

To login into the platform, you can use the default configuration:
```
username: admin@admin.com
password: admin
```
and to connect to the postgres server, `postgres` is used as a password.
