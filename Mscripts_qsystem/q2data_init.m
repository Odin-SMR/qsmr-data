% Q2DATA_INIT   Initialises qsmr_data
%
%   The following operations are performed:
%     * Adds qsmr_data folders to the search path
%
%   It should suffice to call this function just once during a session.
%
% FORMAT   q2data_init

% 2015-12-17   Patrick Eriksson.

function q2data_init


%- Add Qsmr itself to search path
%
topfolder = fileparts( fileparts( which( mfilename ) ) );
%
addpath( fullfile( topfolder, 'Settings' ) );
addpath( fullfile( topfolder, 'Mscripts_external' ) );
addpath( fullfile( topfolder, 'Mscripts_precalc' ) );
addpath( fullfile( topfolder, 'Mscripts_qsystem' ) );


