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

