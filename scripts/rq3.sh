#! /bin/bash

replay()
{
  echo "Replaying testing session $2: Naive ($1 records)..."
  cynthia replay --orms django,peewee \
      --all \
      --generate-data -r $1 \
      --random-seed $i > /dev/null 2>&1

  empty=$(find .cynthia -type f -name '*.out' -empty  |
          sed -r 's/.*\/([0-9]+)\/.*/\1/g'  | sort | uniq | wc -l)

  rate=$(echo "$empty,100" | awk -F ',' '{print $1 / $2}')
  echo "$2,$1,$rate" >> data.txt
}


cp /dev/null data.txt


for i in {1..20}; do
  cynthia clean --only-workdir > /dev/null
  echo "Testing session $i: Solver.."
  cynthia test --orms django,peewee \
     -s 1 -n 100 \
     --store-matches -r 5 \
     --solver \
     --only-constrained-queries \
     --random-seed $i > /dev/null 2>&1

  empty=$(find .cynthia -type f -name '*.out' -empty  |
          sed -r 's/.*\/([0-9]+)\/.*/\1/g'  | sort | uniq | wc -l)
  rate=$(echo "$empty,100" | awk -F ',' '{print $1 / $2}')
  echo "$i,solver,$rate" >> data.txt
  replay "50" $i
  replay "100" $i
  replay "300" $i
  replay "500" $i
  replay "1000" $i
  echo
done
