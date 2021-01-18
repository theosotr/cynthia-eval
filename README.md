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

* At least 6GB of available disk space

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
* `examples/`: Contains some example AQL queries for getting started with `Cynthia`.
* `lib/`: Contains external libraries used by `Cynthia`.
* `project/`: Contains configuration associated with `sbt`,
  the build system used to build `Cynthia`.
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
(estimated running time: 30 minutes - 1 hour)

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


### Pull Image from Dockerhub

You can also download the Docker image from Dockerhub by using the
following commands


```bash
docker pull theosot/cynthia
# Rename the image to be consistent with our scripts
docker tag theosot/cynthia cynthia
```

After downloading the Docker image successfully,
please navigate to the root directory of the artifact


```bash
cd ~/cynthia-eval
```

Getting Started
===============

To get started with `Cynthia`,
we will use the previously created Docker image
(namely, `cynthia`).
Recall that this image contains all the
required environment for testing ORMs
(i.e., it contains installations of the corresponding
ORM systems,
as well as installations
of the underlying database management systems).

You can enter a new container by using the following command

```bash
docker run -ti --rm cynthia
```

## Basic Usage

The CLI of `Cynthia` provides six sub-commands; `test`, 
`generate`, `replay`, `run`, `inspect`, and `clean`.
Below, we explain each sub-command by providing a set
of examples and use cases.

```
cynthia@0fbedf262c3d:~$ cynthia --help
cynthia 0.1
Usage: cynthia [test|generate|replay|run|inspect|clean] [options]

Cynthia: Data-Oriented Differential Testing of Object-Relational Mapping Systems

  --help                   Prints this usage text
  --version                Prints the current tool's version
Command: test [options]

  -n, --queries <value>    Number of queries to generate for each schema (default value: 200)
  -s, --schemas <value>    Number of schemas to generate (default value: 1)
  --timeout <value>        Timeout for testing in seconds
  -o, --orms <value>       ORMs to differentially test
  -d, --backends <value>   Database backends to store data (default value: sqlite)
  -u, --db-user <value>    The username to log in the database
  -p, --db-pass <value>    The password used to log in the database
  -S, --store-matches      Save matches into the 'sessions' directory
  --combined               Generate AQL queries consting of other simpler queries
  -r, --records <value>    Number of records to generate for each table
  --min-depth <value>      Minimum depth of the generated AQL queries
  --max-depth <value>      Maximum depth of the generated AQL queries
  --no-well-typed          Generate AQL queries that are type incorrect
  --solver                 Generate database records through a solver-based approach
  --solver-timeout <value>
                           Solver timeout for each query
  --random-seed <value>    Make the testing procedure deterministic by giving a random seed
  --only-constrained-queries
                           Generate only constrained queries
Command: generate [options]

  -n, --queries <value>    Number of queries to generate for each schema (default value: 200)
  -s, --schemas <value>    Number of schemas to generate (Default value: 1)
  --combined               Generate AQL queries consting of other simpler queries
  -r, --records <value>    Number of records to generate for each table
  --min-depth <value>      Minimum depth of the generated AQL queries
  --max-depth <value>      Maximum depth of the generated AQL queries
  --no-well-typed          Generate AQL queries that are type incorrect
  --solver                 Generate database records through a solver-based approach
  --solver-timeout <value>
                           Solver timeout for each query
  --random-seed <value>    Make the testing procedure deterministic by giving a random seed
  --only-constrained-queries
                           Generate only constrained queries
Command: replay [options]

  -c, --cynthia <value>    The cynthia directory for replaying missmatches (default value: .cynthia)
  -s, --schema <value>     schema to replay
  -a, --all                Replay all queries.
  -m, --mismatches <value>
                           Replay queries for which ORM previously produced different results
  --generate-data          Re-generate data while replaying testing sessions
  -o, --orms <value>       ORMs to differentially test
  -d, --backends <value>   Database backends to store data (default value: sqlite)
  -u, --db-user <value>    The username to log in the database
  -p, --db-pass <value>    The password used to log in the database
  -r, --records <value>    Number of records to generate for each table
  --solver                 Generate database records through a solver-based approach
  --solver-timeout <value>
                           Solver timeout for each query
  --random-seed <value>    Make the testing procedure deterministic by giving a random seed
Command: run [options]

  -s, --sql <value>        File with the sql script to generate and feed the database
  -a, --aql <value>        A file with an AQL query or a directory with many AQL queries
  -o, --orms <value>       ORMs to differentially test
  -d, --backends <value>   Database backends to store data (default value: sqlite)
  -u, --db-user <value>    The username to log in the database
  -p, --db-pass <value>    The password used to log in the database
  -S, --store-matches      Save matches into the 'sessions' directory
Command: inspect [options]

  -c, --cynthia <value>    The cynthia directory for inspecting missmatches (default value: .cynthia)
  -s, --schema <value>     schema to inspect
  -m, --mismatches <value>
                           mismatches to inspect
Command: clean [options]

  --only-workdir           Clean only the working directory '.cynthia'
  -u, --db-user <value>    The username to log in the database
  -p, --db-pass <value>    The password used to log in the database

```

### cynthia test

This is the main sub-command for testing ORMs.
`cynthia test` expects at least two ORMs to test
(through the `--orms` option),
and some database systems (i.e., backends) specified
by the `--backends` options.
Note that if `--backends` is not given,
the `SQLite` database system is used by default.

`cynthia test` first generates a number of relational database
schemas
The number of the generated schemas is
specified by the `--schemas` option.
Every generated schema corresponds to a *testing session*.
In every testing session, `cynthia test` generates a number of
random AQL queries (given by the `--queries` option),
translates every AQL query into the corresponding executable ORM query,
and finally runs every ORM query on the given backends.
Note that for a given AQL query,
`Cynthia` generates multiple ORM queries,
one for every backend.

#### Example

In the following scenario,
we differentially test the `peewee` and `Django` ORMs.
The ORM queries are run
on top of the `SQLite` and `PostgreSQL` databases,
and we spawn 5 testing sessions (`--schemas 5`).
In every testing session, we generate 100 AQL queries
(`--queries 100`).
Finally, to populate the underlying databases with data,
we use the Z3 solver (`--solver`) to generate five
records (`--records 5`) by solving the constraints
of every generated AQL query.

```bash
cynthia@0fbedf262c3d:~$ cynthia test \
  --schemas 5 \
  --queries 100 \
  --orms django,peewee \
  --backends postgres \
  --solver \
  --records 5 \
  --random-seed 1 \
  --store-matches
```

The above command will produce an output similar to the following

```
Testing Serially 100% [===================== Passed ✔: 93, Failed ✘: 0, Unsp: 5, Timeouts: 2
Testing Cucumbers 100% [==================== Passed ✔: 95, Failed ✘: 0, Unsp: 2, Timeouts: 3
Testing Mumbles 100% [====================== Passed ✔: 94, Failed ✘: 0, Unsp: 3, Timeouts: 3
Testing Subhead 100% [====================== Passed ✔: 96, Failed ✘: 0, Unsp: 2, Timeouts: 2
Testing Wild 100% [========================= Passed ✔: 96, Failed ✘: 0, Unsp: 4, Timeouts: 0
Command test finished successfully.
```

Note that `Cynthia` processes testing sessions in parallel by using Scala
futures. `Cynthia` also dumps some statistics for every testing session.

```
Testing Cucumbers 100% [==================== Passed ✔: 95, Failed ✘: 0, Unsp: 2, Timeouts: 3
```

For example, the above message
means that in the testing session named `Cucumbers`,
`Cynthia` generated 100 AQL queries of which

* 95 / 100 queries passed (i.e., the ORMs under test produced exact results).
* 0 / 100 queries failed (i.e., the ORMs under test produced different results).
  Note that failed queries indicate a potential bug
  in at least one of the ORMs under test.
* 2 / 100 queries were unsupported meaning that the ORMs were unable to execute
  these queries, because these queries contained features
  that are not currently supported by the ORMs under test.
* 3 / 100 queries timed out, i.e., the SMT solver timed out and failed to
  generate records for populating the underlying databases.

#### The .cynthia working directory

`Cynthia` also produces a directory named `.cynthia`
(inside the current working directory)
where it stores important information about each run.
The `.cynthia` directory has the following structure.

* `.cynthia/cynthia.log`: A file containing logs associated with the last
  `cynthia` run.
* `.cynthia/dbs/`: This is the directory where the `SQLite` database files
  of each testing session are stored.
* `.cynthia/schemas/`: This directory contains SQL scripts corresponding to
the database schema of each testing session. Every SQL script contains
all the necessary `CREATE TABLE` statements for creating the relational
tables defined in each schema.
* `.cynthia/projects/`: A directory where `Cynthia` creates and runs
the corresponding ORM queries.
* `.cynthia/sessions/`: This directory contains complete information about
the runs taken place at every testing session. 

In particular, by inspecting the structure of the `.cynthia/sessions/`
directory, we have the following

* `.cynthia/sessions/<Session Name>/<Query ID>/data.sql`:
  This is the SQL script that populates the underlying database
  with data generated by the SMT solver. Note that these data are targeted,
  meaning that satisfy the constraints of the query specified by `<Query ID>`. 
* `.cynthia/sessions/<Session Name>/<Query ID>/diff_test.out`:
  The output of differential testing. Either "MATCH", "MISMATCH", or "UNSUPPORTED".
* `.cynthia/sessions/<Session Name>/<Query ID>/<orm>_<backend>.out`:
  The output produced by the query written by using the API of ORM named `<orm>`,
  and when this query is run on the backend `<backend>`.
* `.cynthia/sessions/<Session Name>/<Query ID>/query.aql`:
  The AQL query in human readable format.
* `.cynthia/sessions/<Session Name>/<Query ID>/query.aql.json`:
  The AQL query in JSON format. This is what `Cynthia` understands.
* `.cynthia/sessions/<Session Name>/<Query ID>/<orm>/`:
  This directory contains all ORM-specific files for executing
  the ORM queries written in ORM named `<orm>`.
  For example, by executing

  ```bash
  python .cynthia/sessions/Cucumbers/22/django/driver_postgres.py
  ```

  You re-execute the Django query stemming from the AQL query
  with id `22`. This query is run on the PostgresSQL database.


### cynthia replay

This sub-command replays the execution of a particular testing
session based on information extracted from the `.cynthia`
directory. This command is particularly useful when we want
to run the same queries with different settings
(i.e., running the same AQL queries on different database systems).

#### Examples

Replay all testing sessions previously created by `cynthia test`

```bash
cynthia@0fbedf262c3d:~$ cynthia replay \
  --orms django,peewee \
  --backends postgres \
  --all
```

This produces the exact results as `cynthia test`

```
Replaying Serially  ? % [     =              Passed ✔: 95, Failed ✘: 0, Unsp: 5, Timeouts: 0
Replaying Cucumbers  ? % [          =        Passed ✔: 98, Failed ✘: 0, Unsp: 2, Timeouts: 0
Replaying Subhead  ? % [=                    Passed ✔: 98, Failed ✘: 0, Unsp: 2, Timeouts: 0
Replaying Mumbles  ? % [=                    Passed ✔: 97, Failed ✘: 0, Unsp: 3, Timeouts: 0
Replaying Wild  ? % [        =               Passed ✔: 96, Failed ✘: 0, Unsp: 4, Timeouts: 0
Command replay finished successfully.
```

Replay the execution of a specific testing session

```bash
cynthia@0fbedf262c3d:~$ cynthia replay \
  --schema Cucumbers \
  --orms django,peewee \
  --backends postgres \
  --all
```

This produces

```
Replaying Cucumbers  ? % [          =        Passed ✔: 98, Failed ✘: 0, Unsp: 2, Timeouts: 0
Command replay finished successfully.
```

Replay the execution of a specific testing session, and run ORM queries
on MySQL instead of Postgres.

```bash
cynthia@0fbedf262c3d:~$ cynthia replay \
  --schema Cucumbers \
  --orms django,peewee \
  --backends mysql \
  --all
```

Replay the execution of a specific testing session, and differentially
test `SQLAlchemy` and `Sequelize` instead of `Django` and `peeewee`.


```bash
cynthia@0fbedf262c3d:~$ cynthia replay \
  --schema Cucumbers \
  --orms sqlalchemy,sequelize \
  --all
```

### cynthia run

The sub-command `cynthia run` tests the given ORMs against
certain AQL queries (provided by the user)
based on a given database schema.


#### Example

The command below, tests `Django` and `peewee` against the AQL query
located in the directory `cynthia_src/examples/books/10.aql.json`
and the database schema defined
by the script `cynthia_src/examples/book.sql`.
The underlying database system is `SQLite`.

```bash
cynthia@0fbedf262c3d:~$ cynthia run \
  --sql cynthia_src/examples/books.sql \
  --aql cynthia_src/examples/books/10.aql.json \
  --orms django,peewee -S
```

This produces

```bash
Running books  ? % [ =                         Passed ✔: 1, Failed ✘: 0, Unsp: 0, Timeouts: 0
Command run finished successfully.
```


### cynthia generate

`cynthia generate` generates a number of relational database schema,
and for each database schema, it produces a number of AQL queries
and data.
This command does *not* test ORMs, i.e., it does not translate the
generated AQL queries into concrete ORM queries.
Every generated query is stored
inside the `.cynthia/sessions/` directory.

In order to test ORMs, the generated queries can be later executed
using the `cynthia replay` command as documented above.


#### Example

Generate 5 random database schema. For every schema, generate 100 AQL queries.
The generated data are generated by a solver-based approach,
and each table contains 5 records.

```bash
cynthia@0fbedf262c3d:~$ cynthia generate \
 --schemas 5 \
 --queries 100 \
 --records 5 \
 --solver
```

### cynthia inspect

This sub-command inspects the results, and reports
the queries for which the ORMs under test produced different results.
To do so, `cynthia inspect` extracts information
from the `.cynthia` directory.

### Example

Inspect the testing session named `Cucumbers`.

```bash
cynthia@0fbedf262c3d:~$ cynthia inspect --schema Cucumbers
```

This produces

```
Session: Cucumbers
  Crashes:
  Mismatches:
   * 71[sqlite]:
     - django,sqlalchemy,peewee
     - sequelize
   * 17[sqlite]:
     - sequelize
     - django,sqlalchemy,peewee
   * 73[sqlite]:
     - django,sqlalchemy,peewee
     - sequelize
==================================
Command inspect finished successfully.
```

The output above indicates that in three AQL queries
(namely, 17, 71, and 73), the ORMs under test produced
different results. Specifically,
in all queries, the `Sequelize` ORM produced different results
from those produced by the `Django`, `peewee`, and `SQLAlchemy`
ORMs.

You can verify this by inspecting the corresponding ORM outputs
from the `.cynthia` directory

```bash
cynthia@0fbedf262c3d:~$ diff .cynthia/sessions/Cucumbers/73/sequelize_sqlite.out \
  .cynthia/sessions/Cucumbers/73/django_sqlite.out
```

This gives

```diff
0a1,2
> _default -1.00
> _default 2.00
\ No newline at end of file
```

### cynthia clean

`cynthia clean` simply cleans the `.cynthia` directory
and all the tables and databases created
by `Cynthia` in the underlying servers.
This command is safe, as each database created by `Cynthia`
has the prefix `'cynthia_'`, so `cynthia clean` does not remove
any user-defined table or database.

```bash
cynthia@8461308e0af8:~$ cynthia clean
Cleaning working directory .cynthia...
Cleaning backend mysql...
Cleaning backend mssql...
Cleaning backend postgres...
Cleaned database mssql successfully
Cleaned database mysql successfully
Cleaned database postgres successfully
Command clean finished successfully.
```

You can exit the Docker container by running

```bash
cynthia@8461308e0af8:~$ exit
```


## Reproducing two example bugs

Now, we will use `Cynthia` to reproduce the
two bugs mentioned in Section 2 of our paper. 
To do so, we will spawn a new container by running


```bash
docker run -ti --rm -v $(pwd)/example_bugs:/home/cynthia/example_bugs cynthia
```

Note that we used the Docker option `-v` to mount a local volume inside
the freshly-created Docker container. Specifically,
we mounted the directory `example_bugs/` that contains the AQL queries
that trigger Django and peewee bugs mentioned in our paper (Section 2).


### Reproducing the Django bug

To reproduce the Django bug presented in Figure 2,
run the following command from the container


```bash
cynthia@8461308e0af8:~$ ./scripts/setup-orms.sh --django-version 3.1
```

This script will install the buggy Django version that contains the fault
we want to reproduce. After that, run `Cynthia` as follows

```bash
cynthia@8461308e0af8:~$ cynthia run \
  --sql example_bugs/django_bug/Schemadb.sql \
  --aql example_bugs/django_bug/query.aql.json \
  --orms django,peewee \
  --backends mysql
```

The command above means that we run the query AQL query
located at `example_bugs/django_bug/query.aql.json` to test
Django and peewee. The query refers to the database schema located at
the `example_bugs/django_bug/Schemadb.sql` file, and runs on top of
`MySQL`. The command will produce the following output

```
Running Schemadb  ? % [ =                      Passed ✔: 0, Failed ✘: 1, Unsp: 0, Timeouts: 0
Command run finished successfully.
```

Interestingly, this query failed.
This is because Django and peewee produced
different results. If we examine the diff of the results produced by
these ORMs

```bash
cynthia@8461308e0af8:~$ diff .cynthia/sessions/Schemadb/1/django_mysql.out \
  .cynthia/sessions/Schemadb/1/peewee_mysql.out
```

We get

```diff
1,49c1
< Traceback (most recent call last):
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/utils.py", line 84, in _execute
<     return self.cursor.execute(sql, params)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/mysql/base.py", line 73, in execute
<     return self.cursor.execute(query, args)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/MySQLdb/cursors.py", line 206, in execute
<     res = self._query(query)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/MySQLdb/cursors.py", line 319, in _query
<     db.query(q)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/MySQLdb/connections.py", line 259, in query
<     _mysql.connection.query(self, query)
< MySQLdb._exceptions.ProgrammingError: (1064, "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'UNION (SELECT `t2`.`id` FROM `t2`)) UNION (SELECT `t3`.`id` FROM `t3`)' at line 1")
<
< The above exception was the direct cause of the following exception:
<
< Traceback (most recent call last):
<   File "/home/cynthia/.cynthia/projects/Schemadb/django/driver_mysql.py", line 32, in <module>
<     for r in ret32:
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/models/query.py", line 287, in __iter__
<     self._fetch_all()
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/models/query.py", line 1303, in _fetch_all
<     self._result_cache = list(self._iterable_class(self))
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/models/query.py", line 111, in __iter__
<     for row in compiler.results_iter(chunked_fetch=self.chunked_fetch, chunk_size=self.chunk_size):
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/models/sql/compiler.py", line 1106, in results_iter
<     results = self.execute_sql(MULTI, chunked_fetch=chunked_fetch, chunk_size=chunk_size)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/models/sql/compiler.py", line 1154, in execute_sql
<     cursor.execute(sql, params)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/utils.py", line 98, in execute
<     return super().execute(sql, params)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/utils.py", line 66, in execute
<     return self._execute_with_wrappers(sql, params, many=False, executor=self._execute)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/utils.py", line 75, in _execute_with_wrappers
<     return executor(sql, params, many, context)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/utils.py", line 84, in _execute
<     return self.cursor.execute(sql, params)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/utils.py", line 90, in __exit__
<     raise dj_exc_value.with_traceback(traceback) from exc_value
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/utils.py", line 84, in _execute
<     return self.cursor.execute(sql, params)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/Django-3.1-py3.6.egg/django/db/backends/mysql/base.py", line 73, in execute
<     return self.cursor.execute(query, args)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/MySQLdb/cursors.py", line 206, in execute
<     res = self._query(query)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/MySQLdb/cursors.py", line 319, in _query
<     db.query(q)
<   File "/home/cynthia/.env/lib/python3.6/site-packages/MySQLdb/connections.py", line 259, in query
<     _mysql.connection.query(self, query)
< django.db.utils.ProgrammingError: (1064, "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'UNION (SELECT `t2`.`id` FROM `t2`)) UNION (SELECT `t3`.`id` FROM `t3`)' at line 1")
---
> id 1.00
\ No newline at end of file
```

Peewee ran the query successfully and fetched one record,
namely `id` whose value is 1.00.
On the other hand, Django
was unable to run the query because of a bug
found in Django.
In particular,
the SQL query generated by Django had syntax errors.


### Reproducing the peewee bug

First run the following command to install the buggy version of peewee.

```bash
cynthia@8461308e0af8:~$ ./scripts/setup-orms.sh --peewee-version 3.13.3
```

Then, run `Cynthia` as follows

```bash
cynthia@8461308e0af8:~$ cynthia run \
  --sql example_bugs/peewee_bug/Schemadb.sql \
  --aql example_bugs/peewee_bug/query.aql.json \
  --orms django,peewee
```

This `cynthia run` command yields

```
Running Schemadb  ? % [ =                      Passed ✔: 0, Failed ✘: 1, Unsp: 0, Timeouts: 0
Command run finished successfully.
```

As you notice, this query again failed meaning that Django and peewee
produced incorrect results. To examine the diff of their results, run


```bash
cynthia@8461308e0af8:~$ diff .cynthia/sessions/Schemadb/1/django_sqlite.out \
  .cynthia/sessions/Schemadb/1/peewee_sqlite.out
```

```diff
1,6c1,6
< avgExpr 100.00
< avgExpr 16.00
< avgExpr 169.00
< avgExpr 1936.00
< avgExpr 225.00
< avgExpr 576.00
---
> avgExpr 19.00
> avgExpr 25.00
> avgExpr 29.00
> avgExpr 47.00
> avgExpr 7.00
> avgExpr 87.00
```

Unlike the first bug,
this time,
both ORMs ran the query without errors.
However, they produced completely different records.
This behaviour is caused due to a bug in peewee which we thoroughly explain
in Section 2 of our paper (Figure 3).

After reproducing both bugs, you can exit the Docker container by running


```bash
cynthia@8461308e0af8:~$ exit
```

Step by Step Instructions
=========================
