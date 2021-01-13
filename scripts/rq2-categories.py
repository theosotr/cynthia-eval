#! /usr/bin/env python3

from collections import defaultdict
import os
import sqlite3

dirname = os.path.dirname(os.path.abspath(__file__))
bugdb = os.path.join(dirname, "..", "bugs/bugdb.sqlite3")


db_con = sqlite3.connect(bugdb)
cursor = db_con.cursor()
query = "SELECT affected_orm_feature FROM ORM_BUG"

header = ["Category", "#Bugs"]
rows = defaultdict(lambda: 0)
for row in cursor.execute(query):
    features = row[0].split(",")
    for feature in features:
        rows[feature] += 1

rows = list(rows.items())
rows = sorted(rows, key=lambda x: x[1], reverse=True)
row_format = "{:<40}" + "{:>5}"
print(row_format.format(*header))
print("=" * 50)
row_len = len(rows)
for i, r in enumerate(rows):
    print(row_format.format(*r))
