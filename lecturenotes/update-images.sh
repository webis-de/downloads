#!/bin/bash
for unit_file in $(ls */unit-*.pdf);do
  dir=${unit_file%.pdf}
  unit=$(basename $dir)

  rm -rf $dir
  ./generate-browser-data.sh $unit_file $dir
  rm $dir/unit.json
done
