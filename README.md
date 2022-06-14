# Clean Administration Platform

A platform created to enhance the users, both students and demonstrators, experience in orchastrating the *Functional Programming Course* being taught at the University of *Eotvos Lorand*, in which *Clean Programming Language* is used.

This repository holds all the components required to deploy the project. They are explained individually in their corresponding *Readme* files. Yet, a breif overview is given below.

---
## Deploy and Build
First of all, make sure to have both *docker* and *docker-compose* installed on your machine. *Docker* is used to build simple virtualized microservices and encapsulates them in a so-called *images* (Which are deployed as *containers*), while *docker-compose* ease the process of creating a single network comprising the project microservices, thus, acting as a premise. Furthermore, *node* and *npm* are primary to download the required modules and build the project. 

The project can be deployed on a *Windows Operating System*, however, the deployer would have to go through the process of porting. However, for *Linux* machines and subsystems, the project can be built and/or deployed easily through running the given shell script at the root of the repository (`./platform_build_deploy.sh`). The script takes extra arguments to define its behavior. Executing `./platform_build_deploy.sh` alone shows the arguments and their behaviours (*Build Only*, *Deploy Only*, *Build and Deploy*).

If all the aforementioned pre-requisites are installed correctly, the project will be built and/or deployed. If an error occurs, mostly there are some missing utilities (e.g *docker*). To check if the project is running correctly, type `docker-compose -f docker-compose-local.yml ps`. The previous command shows all the container and their status.

---

## Components Relationship
As said, a single image may describe a thousand words. The following figure shows the connection between all the components provided within a successfull deployment:

![Components Relationship](https://user-images.githubusercontent.com/48254077/173631223-57d96103-598c-4e5d-98c0-925c85a0c753.png)


As depicted, a user may use the exposed backen api and frontend services through any client device. The frontend server renders the required pages to the client. Then, the client rendered pages may use the exposed backend api. Any request undergoes a load balancing stage (by *nginx*) before entering the premise. Finally, the backend api authenticate and authorize the user based on its connection cookie, thus, any third party application can harness the backend api if, and only if, it can manage its cookies (Browser such as Chrome) and is permitted to access the backend api.

The authentication process happens within the *Keycloak* server. It may only be accessed by maintainers, and intranet (inner network) users. Maintainers may change the credentials and manage the roles of the users if manual assessement is needed.

Maintainers also have the ability to view the database and its components through the *PGadmin* platform. It is similar in a sense to *PhpMyAdmin* platform. This platform is provided since mainteners might be required to edit the database entries manually in extra-ordinary cases.

## User Manual

Users (e.g *Students*, *Instructors*) might be able to see the loaded frontend pages and use them to orchestrate the course. 
