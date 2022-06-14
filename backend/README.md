# Backend Component

The backend runs an [express.js](https://expressjs.com/) server, which is a fast, unopinionated, minimalist web framework for [node](https://nodejs.org/en/). It exposes a wide variety of endpoints to manipulate the internal data, thus, can be used as a REST API. Third party applications may use the backend API, yet they must be authorized and able to store cookie informations returned by the backend.

## Getting Started

First, build the backend server:

```bash
./build.sh
or
sh build.sh
```

The backend is dependent on the other components to run correctly, so it has to be deployed in the same environment using Docker. In the root of the project, run:

```bash
docker-compose -f docker-compose-local.yml up -d
```

Open [http://localhost:5000](http://localhost:5000) with your browser to see Nginx running.

## Disable Endpoint Protection

All of the API endpoints are protected by default, to disable them go to env/backend.env and set DISABLE_AUTHORIZATION and DISABLE_AUTHENTICATION to true as such:

```bash
DISABLE_AUTHORIZATION=true
DISABLE_AUTHENTICATION=true
```

Then rebuild and redeploy the backend.

You should be able to access all GET endpoints from the browser such as:

- [http://localhost:5000/tasks](http://localhost:5000/tasks)
- [http://localhost:5000/sections](http://localhost:5000/sections)

## Learn More

To learn more about Express.js, take a look at the following resources:

- [Express.js Documentation](https://expressjs.com/en/4x/api.html) - learn about Express.js features and API.
- [Learn Express.js](https://expressjs.com/en/starter/hello-world.html) - an Express.js "Hello world" tutorial.
