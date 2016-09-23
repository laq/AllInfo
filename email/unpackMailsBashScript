#!/bin/bash
EXTENTION="laqPcLin"

for f in *.$EXTENTION
do
  name=$(grep From $f)
  echo $name $f
  mkdir "$name"
  cp $f "$name"
  munpack -C "$name" $f
done
