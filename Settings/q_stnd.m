% Q_STND   Settings for standard inversion mode
%
%   This function contains the settings used for operational "standard"
%   inversions. That is, don't modify without careful consideration.
%
%   The Q-fields are set according to selected frequency mode. The returned
%   Q is complete besides that all fields related to paths. These fields
%   should be set by *q_paths*.
%
% FORMAT   Q = q_stnd(freqmode)
%
% OUT   Q          A Q-structure (lacking path and version settings) 
%  IN   freqmode   Frequency mode number


function Q = q_stnd(freqmode)


%---------------------------------------------------------------------------
%--- Frequency and inversion modes
%---------------------------------------------------------------------------

Q.FREQMODE           = freqmode;  
Q.INVEMODE           = 'stnd';


%---------------------------------------------------------------------------
%--- Absorption tables
%---------------------------------------------------------------------------

Q.F_GRID_NFILL       = 0;
Q.ABS_P_INTERP_ORDER = 1;
Q.ABS_T_INTERP_ORDER = 3;
  
  
%---------------------------------------------------------------------------
%--- RT and sensor
%---------------------------------------------------------------------------

Q.REFRACTION_DO      = true;
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
Q.GA_START           = 1;
Q.GA_FACTOR_NOT_OK   = 10;
Q.GA_FACTOR_OK       = 10;
Q.GA_MAX             = 1e4;


%---------------------------------------------------------------------------
%--- Common retrieval settings
%---------------------------------------------------------------------------

Q.NOISE_CORRMODEL    = 'expo';  % 'none', 'empi' 'expo'

Q.ZTAN_LIMIT_BOT     = [ 19e3 19e3 14e3 10e3 ];

Q.BASELINE.RETRIEVE  = true;
Q.BASELINE.MODEL     = 'adaptive';  % 'common', 'module', 'adaptive'
Q.BASELINE.UNC       = 2;

Q.POINTING.RETRIEVE  = false;
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
Q.QFILT_SPECTRA      = false;
Q.QFILT_TBRANGE      = true;
Q.QFILT_TINT         = true;
Q.QFILT_REF1         = false;
Q.QFILT_REF2         = false;
Q.QFILT_MOON         = true;
Q.QFILT_LAG0MAX      = 1;

Q.MIN_N_SPECTRA      = 8;
Q.MIN_N_FREQS        = 200;



%---------------------------------------------------------------------------
%--- Band specific
%---------------------------------------------------------------------------

switch freqmode
  
 case 1
  %
  Q.BACKEND_NR               = 2;
  Q.FRONTEND_NR              = 2;
  Q.F_LO_NOMINAL             = 497.885e9;
  Q.SIDEBAND_LEAKAGE         = 0.02;
  %
  Q.P_GRID                   = q2_pgrid( [], 70e3 ); 
  %
  Q.F_RANGES                 = [ 501.16e9 501.60e9; 501.96e9 502.40e9 ];
  Q.ZTAN_LIMIT_TOP           = 60e3;
  Q.ZTAN_MIN_RANGE           = [ 25e3 40e3 ];
  %
  Q.T.L2                     = false;
  Q.T.GRID                   = q2_pgrid( 10e3, 65e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'ClO-*-498e9-505e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).L2NAME    = 'ClO / 501 GHz / 20 to 55 km';
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 10e3, 70e3, 4 );
  Q.ABS_SPECIES(1).UNC_REL   = 0.5;
  Q.ABS_SPECIES(1).UNC_ABS   = 2.5e-10;
  Q.ABS_SPECIES(1).CORRLEN   = 5e3;
  Q.ABS_SPECIES(1).LOG_ON    = false;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'N2O-*-491e9-512e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).L2NAME    = 'N2O / 502 GHz / 15 to 50 km';
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 10e3, 70e3, 8 );
  Q.ABS_SPECIES(2).UNC_REL   = 0.25;
  Q.ABS_SPECIES(2).UNC_ABS   = 20e-9;
  Q.ABS_SPECIES(2).CORRLEN   = 5e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  %
  Q.ABS_SPECIES(3).TAG{1}    = 'O3-666-491e9-512e9';
  Q.ABS_SPECIES(3).RETRIEVE  = true;
  Q.ABS_SPECIES(3).L2        = true;
  Q.ABS_SPECIES(3).GRID      = q2_pgrid( 10e3, 70e3, 8 );
  Q.ABS_SPECIES(3).L2NAME    = 'O3 / 501 GHz / 20 to 50 km';
  Q.ABS_SPECIES(3).UNC_REL   = 0.5;
  Q.ABS_SPECIES(3).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(3).CORRLEN   = 5e3;
  Q.ABS_SPECIES(3).LOG_ON    = false;
  %
  Q.ABS_SPECIES(4).TAG{1}    = 'O3-668-498e9-505e9';
  Q.ABS_SPECIES(4).RETRIEVE  = true;
  Q.ABS_SPECIES(4).L2        = false;
  Q.ABS_SPECIES(4).GRID      = q2_pgrid( 10e3, 70e3, 4 );
  Q.ABS_SPECIES(4).L2NAME    = 'O3-dummy / 501 GHz';
  Q.ABS_SPECIES(4).UNC_REL   = 0.5;
  Q.ABS_SPECIES(4).UNC_ABS   = 0.5e-6;
  Q.ABS_SPECIES(4).CORRLEN   = 10e3;
  Q.ABS_SPECIES(4).LOG_ON    = true;
  %
  Q.ABS_SPECIES(5).TAG{1}    = 'O3-667-498e9-505e9';
  Q.ABS_SPECIES(5).RETRIEVE  = true;
  Q.ABS_SPECIES(5).L2        = false;
  Q.ABS_SPECIES(5).GRID      = q2_pgrid( 10e3, 70e3, 4 );
  Q.ABS_SPECIES(5).L2NAME    = 'O3-dummy / 501 GHz';
  Q.ABS_SPECIES(5).UNC_REL   = 0.5;
  Q.ABS_SPECIES(5).UNC_ABS   = 0.5e-6;
  Q.ABS_SPECIES(5).CORRLEN   = 10e3;
  Q.ABS_SPECIES(5).LOG_ON    = true;
  %
  Q.ABS_SPECIES(6).TAG{1}    = 'H2O-*-400e9-650e9';
  Q.ABS_SPECIES(6).TAG{2}    = 'H2O-ForeignContStandardType';
  Q.ABS_SPECIES(6).TAG{3}    = 'H2O-SelfContStandardType';
  Q.ABS_SPECIES(6).RETRIEVE  = true;
  Q.ABS_SPECIES(6).L2        = false;
  Q.ABS_SPECIES(6).GRID      = q2_pgrid( 10e3, 30e3, 4 );
  Q.ABS_SPECIES(6).L2NAME    = 'H2O-dummy / 501 GHz';
  Q.ABS_SPECIES(6).UNC_REL   = 0.5;
  Q.ABS_SPECIES(6).UNC_ABS   = 2e-6;
  Q.ABS_SPECIES(6).CORRLEN   = 10e3;
  Q.ABS_SPECIES(6).LOG_ON    = true;
  %
  Q.ABS_SPECIES(7).TAG{1}    = 'N2-SelfContMPM93';
  Q.ABS_SPECIES(7).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(8).TAG{1}    = 'O2-*-400e9-650e9';
  Q.ABS_SPECIES(8).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(9).TAG{1}    = 'HNO3-*-498e9-505e9';
  Q.ABS_SPECIES(9).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(10).TAG{1}   = 'CH3Cl-*-498e9-505e9';
  Q.ABS_SPECIES(10).RETRIEVE = false;
  %
  Q.ABS_SPECIES(11).TAG{1}   = 'H2O2-*-498e9-505e9';
  Q.ABS_SPECIES(11).RETRIEVE = false;
  %
  [Q.ABS_SPECIES.ISOFAC]     = deal( 1 );  
  [Q.ABS_SPECIES.SOURCE]     = deal( 'WebApi' );
  %-------------------------------------------------------------------------

    
 case 2
  %
  Q.BACKEND_NR               = 1;
  Q.FRONTEND_NR              = 4;
  Q.F_LO_NOMINAL             = 548.500e9;
  Q.SIDEBAND_LEAKAGE         = 0.05;
  %
  Q.P_GRID                   = q2_pgrid( [], 120e3 ); 
  %
  Q.F_RANGES                 = [544.3e9 544.9e9];
  Q.ZTAN_LIMIT_TOP           = 100e3;
  Q.ZTAN_MIN_RANGE           = [ 25e3 40e3 ];
  %
  Q.T.L2                     = true; 
  Q.T.L2NAME                 = 'Temperature / 545 GHz / 15 to 65 km';
  Q.T.GRID                   = q2_pgrid( 10e3, 100e3, 4 );
  %
  Q.ABS_SPECIES(1).TAG{1}    = 'O3-666-534e9-556e9';
  Q.ABS_SPECIES(1).RETRIEVE  = true;
  Q.ABS_SPECIES(1).L2        = true;
  Q.ABS_SPECIES(1).L2NAME    = 'O3 / 545 GHz / 20 to 85 km';
  Q.ABS_SPECIES(1).GRID      = q2_pgrid( 10e3, 110e3, 8 );
  Q.ABS_SPECIES(1).UNC_REL   = 0.5;
  Q.ABS_SPECIES(1).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(1).CORRLEN   = 6e3;
  Q.ABS_SPECIES(1).LOG_ON    = false;
  Q.ABS_SPECIES(1).ISOFAC    = 1;
  %
  Q.ABS_SPECIES(2).TAG{1}    = 'HNO3-*-534e9-554e9';
  Q.ABS_SPECIES(2).RETRIEVE  = true;
  Q.ABS_SPECIES(2).L2        = true;
  Q.ABS_SPECIES(2).L2NAME    = 'HNO3 / 545 GHz / 20 to 50 km';
  Q.ABS_SPECIES(2).GRID      = q2_pgrid( 10e3, 70e3, 4 );
  Q.ABS_SPECIES(2).UNC_REL   = 0.5;
  Q.ABS_SPECIES(2).UNC_ABS   = 1e-9;
  Q.ABS_SPECIES(2).CORRLEN   = 10e3;
  Q.ABS_SPECIES(2).LOG_ON    = false;
  Q.ABS_SPECIES(2).ISOFAC    = 1;
  %
  Q.ABS_SPECIES(3).TAG{1}    = 'O3-668-534e9-556e9';
  Q.ABS_SPECIES(3).RETRIEVE  = true;
  Q.ABS_SPECIES(3).L2        = true;
  Q.ABS_SPECIES(3).L2NAME    = 'O3-668 / 545 GHz / 25 to 45 km';
  Q.ABS_SPECIES(3).GRID      = q2_pgrid( 10e3, 70e3, 4 );
  Q.ABS_SPECIES(3).UNC_REL   = 0.5;
  Q.ABS_SPECIES(3).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(3).CORRLEN   = 6e3;
  Q.ABS_SPECIES(3).LOG_ON    = false;
  Q.ABS_SPECIES(3).ISOFAC    = 3.98194e-03;
  %
  Q.ABS_SPECIES(4).TAG{1}    = 'H2O-*-444e9-646e9';
  Q.ABS_SPECIES(4).TAG{2}    = 'H2O-ForeignContStandardType';
  Q.ABS_SPECIES(4).TAG{3}    = 'H2O-SelfContStandardType';
  Q.ABS_SPECIES(4).RETRIEVE  = true;
  Q.ABS_SPECIES(4).L2        = true;
  Q.ABS_SPECIES(4).L2NAME    = 'H2O / 545 GHz / 15 to 30 km';
  Q.ABS_SPECIES(4).GRID      = q2_pgrid( 10e3, 40e3, 4 );
  Q.ABS_SPECIES(4).UNC_REL   = 0.5;
  Q.ABS_SPECIES(4).UNC_ABS   = 1e-6;
  Q.ABS_SPECIES(4).CORRLEN   = 10e3;
  Q.ABS_SPECIES(4).LOG_ON    = false;
  Q.ABS_SPECIES(4).ISOFAC    = 1;
  %  
  Q.ABS_SPECIES(5).TAG{1}    = 'N2-SelfContMPM93';
  Q.ABS_SPECIES(5).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(6).TAG{1}    = 'O2-*-444e9-644e9';
  Q.ABS_SPECIES(6).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(7).TAG{1}    = 'O3-*-534e9-554e9';
  Q.ABS_SPECIES(7).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(8).TAG{1}    = 'N2O-*-534e9-554e9';
  Q.ABS_SPECIES(8).RETRIEVE  = false;
  %
  Q.ABS_SPECIES(9).TAG{1}    = 'H2O2-*-534e9-554e9';
  Q.ABS_SPECIES(9).RETRIEVE  = false;
  %
  [Q.ABS_SPECIES.SOURCE]     = deal( 'WebApi' );
  %-------------------------------------------------------------------------
  
  
 otherwise
  error( 'Frequency band %d is not yet handled (or not defined).', freqmode );
end
