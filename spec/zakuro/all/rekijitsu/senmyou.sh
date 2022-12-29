#!/bin/bash

while :
do
  rspec senmyou_spec.rb > temp.log
  echo "output temp.log"
  sleep 10
done
