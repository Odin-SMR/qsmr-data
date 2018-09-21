% Q_PATHS   Operational qsmr-data path settings
%
%   This function contains the settings used for operational inversions. That
%   is, don't modify without careful consideration.
%
%   Note: Q.INVEMODE must be set to its final value.
%
% FORMAT   Q = q_paths( Q )
%
% OUT   Q   Q with path settings added.
% IN    Q   Existing Q settings. 


function Q = q_paths( Q );


Q.ARTS               = 'arts';

Q.FOLDER_ABSLOOKUP   = [];   % Jimmy, add your path

topfolder            = q2data_topfolder;
investr              = Q.INVEMODE;
investr(1)           = upper( investr(1) );
investr(2:end)       = lower( investr(2:end) );

Q.FOLDER_ANTENNA     = fullfile( topfolder, 'DataPrecalced', 'Antenna' );  
Q.FOLDER_BDX         = fullfile( topfolder, 'DataPrecalced', 'SpeciesApriori', ...
                                 'Bdx' );
Q.FOLDER_MIPAS       = fullfile( topfolder, 'DataPrecalced', 'SpeciesApriori', ...
                                 'MIPAS' );
Q.FOLDER_BACKEND     = fullfile( topfolder, 'DataPrecalced', 'Backend' );
%Q.FOLDER_BACKEND     = fullfile( topfolder, 'DataPrecalced', 'Backend_PLLdisf' );
Q.FOLDER_FGRID       = fullfile( topfolder, 'DataPrecalced', 'Fgrid', investr );  
Q.FOLDER_MSIS90      = fullfile( topfolder, 'DataInput', 'Temperature' );  

Q.FOLDER_WORK        = '/tmp';

