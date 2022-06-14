# Clean Administration Platform

A platform created to enhance the users, both students and demonstrators, experience in orchastrating the *Functional Programming Course* being taught at the University of *Eötvös Loránd*, in which *Clean Programming Language* is used.

This repository holds all the components required to deploy the project. They are explained individually in their corresponding *README* files. Yet, a breif overview is given below.

---

## Technology

### Front-End:
 - Next.js
 - React.js
 - Typescript

### Back-End:
 - Express.js
 - PostgreSQL
 - Keycloak

### Environment:
 - Linux Machine
 - Nginx Server
 - Docker

### Automation:
 - Python

---

## Setup Application

>### Windows Prerequisite

In the end, a Linux environment is needed. If you are already using Linux, you can skip this subsection. Windows 10 version 1903 or higher or Windows 11 is needed to continue.

To run the app in a Windows machine, firstly 2 things are needed: Windows Subsystem for Linux (WSL) and Docker Desktop installed with WSL 2 backend. The easy way to install a WSL is to go to Microsoft Store and download Ubuntu 20.04 LTS (or higher). If you are more tech savvy, follow the [Microsoft documentation](https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-3---enable-virtual-machine-feature). To install Docker Desktop with WSL 2 backend, a complete guide can be found [here](https://docs.docker.com/desktop/windows/wsl/).

Once these are installed, you can continue with the Build and Deploy section, the only difference being that *docker* and *docker-compose* will already be installed on your machine.

>### Build and Deploy

First of all, make sure to have both *docker* and *docker-compose* installed on your machine. *Docker* is used to build simple virtualized microservices and encapsulates them in a so-called *images* (Which are deployed as *containers*), while *docker-compose* eases the process of creating a single network comprising the project microservices, thus, acting as a premise. Furthermore, *node* and *npm* are needed to download the required modules and build the project. 

The project can be deployed on a *Windows Operating System*, however, the deployer would have to go through the process of porting. However, for *Linux* machines and subsystems, the project can be built and/or deployed easily through running the given shell script at the root of the repository (`./platform_build_deploy.sh`). The script takes extra arguments to define its behavior. Executing `./platform_build_deploy.sh` alone shows the arguments and their behaviours (*Build Only*, *Deploy Only*, *Build and Deploy*).

If all of the aforementioned pre-requisites are installed correctly, the project will be built and/or deployed. If an error occurs, mostly there are some missing utilities (e.g *docker*). To check if the project is running correctly, type `docker-compose -f docker-compose-local.yml ps`. The previous command shows all the container and their status.

---

## Components Relationship
As said, a single image may describe a thousand words. The following figure shows the connection between all the components provided within a successfull deployment:

![Components Relationship](https://user-images.githubusercontent.com/48254077/173631223-57d96103-598c-4e5d-98c0-925c85a0c753.png)

As depicted, a user may use the exposed backen API and frontend services through any client device. The frontend server renders the required pages to the client. Then, the client rendered pages may use the exposed backend API. Any request undergoes a load balancing stage (by *nginx*) before entering the premise. Finally, the backend API authenticate and authorize the user based on its connection cookie, thus, any third party application can harness the backend API if, and only if, it can manage its cookies (Browser such as Chrome) and is permitted to access the backend API.

The authentication process happens within the *Keycloak* server. It may only be accessed by maintainers, and intranet (inner network) users. Maintainers may change the credentials and manage the roles of the users if manual assessement is needed.

Maintainers also have the ability to view the database and its components through the *pgAdmin* platform. It is similar to the *PhpMyAdmin* platform. This platform is provided for mainteners might be required to edit the database entries manually in extra-ordinary cases.

---

## User Manual

Users (e.g *Students*, *Instructors*) are able to see the loaded frontend pages and use them to orchestrate the course. 
