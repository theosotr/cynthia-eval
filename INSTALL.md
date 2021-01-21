To get the artifact, run

```bash
git clone --recursive https://github.com/theosotr/cynthia-eval ~/cynthia-eval
```


## Install Docker Images

We provide a `Dockerfile` to build images that contain:

* An installation of Scala and JDK 11.
* An installation of Node.js (version 14.15)
* An installation of Ruby (version 2.5).
* An installation of the [Z3 theorem prover](https://github.com/Z3Prover/z3),
  being built with Java bindings.
* An intallation of `Cynthia`.
* An installation of the five ORMs examined in our evaluation:
    * [Django](https://www.djangoproject.com/)
    * [SQLAlchemy](https://www.sqlalchemy.org/)
    * [peewee](http://docs.peewee-orm.com/en/latest/)
    * [Sequelize](https://sequelize.org/)
    * [ActiveRecord](https://guides.rubyonrails.org/active_record_basics.html)
* An installation of the four database systems on which
  we run the generated ORM queries:
    * [SQLite](https://www.sqlite.org/index.html)
    * [MySQL](https://www.mysql.com/)
    * [PostgreSQL](https://www.postgresql.org/)
    * [SQL Server](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
* A user named `cynthia` with sudo privileges.


### Build Images from Source

**NOTE**:
If you do not want build the images on your own,
there is a quicker way to install the artifact.
Please skip this step and proceed to the
next section ("Pull Images from Dockerhub")

First enter the `cynthia/` directory

```bash
cd cynthia
```

To build the first image (named `cynthia`), run the following command
(estimated running time: 30 minutes - 1 hour)

```
docker build -t cynthia --no-cache .
```

**NOTE:**
The image is built upon `ubuntu:18.04`.

After building the Docker image successfully,
please navigate to the root directory of the artifact


```bash
cd ~/cynthia-eval
```


### Pull Image from Dockerhub

You can also download the Docker image from Dockerhub by using the
following commands


```bash
docker pull theosotr/cynthia
# Rename the image to be consistent with our scripts
docker tag theosotr/cynthia cynthia
```

After downloading the Docker image successfully,
please navigate to the root directory of the artifact


```bash
cd ~/cynthia-eval
```
