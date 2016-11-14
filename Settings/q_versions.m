% Q_VERSIONS   ARTS and Qsmr versions to be used for operational work
%
% FORMAT   Q = q_paths( Q )
%
% OUT   Q   Q with version settings added.
% IN    Q   Existing Q settings. 


function Q = q_versions(Q)

Q.VERSION_ARTS = 'arts-2.3.562';

Q.VERSION_QSMR = 'qsmr-beta-3';
