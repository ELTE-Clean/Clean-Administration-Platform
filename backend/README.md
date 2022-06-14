# Backend Component

The backend runs an [express.js](https://expressjs.com/) server, which is a fast, unopinionated, minimalist web framework for [node](https://nodejs.org/en/).

## Getting Started

First, build the backend server:

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

The structure of the backend is distributed into multiple modules, each handling a specific mission. The server initialization starts from the `./server.js`. The server encapsulates multiple routes in which the endpoints are defined in. The routes directory `./routes` contain all the endpoint definitions, each defined its mission by the file name.

## Learn More

To learn more about Express.js, take a look at the following resources:

- [Express.js Documentation](https://expressjs.com/en/4x/api.html) - learn about Express.js features and API.
- [Learn Express.js](https://expressjs.com/en/starter/hello-world.html) - an Express.js "Hello world" tutorial.
