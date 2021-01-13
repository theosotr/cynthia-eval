#! /bin/bash

replay()
{
  echo "Replay $1"
  cynthia replay --orms django,peewee \
      --all \
      --generate-data -r $1 \
      --random-seed $i > /dev/null

  empty=$(find .cynthia -type f -name '*.out' -empty  |
          sed -r 's/.*\/([0-9]+)\/.*/\1/g'  | sort | uniq | wc -l)

  echo "$empty, 100"
  rate=$(echo "$empty,100" | awk -F ',' '{print $1 / $2}')
  echo "$2,$1,$rate" >> data.txt
}


cp /dev/null data.txt


for i in {14..14}; do
  cynthia clean --only-workdir
  cynthia test --orms django,peewee \
     -s 1 -n 100 \
     --store-matches -r 5 \
     --solver \
     --only-constrained-queries \
     --random-seed $i > /dev/null

  empty=$(find .cynthia -type f -name '*.out' -empty  |
          sed -r 's/.*\/([0-9]+)\/.*/\1/g'  | sort | uniq | wc -l)
  echo "100, "$empty""
  rate=$(echo "$empty,100" | awk -F ',' '{print $1 / $2}')
  echo "$i,solver,$rate" >> data.txt
  replay "50" $i
  replay "100" $i
  replay "300" $i
  replay "500" $i
  replay "1000" $i
done
