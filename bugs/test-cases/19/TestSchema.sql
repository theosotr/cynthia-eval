DROP TABLE IF EXISTS "t1";
CREATE TABLE "t1" (
"id" integer,
"col" numeric(10, 2),
"str" varchar(50),
PRIMARY KEY (id)
);

INSERT INTO "t1" ("id", "col", "str") VALUES (1, 43.5, 'blint_\z');
INSERT INTO "t1" ("id", "col", "str") VALUES (2, 12.1, 'bar');
INSERT INTO "t1" ("id", "col", "str") VALUES (3, 9.33, 'afd');
INSERT INTO "t1" ("id", "col", "str") VALUES (4, 3.1, 'apple');
INSERT INTO "t1" ("id", "col", "str") VALUES (5, 4.46, 'apply');
INSERT INTO "t1" ("id", "col", "str") VALUES (6, 23.5, 'boris');
