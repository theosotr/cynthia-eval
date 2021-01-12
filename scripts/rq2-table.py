#! /usr/bin/env python3

from collections import defaultdict
import os
import sqlite3

dirname = os.path.dirname(os.path.abspath(__file__))
bugdb = os.path.join(dirname, "..", "bugs/bugdb.sqlite3")


db_con = sqlite3.connect(bugdb)
cursor = db_con.cursor()
query = "SELECT bug_type, affected_backend FROM ORM_BUG"
header = ["Type", "#Bugs", "All", "SQLite", "MySQL", "PSQL",
          "MSSQL"]
rows = defaultdict(lambda: defaultdict(lambda: 0))
for row in cursor.execute(query):
    bug_type, backends = row
    backends = backends.split(',')
    for backend in backends:
        rows[bug_type][backend] += 1

str_map = {
    'invalid sql': 'Invalid SQL',
    'logic error': 'Logic Error',
    'crash': 'Crash',
}

query = "SELECT bug_type, COUNT(*) FROM ORM_BUG GROUP BY bug_type"
counts = {}
for row in cursor.execute(query):
    counts[row[0]] = row[1]

rows = [
    (str_map[k], counts[k], v['ALL'], v['SQLite'],
     v['MySQL'], v['Postgres'], v['MSSQL'])
    for k, v in rows.items()
]
rows = sorted(rows, key=lambda x: x[1], reverse=True)
totals = [
    "Total",
    sum(row[1] for row in rows),
    sum(row[2] for row in rows),
    sum(row[3] for row in rows),
    sum(row[4] for row in rows),
    sum(row[5] for row in rows),
    sum(row[6] for row in rows)
]
rows.append(totals)
row_format = "{:<14}" + "{:<9}" + "{:<10}" + "{:<11}" * 4
print(row_format.format(*header))
print("=" * 72)
row_len = len(rows)
for i, r in enumerate(rows):
    print(row_format.format(*r))
    if i == row_len - 2:
        print("=" * 72)
