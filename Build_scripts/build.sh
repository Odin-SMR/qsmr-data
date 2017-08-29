#!/bin/bash

set -e

rm -rf docker/data
mkdir -p docker/data

cp -r ../DataPrecalced docker/data/
cp -r ../DataInput docker/data

if [ $# -eq 0 ]
  then
    today=$(date +%y%m%d)
  else
    today=$1
fi

docker build -t "odinregistry.molflow.com/devops/qsmr_precalc:${today}" docker/
#docker push "odinregistry.molflow.com/devops/qsmr_precalc:${today}"
