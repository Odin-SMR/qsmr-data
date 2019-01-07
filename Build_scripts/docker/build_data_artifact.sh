#!/bin/bash

set -e

build_data_artifact() {
    local output_path=$1
    local invemode=$2
    local freqmode=$3
    local abslookup_path
    local invemode_dir

    if [[ -z $output_path || -z $invemode || -z $freqmode ]]; then
        echo "Missing parameter, example usage:"
        echo "   ./build_data_artifact /path stnd 1"
        exit 1
    fi

    invemode=$(echo "$invemode" | awk '{print tolower($0)}')
    # First letter should be uppercase in directory name
    invemode_dir=$(echo ${invemode:0:1} | awk '{print toupper($0)}')${invemode:1}

    echo "Building data artifact for invemode ${invemode} and freqmode ${freqmode}"

    # Copy static data needed by qsmr
    if [ ! -d "${output_path}/DataPrecalced" ]; then
        mkdir -p "${output_path}/DataPrecalced"
        cp -r /QsmrData/DataPrecalced $output_path
    fi
    if [ ! -d "${output_path}/DataInput" ]; then
        mkdir -p "${output_path}/DataInput"
        cp -r /QsmrData/DataInput/Temperature "${output_path}/DataInput"
    fi
    abslookup_path="${output_path}/AbsLookup/${invemode_dir}"
    mkdir -p $abslookup_path

    cat >"${output_path}/env.sh" <<EOF
INVEMODE=$invemode
FREQMODE=$freqmode
EOF

    # Calculate abslookup data and save Q config
    # The Q config will contain version information for qsmr and arts
    /qsmr_precalc/run_runprecalc.sh "/opt/matlab/v90" $output_path $invemode $freqmode
}

build_data_artifact "$@"
