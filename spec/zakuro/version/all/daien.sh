#!/bin/bash

while :
do
  rspec daien_spec.rb > temp.log
  echo "output temp.log"
  sleep 10
done
