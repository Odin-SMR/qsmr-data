# Build scripts

This directory contains scripts for compiling the matlab precalc algorithm
and building a docker image that can run the precalc function and produce
a qsmr data artifact for a certain invemode and freqmode.

## Compile matlab script

Run `compile.sh` on a machine with matlab R2015b. This will produce the
archive `mcr/qsmr_precalc.tar.gz`. Put this archive in the docker directory.

## Build docker image

Run `build.sh` on a machine with docker. Note that the `qsmr_precalc.tar.gz`
archive must have been copied to the docker directory first.

This will produce a docker image:

    docker2.molflow.com/devops/qsmr_precalc:<yymmdd>

## Run the precalc algorithm

Example with invemode=stnd and freqmode=1:

    docker run --rm -v /local/output/dir:/artifact docker2.molflow.com/devops/qsmr_precalc:<yymmdd> /artifact stnd 1

The qsmr data will after this be located on the host at `/local/output/dir`.
See the README in Build_scripts in the qsmr repo for how to build the final
qsmr docker image with this data.

TODO: Send the qsmr data to a file service instead.
