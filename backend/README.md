# Backend Component

The backend is a REST API component that runs an [express.js](https://expressjs.com/) server, which is a fast, unopinionated, minimalist web framework for [node](https://nodejs.org/en/). The API can be accessed via any frontend interface, yet the frontend has to be hosted on a browser like software since it stores cookies and handles setting up the cookies automatically. 

## Requirements
The backend component relies heavily on the keycloak and postgresql databases. Keycloak is used as an authentication server, while postgresql database holds the data of the application.

## Getting Started

First, make sure that nodejs and docker are installed then build the backend server:

```bash
./build.sh
or
sh build.sh
```

The building will create a new *docker* image which encapsulates the backend. Furthermore, the backend is dependent on the other components to run correctly, thus it has to be deployed in the same environment (network). Fortunately, *docker-compose* helps with the creation process. So, in the root of the project, run:

```bash
docker-compose -f docker-compose-local.yml up -d
```

Open [http://localhost:5000](http://localhost:5000) with your browser to see Nginx running. Lots of variable can be changed to change the setup of the backend. For instance the port of the container can be changed from the docker-compose configuration file (e.g docker-compose-local.yml).

## Disable Endpoint Protection

All of the API endpoints are protected by default through authorization layers, to disable them go to env/backend.env and set DISABLE_AUTHORIZATION and DISABLE_AUTHENTICATION to true as such:

```bash
DISABLE_AUTHORIZATION=true
DISABLE_AUTHENTICATION=true
```

Then rebuild and redeploy the backend. This deployment might be used for debugging or prototype-endpoint development.

You should be able to access all GET endpoints from the browser such as:

- [http://localhost:5000/tasks](http://localhost:5000/tasks)
- [http://localhost:5000/sections](http://localhost:5000/sections)

## Files Distribution

The structure of the backend is distributed into multiple modules, each handling a specific mission. 
* The server initialization starts from the `./server.js`. 
* The server encapsulates multiple routes in which the endpoints are defined in. The routes directory `./routes` contain all the endpoint definitions. 
* `./middlewares` folder encapsulates all custom made middlewares (Cors handling and such). Express endpoints uses these middlewares in all the routes.
* `./utils` holds all the functions that allow the component to communicate with the keycloak and database servers. Moreover, it holds extra utilities which handles logging for instance.

## Learn More

To learn more about Express.js, take a look at the following resources:

- [Express.js Documentation](https://expressjs.com/en/4x/api.html) - learn about Express.js features and API.
- [Learn Express.js](https://expressjs.com/en/starter/hello-world.html) - an Express.js "Hello world" tutorial.
