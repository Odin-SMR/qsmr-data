% Q_MESO   Settings for mesospheric inversion mode
%
%   This function contains the settings used for operational "mesospheric"
%   inversions. That is, don't modify without careful consideration.
%
%   The Q-fields are set according to selected frequency mode. The returned
%   Q is complete besides that all fields related to paths. These fields
%   should be set by *q_paths*.
%
% FORMAT   Q = q_meso(freqmode)
%
% OUT   Q          A Q-structure (lacking path and version settings)
%  IN   freqmode   Frequency mode number


function Q = q_meso(freqmode)


%---------------------------------------------------------------------------
%--- Frequency and inversion modes
%---------------------------------------------------------------------------

Q.FREQMODE           = freqmode;
Q.INVEMODE           = 'meso';


%---------------------------------------------------------------------------
%--- Absorption tables
%---------------------------------------------------------------------------

Q.F_GRID_NFILL       = 0;
Q.ABS_P_INTERP_ORDER = 1;
Q.ABS_T_INTERP_ORDER = 3;


%---------------------------------------------------------------------------
%--- RT and sensor
%---------------------------------------------------------------------------

Q.REFRACTION_DO      = false;
Q.PPATH_LMAX         = 15e3;
Q.PPATH_LRAYTRACE    = 20e3;

Q.DZA_MAX_IN_CORE    = 0.01;
Q.DZA_GRID_EDGES     = [ Q.DZA_MAX_IN_CORE*[1:3 5 8 12 21] ];

Q.LO_COMMON          = true;
Q.LO_ZREF            = 60e3;

Q.TB_SCALING_FAC     = 1.0025;
Q.TB_CONTRAST_FAC    = [];


%---------------------------------------------------------------------------
%--- OEM settings
%---------------------------------------------------------------------------

Q.STOP_DX            = 0.5;
Q.GA_START           = 10;
Q.GA_FACTOR_NOT_OK   = 10;
Q.GA_FACTOR_OK       = 10;
Q.GA_MAX             = 1e4;


%---------------------------------------------------------------------------
%--- Common retrieval settings
%---------------------------------------------------------------------------

Q.NOISE_CORRMODEL    = 'expo';  % 'none', 'empi' 'expo'

Q.BASELINE.RETRIEVE  = true;
Q.BASELINE.MODEL     = 'adaptive';  % 'common', 'module', 'adaptive'
Q.BASELINE.UNC       = 2;

Q.POINTING.RETRIEVE  = true;
Q.POINTING.UNC       = 0.01;

Q.FREQUENCY.RETRIEVE = true;
Q.FREQUENCY.UNC      = 1e6;

Q.T.SOURCE           = 'WebApi';
Q.T.RETRIEVE         = true;
Q.T.UNC              = [ 3 3 9 15 15 ];
Q.T.CORRLEN          = 8e3;
Q.T.LIMITS           = [100 350];


%---------------------------------------------------------------------------
%--- Quality criteria
%---------------------------------------------------------------------------

Q.QFILT_TSPILL       = true;
Q.QFILT_TREC         = true;
Q.QFILT_NOISE        = true; 
Q.QFILT_SCANNING     = true;
Q.QFILT_SPECTRA      = true;
Q.QFILT_TBRANGE      = true;
Q.QFILT_TINT         = true;
Q.QFILT_REF1         = true;
Q.QFILT_REF2         = false;
Q.QFILT_MOON         = true;
Q.QFILT_FCORR        = true;
Q.QFILT_LAG0MAX      = 2.5;

Q.MIN_N_SPECTRA      = 8;
Q.MIN_N_FREQS        = 100;



%---------------------------------------------------------------------------
%--- Band specific
%---------------------------------------------------------------------------

switch freqmode

 case 13
  %
  Q.BACKEND_NR               = 1;
  Q.FRONTEND_NR              = 1;
  Q.F_LO_NOMINAL             = 553.300e9;
  %
  Q.SIDEBAND_LEAKAGE         = 0.05;%sideband_settings( freqmode ); 
  % 
  Q.GA_START                 = 1000;
  Q.GA_FACTOR_OK             = sqrt(10);
  %
  Q.P_GRID                   = q2_pgrid( [], 150e3 ); 
  %
  Q.F_RANGES                 = [ 556.6e9 557.2e9; ];
  Q.ZTAN_LIMIT_TOP           = 150e3;
  Q.ZTAN_LIMIT_BOT           = [ 40e3 40e3 40e3 40e3 ];
  Q.ZTAN_MIN_RANGE           = [ 45e3 80e3 ];
  %
  Q.T.L2                     = true;
  Q.T.L2NAME                 = 'Temperature - 557 (Fmode 13) - 45 to 90 km';
  Q.T.GRID                   = q2_pgrid( 40e3, 130e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'H2O-*-556e9-557e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).L2NAME    = 'H2O / 557 GHz / 45 to 100 km';
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 40e3, 150e3, 4 );
  Q.ABS_SPECIES(1).UNC_REL   = 0.5;
  Q.ABS_SPECIES(1).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(1).CORRLEN   = 10e3;
  Q.ABS_SPECIES(1).LOG_ON    = true;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'O3-*-556e9-557e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 40e3, 130e3, 4 );
  Q.ABS_SPECIES(2).L2NAME    = 'O3 / 557 GHz / 45 to 90 km';
  Q.ABS_SPECIES(2).UNC_REL   = 0.5;
  Q.ABS_SPECIES(2).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(2).CORRLEN   = 10e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  %
  [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );  
  [Q.ABS_SPECIES.SOURCE]     = deal( 'Bdx' );
  %-------------------------------------------------------------------------
  
 case 14
  %
  Q.BACKEND_NR               = 2;
  Q.FRONTEND_NR              = 3;
  Q.F_LO_NOMINAL             = 572.762e9;
  Q.SIDEBAND_LEAKAGE         = 0.05;
  %
  Q.GA_START                 = 100;
  %
  Q.P_GRID                   = q2_pgrid( [], 150e3 );
  %
  Q.F_RANGES                 = [ 576.2e9 576.6e9 ];
  Q.ZTAN_LIMIT_TOP           = 150e3;
  Q.ZTAN_LIMIT_BOT           = [ 40e3 40e3 40e3 40e3 ];
  Q.ZTAN_MIN_RANGE           = [ 60e3 80e3 ];
  %
  Q.T.L2                     = true;
  Q.T.L2NAME                 = 'Temperature - 576 GHz';
  Q.T.GRID                   = q2_pgrid( 40e3, 150e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'CO-*-575e9-578e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 40e3, 150e3, 4 );
  Q.ABS_SPECIES(1).L2NAME    = 'CO / 576 GHz';
  Q.ABS_SPECIES(1).UNC_REL   = 1;
  Q.ABS_SPECIES(1).UNC_ABS   = 1e-8;
  Q.ABS_SPECIES(1).CORRLEN   = 8e3;
  Q.ABS_SPECIES(1).LOG_ON    = true;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'O3-*-575e9-578e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 40e3, 110e3, 4 );
  Q.ABS_SPECIES(2).L2NAME    = 'O3 / 576 GHz';
  Q.ABS_SPECIES(2).UNC_REL   = 0.5;
  Q.ABS_SPECIES(2).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(2).CORRLEN   = 10e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  %
  [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );
  [Q.ABS_SPECIES.SOURCE]     = deal( 'Bdx' );
  %-------------------------------------------------------------------------


 case 19
  %
  Q.BACKEND_NR               = 1;
  Q.FRONTEND_NR              = 4;
  Q.F_LO_NOMINAL             = 553.05e9;
  Q.SIDEBAND_LEAKAGE         = 0.05; 
  % 
  Q.GA_START                 = 1000;
  Q.GA_FACTOR_OK             = sqrt(10);
  %
  Q.P_GRID                   = q2_pgrid( [], 150e3 ); 
  %
  Q.F_RANGES                 = [ 556.6e9 557.2e9; ];
  Q.ZTAN_LIMIT_TOP           = 150e3;
  Q.ZTAN_LIMIT_BOT           = [ 40e3 40e3 40e3 40e3 ];
  Q.ZTAN_MIN_RANGE           = [ 45e3 80e3 ];
  %
  Q.T.L2                     = true;
  Q.T.L2NAME                 = 'Temperature - 557 (Fmode 19) - 45 to 90 km';
  Q.T.GRID                   = q2_pgrid( 40e3, 130e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'H2O-*-556e9-557e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).L2NAME    = 'H2O / 557 GHz / 45 to 100 km';
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 40e3, 150e3, 4 );
  Q.ABS_SPECIES(1).UNC_REL   = 0.5;
  Q.ABS_SPECIES(1).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(1).CORRLEN   = 10e3;
  Q.ABS_SPECIES(1).LOG_ON    = false;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'O3-*-556e9-557e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 40e3, 130e3, 4 );
  Q.ABS_SPECIES(2).L2NAME    = 'O3 / 557 GHz / 45 to 90 km';
  Q.ABS_SPECIES(2).UNC_REL   = 0.5;
  Q.ABS_SPECIES(2).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(2).CORRLEN   = 10e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  %
  [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );  
  [Q.ABS_SPECIES.SOURCE]     = deal( 'Bdx' );
  %-------------------------------------------------------------------------
  
  
 case 21
  %
  Q.BACKEND_NR               = 1;
  Q.FRONTEND_NR              = 4;
  Q.F_LO_NOMINAL             = 547.753e9;
  Q.SIDEBAND_LEAKAGE         = 0.05;
  %
  Q.P_GRID                   = q2_pgrid( [], 150e3 ); 
  %
  Q.F_RANGES                 = [ 551.13e9 551.58e9; ];
  Q.ZTAN_LIMIT_TOP           = 150e3;
  Q.ZTAN_LIMIT_BOT           = [ 40e3 40e3 40e3 40e3 ];
  Q.ZTAN_MIN_RANGE           = [ 60e3 80e3 ];
  %
  Q.T.L2                     = true;
  Q.T.LIMITS                 = [100 1000];
  Q.T.L2NAME                 = 'Temperature - 551 GHz - 45 to 65 km';
  Q.T.GRID                   = q2_pgrid( 40e3, 150e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'NO-*-541e9-562e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).L2NAME    = 'NO / 551 GHz / 45 to 115 km';
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 40e3, 150e3, 4 );
  Q.ABS_SPECIES(1).UNC_REL   = 1;
  Q.ABS_SPECIES(1).UNC_ABS   = 1e-8;
  Q.ABS_SPECIES(1).CORRLEN   = 6e3;
  Q.ABS_SPECIES(1).LOG_ON    = true;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'O3-*-541e9-562e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 40e3, 110e3, 4 );
  Q.ABS_SPECIES(2).L2NAME    = 'O3 / 551 GHz / 45 to 90 km';
  Q.ABS_SPECIES(2).UNC_REL   = 0.5;
  Q.ABS_SPECIES(2).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(2).CORRLEN   = 10e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  %
  [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );  
  [Q.ABS_SPECIES.SOURCE]     = deal( 'Bdx' );
  %-------------------------------------------------------------------------
  
 case 22
  %
  Q.BACKEND_NR               = 2;
  Q.FRONTEND_NR              = 3;
  Q.F_LO_NOMINAL             = 572.964e9;
  Q.SIDEBAND_LEAKAGE         = 0.05;
  %
  Q.GA_START                 = 100;
  %
  Q.P_GRID                   = q2_pgrid( [], 150e3 );
  %
  Q.F_RANGES                 = [ 576.2e9 576.6e9 ];
  Q.ZTAN_LIMIT_TOP           = 150e3;
  Q.ZTAN_LIMIT_BOT           = [ 40e3 40e3 40e3 40e3 ];
  Q.ZTAN_MIN_RANGE           = [ 45e3 80e3 ];
  %
  Q.T.L2                     = true;
  Q.T.L2NAME                 = 'Temperature - 576 GHz';
  Q.T.GRID                   = q2_pgrid( 40e3, 150e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'CO-*-575e9-578e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 40e3, 150e3, 4 );
  Q.ABS_SPECIES(1).L2NAME    = 'CO / 576 GHz';
  Q.ABS_SPECIES(1).UNC_REL   = 1;
  Q.ABS_SPECIES(1).UNC_ABS   = 1e-8;
  Q.ABS_SPECIES(1).CORRLEN   = 8e3;
  Q.ABS_SPECIES(1).LOG_ON    = true;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'O3-*-575e9-578e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 40e3, 110e3, 4 );
  Q.ABS_SPECIES(2).L2NAME    = 'O3 / 576 GHz';
  Q.ABS_SPECIES(2).UNC_REL   = 0.5;
  Q.ABS_SPECIES(2).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(2).CORRLEN   = 10e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  %
  [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );
  [Q.ABS_SPECIES.SOURCE]     = deal( 'Bdx' );
  %-------------------------------------------------------------------------
        
  case 24
   %
   Q.BACKEND_NR               = 1;
   Q.FRONTEND_NR              = 3;
   Q.F_LO_NOMINAL             = 572.762e9;
   Q.SIDEBAND_LEAKAGE         = 0.05;
   %
   Q.GA_START                 = 100;
   %
   Q.P_GRID                   = q2_pgrid( [], 150e3 );
   %
   Q.F_RANGES                 = [ 576.2e9 576.6e9 ];
   Q.ZTAN_LIMIT_TOP           = 150e3;
   Q.ZTAN_LIMIT_BOT           = [ 40e3 40e3 40e3 40e3 ];
   Q.ZTAN_MIN_RANGE           = [ 45e3 80e3 ];
   %
   Q.T.L2                     = true;
   Q.T.L2NAME                 = 'Temperature - 576 GHz';
   Q.T.GRID                   = q2_pgrid( 40e3, 150e3, 4 );
   %
   Q.ABS_SPECIES(1).TAG{1}    = 'CO-*-575e9-578e9';
   Q.ABS_SPECIES(1).RETRIEVE  = true;
   Q.ABS_SPECIES(1).L2        = true;
   Q.ABS_SPECIES(1).GRID      = q2_pgrid( 40e3, 150e3, 4 );
   Q.ABS_SPECIES(1).L2NAME    = 'CO / 576 GHz';
   Q.ABS_SPECIES(1).UNC_REL   = 1;
   Q.ABS_SPECIES(1).UNC_ABS   = 1e-8;
   Q.ABS_SPECIES(1).CORRLEN   = 8e3;
   Q.ABS_SPECIES(1).LOG_ON    = true;
   %
   Q.ABS_SPECIES(2).TAG{1}    = 'O3-*-575e9-578e9';
   Q.ABS_SPECIES(2).RETRIEVE  = true;
   Q.ABS_SPECIES(2).L2        = true;
   Q.ABS_SPECIES(2).GRID      = q2_pgrid( 40e3, 110e3, 4 );
   Q.ABS_SPECIES(2).L2NAME    = 'O3 / 576 GHz';
   Q.ABS_SPECIES(2).UNC_REL   = 0.5;
   Q.ABS_SPECIES(2).UNC_ABS   = 1e-6;
   Q.ABS_SPECIES(2).CORRLEN   = 10e3;
   Q.ABS_SPECIES(2).LOG_ON    = false;
   %
   [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );
   [Q.ABS_SPECIES.SOURCE]     = deal( 'Bdx' );
    
 otherwise
  error( 'Frequency band %d is not yet handled.', freqmode );
end
return




%---------------------------------------------------------------------------
%---------------------------------------------------------------------------
%---------------------------------------------------------------------------

function SB = sideband_settings( freqmode )

% General setings
%
SB = gf_empty( 3 );
%
SB.NAME       = sprintf( 'Sideband filter lookup table for fmode %d', freqmode );
SB.SOURCE     = mfilename; 
SB.DATA_NAME  = 'Primary band weight';
SB.DATA_NAME  = '[0-1]';
SB.GRID1_NAME = 'Frequency';
SB.GRID1_UNIT = 'Hz';
SB.GRID2_NAME = 'Temperature';
SB.GRID2_UNIT = 'K';
SB.GRID3_NAME = 'SBpath';
SB.GRID3_UNIT = 'm';


switch freqmode
  
  case 13
    %
    SB.GRID1 = [ 556.5 557 557.5 ]*1e9;  
    SB.GRID2 = [270 290];    
    SB.GRID3 = NaN;    
    %
    SB.DATA  = zeros( length(SB.GRID1), length(SB.GRID2), length(SB.GRID3) );
    %
    SB.DATA(:,1,1) = [ 0.04 0.02 0.01 ];
    SB.DATA(:,2,1) = [ 0.04 0.02 0.01 ];
    
  otherwise
    error( 'There are no detailed sideband settings for fmode %d.', freqmode );

end
return
