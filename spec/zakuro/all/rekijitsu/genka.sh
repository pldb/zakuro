#!/bin/bash

while :
do
  rspec genka_spec.rb > temp.log
  echo "output temp.log"
  sleep 10
done
