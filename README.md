# Docker Image with HSQLDB for Software Development.

[![Circle CI](https://circleci.com/gh/blacklabelops/hsqldb/tree/master.svg?style=shield)](https://circleci.com/gh/blacklabelops/hsqldb/tree/master) [![Docker Stars](https://img.shields.io/docker/stars/blacklabelops/hsqldb.svg)](https://hub.docker.com/r/blacklabelops/hsqldb/) [![Docker Pulls](https://img.shields.io/docker/pulls/blacklabelops/hsqldb.svg)](https://hub.docker.com/r/blacklabelops/hsqldb/)
[![](https://badge.imagelayers.io/blacklabelops/hsqldb:latest.svg)](https://imagelayers.io/?images=blacklabelops/hsqldb:latest 'Get your own badge on imagelayers.io')

## Release: blacklabelops/hsqldb:latest

Leave a message and ask questions on Hipchat: [blacklabelops/hipchat](https://www.hipchat.com/geogBFvEM)

Installed Software:

  * Java 8
  * HSQLDB
  * SQLTool

# Make It Short

In short, use this image for starting and stopping a simple HSQLDB on your develeopment
environment.

~~~~
$ docker run -d -p 9001:9001 --name hsqldb blacklabelops/hsqldb
~~~~

> Will run hsqldb which will be accessible through jdbc URL: jdbc:hsqldb:hsql://localhost/test, Username: sa, Password :

Recommended: Docker-Compose! Just curl the files and modify the environment-variables inside
the .env-file.

~~~~
$ curl -O https://raw.githubusercontent.com/blacklabelops/hsqldb/master/docker-compose.yml
$ curl -O https://raw.githubusercontent.com/blacklabelops/hsqldb/master/docker-compose.env
$ docker-compose up -d
~~~~

> [docker-compose.env](https://github.com/blacklabelops/hsqldb/blob/master/docker-compose.env) contains a full list of environment variables.

# Connect to HSQLDB

The following commands copy the UI-Binaries out of the running container and starts the UI locally:

~~~~
$ docker cp hsqldb:/opt/hsqldb/hsqldb.jar .
$ java -jar hsqldb.jar
~~~~

> Needs local installation of a Java-JRE!

Inside the UI select "HSQL Database Engine Server" and enter the JDBC URL: jdbc:hsqldb:hsql://localhost/test

> Note: When you use boot2docker then enter the ip of your VM instead of 'localhost'!

# Use the SQLTool Client

SQLTool is a command line client for HSQL: [Documentation](http://hsqldb.org/doc/2.0/util-guide/sqltool-chapt.html)

## Connect SQLTool from container

Simply start a connected cli by typing:

~~~~
$ docker exec -it hsqldb bash -c "java -jar /opt/hsqldb/sqltool.jar db"
~~~~

If you want to mount your script directory, then start a new container:

~~~~
$ docker run -it --rm \
  --link hsqldb:hsqldb \
	-v $(pwd)/dbscripts:/scripts \
	blacklabelops/hsqldb sqltool
~~~~

> The folder /scripts is a Volume with the appropriate user permissions.

## Connect SQLTool from your Host

Boot2Docker: First start the server with the host environment variable:

~~~~
$ docker run -d --name hsqldb \
	-e "HSQLDB_DATABASE_HOST=192.168.99.100" \
	-p 9001:9001 \
	blacklabelops/hsqldb
~~~~

> The sqltool settings sqltool.rc will now include the correct host.

Execute SQLTool on your host:

~~~~
# Copy the binaries to your host
$ docker cp hsqldb:/opt/hsqldb .
# Copy settings.rc to your home directory
$ cp ./hsqldb/sqltool.rc ~
# Start sql tool
$ java -jar ./hsqldb/sqltool.jar test
~~~~

# Set Username and Password

You can specify the Username and Password with the environment variables HSQLDB_USER and HSQLDB_PASSWORD.

Example:

~~~~
$ docker run -d --name hsqldb \
	-e "HSQLDB_USER=sa" \
  -e "HSQLDB_PASSWORD=password" \
	-p 9001:9001 \
	blacklabelops/hsqldb
~~~~

> Default container user is 'sa' and empty password!

# Set the Database alias

You can adjust the Database Alias with the environment variable: HSQLDB_DATABASE_ALIAS

This will change the JDBC URL you will have to use!

Example:

~~~~
$ docker run -d --name hsqldb \
	-e "HSQLDB_DATABASE_ALIAS=xdb" \
	-p 9001:9001 \
	blacklabelops/hsqldb
~~~~

> The correct JDBC URL is now: jdbc:hsqldb:hsql://localhost/xdb

# Set the Database Name

You can specify the Database Name with the environment variable HSQLDB_DATABASE_NAME

Example:

~~~~
$ docker run -d --name hsqldb \
	-e "HSQLDB_DATABASE_NAME=hsqldb" \
	-p 9001:9001 \
	blacklabelops/hsqldb
~~~~

> Database hsqldb will be available in folder /opt/database

# Mount the Database Files Externally

The database files are inside the volume /opt/database and can be mounted.

Example:

~~~~
$ docker run -d --name hsqldb \
	-v $(pwd)/database:/opt/database \
	-p 9001:9001 \
	blacklabelops/hsqldb
~~~~

> pwd is a Linux directive!

# Additional HSQLDB Parameters

This container supports the following additional settings:

* Disable HSQL Trace Modus (do not display JDBC trace messages): HSQLDB_TRACE="false"
* Enable HSQL Silent Mode (true => do not display all queries): HSQLDB_SILENT="true"
* Disable HSQL Remote Connections (can open databases remotely): HSQLDB_REMOTE="false"
* Set HSQL Database Host (for sqltool.rc): HSQLDB_DATABASE_HOST="192.168.99.100"

Example:

~~~~
$ docker run -d --name hsqldb \
  -e "HSQLDB_TRACE=false" \
  -e "HSQLDB_SILENT=true" \
  -e "HSQLDB_REMOTE=false" \
  -e "HSQLDB_DATABASE_HOST=192.168.99.100" \
  -p 9001:9001 \
  blacklabelops/hsqldb
~~~~

# Java-VM Parameters

You can define start up parameters for the Java Virtual Machine, e.g. setting the memory size.

~~~~
$ docker run -d --name hsqldb \
	-e "JAVA_VM_PARAMETERS=-Xmx512m -Xms256m" \
	-p 9001:9001 \
	blacklabelops/hsqldb
~~~~

> You will have to use Java 8 parameters: [JRE 8 Linux](http://docs.oracle.com/javase/8/docs/technotes/tools/unix/java.html).

## References

* [HSQLDB](http://hsqldb.org/)
* [Docker Homepage](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker Userguide](https://docs.docker.com/userguide/)
* [Oracle Java8](https://java.com/de/download/)
