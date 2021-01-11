Artifact for "Data-Oriented Differential Testing of Object-Relational Mapping Systems" (ICSE'21)
===============================================================================

This is the artifact for the ICSE'21 paper titled
"Data-Oriented Differential Testing of Object Relational Mapping Systems".

An archived version of the artifact
is also available on Zenodo. #TODO.


Requirements
============

* A Unix-like operating system (tested on Ubuntu)

* A Docker installation

* At least 3GB of available disk space

Setup
=====

To get the artifact, run

```bash
git clone --recursive https://github.com/theosotr/cynthia-eval ~/cynthia-eval
```

## Overview

The artifact contains the instructions and scripts to re-run the evaluation
described in our paper. The artifact has the following structure:

* `scripts/`:
  This is the directory that contains the scripts needed to
  re-run the experiments presented in our paper.
* `bugs/bug_schema.sql`:
  This is the database schema that contains the bugs discovered
  by our approach.
* `bugs/bugdb.sqlite3`:
  This is the `sqlite3` database file corresponding to the schema defined
  in `bugs/bug_schema.sql`.
* `example_bugs/`:
  Contains the AQL queries that trigger the two ORM bugs demonstrated in
  Section 2 of our paper.
* `cynthia/`: Contains the source code of the tool (provided as a git submodule)
    used in our paper for testing the implementations of ORMs,
    namely `Cynthia`.

Note that `Cynthia` is available as open-source software under
the GNU General Public License v3.0., and can also be reached
through the following Repository : https://github.com/theosotr/cynthia.

Inside the `cynthia` directory, there are the following directories

* `src/`: The source code of `Cynthia` written in Scala.
* `scripts/`: Some helper scripts for running `Cynthia` or setting up the
  environment via Docker.
* `examples/`: Contains examples for getting started with Cynthia.
* `lib/`: Contains external libraries used by `Cynthia`.
* `project/`: Contains configuration associated with `sbt`,
* the build system used to build `Cynthia`.
* `patches/`: Contains patches that make the `peewee` ORM compatible
  with `Cynthia`.
* `entrypoint/`: Contains the entrypoint script of
  the corresponding Docker image.


## Install Docker Images

We provide a `Dockerfile` to build images that contain:

* An installation of Scala and JDK 11.
* An installation of Node.js
* An installation of Ruby.
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
If you do not want build the images on your own, please skip this step
and proceed to the next section ("Pull Images from Dockerhub")

To build the first image (named `cynthia`), run the following command
(estimated running time: 30-50 minutes)

```
docker build -t cynthia .
```

**NOTE:**
The image is built upon `ubuntu:18.04`.

After building the Docker image successfully,
please navigate to the root directory of the artifact


```bash
cd ~/cynthia-eval
```


### Pull Images from Dockerhub

You can also download the docker images from Dockerhub by using the
following commands


```bash
docker pull theosot/cynthia
# Rename the image to be consistent with our scripts
docker tag schaliasos/cynthia cynthia
```

After downloading the Docker image successfully,
please navigate to the root directory of the artifact


```bash
cd ~/cynthia-eval
```
