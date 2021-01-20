DROP TABLE IF EXISTS "ORM_BUG";
CREATE TABLE "ORM_BUG" (
    "id" integer primary key,
    "desc" varchar(500),
    "orm" varchar(100),
    "orm_version" varchar(100),
    "status" varchar(100),
    "release_blocker" integer,
    "bug_type" varchar(100),
    "affected_orm_feature" varchar(100),
    "affected_backend" varchar(100),
    "issue_url" varchar(100),
    "test_case" varchar(10)
);

/* 1 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Chain of unions leads to incorrect SQL query on MariaDB < 10.4 and MySQL.",
    "Django",
    "3.1",
    "confirmed",
    0,
    "invalid sql",
    "combined query",
    "MySQL",
    "https://code.djangoproject.com/ticket/31445",
    "test-cases/1"
);

/* 2 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "SQL-expression is not wrapped by brackets when 'type_coerce()' is used",
    "SQLAlchemy",
    "3fb0eb5a156ab7dbe19d82717dd197d9d22e64f1",
    "fixed",
    0,
    "logic error",
    "expression",
    "ALL",
    "https://github.com/sqlalchemy/sqlalchemy/issues/5344",
    "test-cases/2"
);

/* 3 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Combination of [Op.substring] and sequelize.literal yields unexpected SQL query",
    "Sequelize",
    "5.21.5",
    "fixed",
    0,
    "logic error",
    "string comparison",
    "ALL",
    "https://github.com/sequelize/sequelize/issues/12073",
    "test-cases/3"
);

/* 4 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Wrong SQL query is generated when the function 'count()` is used`'",
    "Sequelize",
    "5.21.5",
    "confirmed",
    0,
    "logic error",
    "expression",
    "ALL",
    "https://github.com/sequelize/sequelize/issues/12099",
    "test-cases/4"
);

/* 5 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Sequelize generates a GROUP BY clause even if the 'group' property contains an empty list",
    "Sequelize",
    "5.21.5",
    "fixed",
    0,
    "invalid sql",
    "group by",
    "ALL",
    "https://github.com/sequelize/sequelize/issues/12315",
    "test-cases/5"
);

/* 6 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Constant expressions of an ExpressionWrapper object are incorrectly placed at the GROUP BY clause",
    "Django",
    "3.0",
    "fixed",
    0,
    "invalid sql",
    "group by",
    "MySQL,Postgres",
    "https://code.djangoproject.com/ticket/31651",
    "test-cases/6"
);

/* 7 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Django loses information regarding the type of grouping columns",
    "Django",
    "f83b44075dafa429d59e8755aa47e15577cc49f9",
    "fixed",
    1,
    "crash",
    "expression",
    "Postgres",
    "https://code.djangoproject.com/ticket/31659",
    "test-cases/7"
);

/* 8 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "sub-expressions not wrapped by parentheses",
    "peewee",
    "3.13.3",
    "fixed",
    0,
    "logic error",
    "expression",
    "ALL",
    "https://github.com/coleifer/peewee/issues/2200",
    "test-cases/8"
);

/* 9 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Query crashes with syntax error on SQLite",
    "SQLAlchemy",
    "b0cfa7379cf8513a821a3dbe3028c4965d9f85bd",
    "fixed",
    0,
    "invalid sql",
    "aliasing",
    "SQLite",
    "https://github.com/sqlalchemy/sqlalchemy/issues/5395",
    "test-cases/9"
);

/* 10 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Fields placed at the SELECT clause in an erroneous order",
    "Django",
    "3.1",
    "confirmed",
    0,
    "logic error",
    "combined query",
    "ALL",
    "https://code.djangoproject.com/ticket/31699",
    "test-cases/10"
);

/* 11 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Django subtly produces incorrect query when the same keyword appears in both aggregate() and annotate()",
    "Django",
    "3.1",
    "confirmed",
    0,
    "logic error",
    "aliasing",
    "ALL",
    "https://code.djangoproject.com/ticket/31679",
    "test-cases/11"
);

/* 12 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "SQLAlchemy generates invalid query when using distinct with joins",
    "SQLAlchemy",
    "f97691e2a7a75657b6ef0d02d814f22f219fd780",
    "fixed",
    0,
    "invalid sql",
    "distinct",
    "ALL",
    "https://github.com/sqlalchemy/sqlalchemy/issues/5443",
    "test-cases/12"
);

/* 13 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Peewee crashes when applying distinct to an expression",
    "peewee",
    "98783d61f0482e4f4eb670b9b9bceea391c3a554",
    "fixed",
    0,
    "crash",
    "distinct",
    "Postgres",
    "https://github.com/coleifer/peewee/issues/2220",
    "test-cases/13"
);

/* 14 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "ExpressionWrapper loses output_field for combined expression without an output_field",
    "Django",
    "1d8256719eecb724476e6cb8d63cfebf6ba1a3cc",
    "fixed",
    1,
    "crash",
    "expression",
    "ALL",
    "https://code.djangoproject.com/ticket/31773",
    "test-cases/14"
);

/* 15 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Average does not seem to work properly when combined with distinct",
    "ActiveRecord",
    "latest",
    "confirmed",
    0,
    "logic error",
    "distinct",
    "ALL",
    "https://github.com/rails/rails/issues/39857",
    "test-cases/15"
);

/* 16 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Substring does not work as expected with % and _",
    "Sequelize",
    "6.3.3",
    "unconfirmed",
    0,
    "logic error",
    "string comparison",
    "ALL",
    "https://github.com/sequelize/sequelize/issues/12519",
    "test-cases/16"
);

/* 17 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Invalid SQL code is generated when combining DISTINCT ON with UNION",
    "SQLAlchemy",
    "547e959157f841f4f6d1e405ceed14755fcbd0bd",
    "fixed",
    0,
    "invalid sql",
    "combined query,distinct",
    "Postgres",
    "https://github.com/sqlalchemy/sqlalchemy/issues/5469",
    "test-cases/17"
);

/* 18 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "expression in ORDER BY clause does match any expression in the SELECT clause (SQL Server)",
    "SQLAlchemy",
    "e385fc6215aea605e4b09babbb2c21702000b84f",
    "fixed",
    0,
    "invalid sql",
    "distinct",
    "MSSQL",
    "https://github.com/sqlalchemy/sqlalchemy/issues/5470",
    "test-cases/18"
);

/* 19 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Inconsistency in treatment of '\' character'",
    "peewee",
    "611a08987e8f08af1056ec679ea6cfdccb87c65b",
    "fixed",
    0,
    "logic error",
    "string comparison",
    "ALL",
    "https://github.com/coleifer/peewee/issues/2233",
    "test-cases/19"
);

/* 20 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "QuerySet.aggregate() mixes annotated fields names",
    "Django",
    "3.1",
    "fixed",
    0,
    "logic error",
    "aliasing",
    "ALL",
    "https://code.djangoproject.com/ticket/31880",
    "test-cases/20"
);

/* 21 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "MSSQL fix sanity checks of the 'limit' option",
    "Sequelize",
    "6.3.3",
    "unconfirmed",
    0,
    "logic error",
    "expression",
    "MSSQL",
    "https://github.com/sequelize/sequelize/pull/12622",
    "test-cases/21"
);

/* 22 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Each GROUP BY expression must contain at least one column that is not an outer reference",
    "Django",
    "3.0",
    "unconfirmed",
    0,
    "invalid sql",
    "group by",
    "MSSQL",
    "https://github.com/ESSolutions/django-mssql-backend/issues/62",
    "test-cases/22"
);

/* 23 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Combined queryset crash on combined querysets with ordering",
    "Django",
    "981a072dd4dec586f8fc606712ed9a2ef116eeee",
    "fixed",
    0,
    "crash",
    "combined query",
    "ALL",
    "https://code.djangoproject.com/ticket/31916",
    "test-cases/23"
);

/* 24 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "FieldError: Expression contains mixed types: IntegerField, AutoField. You must set output_field",
    "Django",
    "0be51d2226fce030ac9ca840535a524f41e9832c",
    "fixed",
    1,
    "crash",
    "expression",
    "ALL",
    "https://code.djangoproject.com/ticket/31919",
    "test-cases/24"
);

/* 25 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "MySQL reserved words",
    "SQLAlchemy",
    "fe772672b4fc00df0b66aca92e2092779a844a2d",
    "fixed",
    0,
    "invalid sql",
    "aliasing",
    "MySQL",
    "https://github.com/sqlalchemy/sqlalchemy/pull/5539",
    "test-cases/25"
);

/* 26 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Invalid Query is generated on MS Server (distinct)",
    "SQLAlchemy",
    "c7cf63d64e2b47cdabcda622af86513ec192f4a4",
    "fixed",
    0,
    "invalid sql",
    "distinct",
    "MSSQL",
    "https://github.com/sqlalchemy/sqlalchemy/issues/5511",
    "test-cases/26"
);

/* 27 */
INSERT INTO "ORM_BUG"(
    "desc", "orm", "orm_version", "status", "release_blocker",
    "bug_type", "affected_orm_feature", "affected_backend", "issue_url",
    "test_case"
) VALUES(
    "Contains does not work as expected with % and _",
    "peewee",
    "3.13.3",
    "fixed",
    0,
    "logic error",
    "string comparison",
    "ALL",
    "https://github.com/coleifer/peewee/issues/2224",
    "test-cases/27"
);
