set -e

rm -rf mcr
mkdir -p mcr
cp runprecalc.m mcr/

echo $LD_LIBRARY_PATH
MATLAB_ROOT=/opt/MATLAB/R2015b
cd mcr && ${MATLAB_ROOT}/bin/mcc \
	-a ../../Mscripts_external \
	-a ../../Mscripts_precalc \
	-a ../../Mscripts_qsystem \
    -a ../../Settings \
	-a ../../../qsmr/Mscripts_arts \    
	-a ../../../qsmr/Mscripts_atmlab \
    -a ../../../qsmr/Mscripts_atmlab/time \
    -a ../../../qsmr/Mscripts_atmlab/xml \
	-a ../../../qsmr/Mscripts_database \
	-a ../../../qsmr/Mscripts_qsystem \
	-a ../../../qsmr/Mscripts_webapi \
	-v \
	-N \
	-m \
	-R -nojvm \
	-R -nodisplay \
	runprecalc

tar -czf qsmr_precalc.tar.gz readme.txt run_runprecalc.sh runprecalc
