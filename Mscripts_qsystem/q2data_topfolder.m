% Q2DATA_TOPFOLDER   Returns path to top folder of qsmr_data
%
% FORMAT   topfolder = q2data_topfolder
%        
% OUT   topfolder   Full path to top folder of qsmr_data

% 2015-05-21   Patrick Eriksson.

function topfolder = q2data_topfolder

topfolder = folder_of_fun( mfilename, 1 );

