#!/bin/bash
file=$1
fileName=$(basename $file .json)
cat $file | jq .Datapoints | jq -S 'sort_by(.Timestamp)' > ${fileName}Sorted.json
sed -i 's/\([0-9]\{1\}\.[0-9]\{2\}\)[0-9]*/\1/g' ${fileName}Sorted.json
if [[ $(grep ExtendedStatistics ${fileName}Sorted.json) ]];then
    cat ${fileName}Sorted.json | jq --sort-keys 'map(.P99 = .ExtendedStatistics.p99 | del(.ExtendedStatistics))' > temp.json 2>/dev/null
    cp temp.json ${fileName}Sorted.json
    rm temp.json
fi
cat ${fileName}Sorted.json | jq -r '(map(keys) | add | unique) as $cols | map(. as $row | $cols | map($row[.])) as $rows | $cols, $rows[] | @csv' > ${fileName}Sorted.csv
sed -i 's/"//g' ${fileName}Sorted.csv
rm ${fileName}Sorted.json
