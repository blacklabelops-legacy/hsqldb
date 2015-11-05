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

> Will run hsqldb which will be accessible through jdbc URL: jdbc:hsqldb:hsql://localhost/xdb, Username: sa, Password :

## References

* [HSQLDB](http://hsqldb.org/)
* [Docker Homepage](https://www.docker.com/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Docker Userguide](https://docs.docker.com/userguide/)
* [Oracle Java8](https://java.com/de/download/)
