#!/bin/bash

set -e

rm -rf docker/data
mkdir -p docker/data

cp -r ../DataPrecalced docker/data/
cp -r ../DataInput docker/data

today=$(date +%y%m%d)

docker build -t "docker2.molflow.com/devops/qsmr_precalc:${today}" docker/
#docker push "docker2.molflow.com/devops/qsmr_precalc:${today}"
