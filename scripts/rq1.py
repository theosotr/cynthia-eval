#! /usr/bin/env python3

from collections import defaultdict
import os
import sqlite3

dirname = os.path.dirname(os.path.abspath(__file__))
bugdb = os.path.join(dirname, "..", "bugs/bugdb.sqlite3")


db_con = sqlite3.connect(bugdb)
cursor = db_con.cursor()
query = "SELECT orm, status, COUNT(*) FROM ORM_BUG GROUP BY orm, status"

header = ["ORM", "Total", "Fixed", "Confirmed", "Unconfirmed"]
rows = defaultdict(lambda: (0, 0, 0))
for row in cursor.execute(query):
    orm, status, count = row
    fixed, confirmed, unconfirmed = rows[orm]
    if status == 'fixed':
        rows[orm] = (count, confirmed, unconfirmed)
    if status == 'confirmed':
        rows[orm] = (fixed, count, unconfirmed)
    if status == 'unconfirmed':
        rows[orm] = (fixed, confirmed, count)

rows = [(k, v[0] + v[1] + v[2], v[0], v[1], v[2]) for k, v in rows.items()]
rows = sorted(rows, key=lambda x: x[1], reverse=True)
totals = [
    "Total",
    sum(row[1] for row in rows),
    sum(row[2] for row in rows),
    sum(row[3] for row in rows),
    sum(row[4] for row in rows)
]
rows.append(totals)
row_format = "{:<40}" + "{:>5}" + "{:>15}" * 3
print(row_format.format(*header))
print("=" * 90)
row_len = len(rows)
for i, r in enumerate(rows):
    print(row_format.format(*r))
    if i == row_len - 2:
        print("=" * 90)
