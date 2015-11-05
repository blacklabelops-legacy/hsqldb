Docker container with HSQLDB for Software Development.

Installed Software:

  * Java 8
  * HSQLDB

# Make It Short

In short, use this container for starting and stopping a simple HSQLDB on your develeopment
environment.

~~~~
$ docker run -d -p 9001:9001 --name hsqldb blacklabelops/hsqldb
~~~~

> Will run hsqldb which will be accessible through jdbc URL: jdbc:hsqldb:hsql://localhost/test, Username: sa, Password :

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

SQLTool is a command line client for SQL, default is HSQL.

Execute SQLTool on your host:

~~~~
$ docker cp hsqldb:/opt/sqltool/ .
$ java -jar ./sqltool/sqltool.jar --inlineRc=url=jdbc:hsqldb:hsql://localhost/test,user=sa
~~~~

> Note: There seems to be a bug in sqltool, hope this will be fixed in later versions...

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
* Set HSQL Database Host (server inet address): HSQLDB_DATABASE_HOST="192.168.99.100"

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
