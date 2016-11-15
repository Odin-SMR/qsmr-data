FROM docker2.molflow.com/devops/arts:10134

COPY data /QsmrData
# TODO: Fetch from binary repo service?
COPY qsmr_precalc.tar.gz /qsmr_precalc/qsmr_precalc.tar.gz

RUN set -x && \
    cd /qsmr_precalc && \
    tar xf qsmr_precalc.tar.gz && \
    rm qsmr_precalc.tar.gz

# TODO: This is needed by the matlab runtime, but breaks apt-get and probably other programs.
ENV LD_LIBRARY_PATH /opt/matlab/v90/runtime/glnxa64:/opt/matlab/v90/bin/glnxa64:/opt/matlab/v90/sys/os/glnxa64

COPY build_data_artifact.sh /build_data_artifact.sh
RUN chmod u+x /build_data_artifact.sh
ENTRYPOINT /build_data_artifact.sh
