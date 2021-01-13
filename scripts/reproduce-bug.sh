#! /bin/bash

if [ -z $1 ]; then
  echo "You have to provide the bug to reproduce"
  exit 1
fi

bug=$1
dir=$(dirname $0)
bugdir=$(realpath $dir/../bugs)
query="SELECT orm, orm_version, affected_backend FROM ORM_BUG WHERE test_case='test-cases/$bug'"
res=$(sqlite3 $bugdir/bugdb.sqlite3 "$query")
orm="$(cut -d'|' -f1 <<< $res | awk '{print tolower($0)}')"
version="$(cut -d'|' -f2 <<< $res)"
backend="$(cut -d'|' -f3 <<< $res | awk '{print tolower($0)}')"

echo "Installing the ORM versions for reproducing the bug..."
${HOME}/scripts/setup-orms.sh --$orm-version $version > /dev/null 2>&1

echo "Cleaning .cynthia..."
cynthia clean
echo

if [ "$orm" = "peewee" ]; then
  ref_orm=sqlalchemy
else
  ref_orm=peewee
fi

schema=$bugdir/test-cases/$bug/TestSchema.sql
aql=$bugdir/test-cases/$bug/query.aql.json
if [[ "$backend" = "all" || "$backend" = "sqlite" ]]; then
  backend=sqlite
  cynthia run \
    --sql $schema \
    --aql $aql \
    --orms "$orm,$ref_orm"
else
  cynthia run \
    --sql $schema \
    --aql $aql \
    --orms "$orm,$ref_orm" \
    -d $backend
fi

diff --color .cynthia/sessions/TestSchema/1/${orm}_$backend.out \
  .cynthia/sessions/TestSchema/1/${ref_orm}_$backend.out
