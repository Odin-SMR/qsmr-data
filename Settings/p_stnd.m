% P_STD   Precalculation settings
%
%    Note that the pre-calculations use settings in both P and Q. See
%    comments (and code) in the pre-calculation functions.
%
% FORMAT P = p_std( [meso] )
%
% OUT  P     Pre-calculation settings
% OPT  meso  Boolean to select settings dedicated for mesopsheric
%            retrievals. Default is false.

function P = p_stnd( meso )
%
if nargin == 0
  meso = false;
end

  
%-------------------------------------------------------------------------------
%- Bdx a priori database
%-------------------------------------------------------------------------------

% Where to find original files (as used in Qsmr1)
P.BDX_DATA_INFOLDER = '/home/patrick/Projects/SMR/Qsmr/Input/Climatologies/Bdx';



%-------------------------------------------------------------------------------
%- Antenna
%-------------------------------------------------------------------------------

% What integration times to consider
P.INTEGRATION_TIMES = [ 0.86 1.86 3.86 ];



%-------------------------------------------------------------------------------
%- Backend
%-------------------------------------------------------------------------------

% What channels frequency spacings to consider
P.BACKEND_FSPACINGS = [ 1/8 1 ]*1e6;



%-------------------------------------------------------------------------------
%- Reference atmospheres and spectra
%-------------------------------------------------------------------------------

% These three fields specify a set of date and position combinations. All three
% vectors must have the same length. The exact atmospheric states depend on
% settings in O, such as O.T_SOURCE. The first state is used as reference when
% calculating absorption lookup tables. All states are used when generating
% frequency grids.
P.REFSPECTRA_LAT    = [ 40 -80:40:0 80 ];
P.REFSPECTRA_LON    = repmat( 0, size(P.REFSPECTRA_LAT) );
P.REFSPECTRA_MJD    = repmat( date2mjd(2000,1,1)+34, size(P.REFSPECTRA_LAT) );

% A set of tangent altitudes, considered when generating frequency grids.
if ~meso
  P.REFSPECTRA_ZTAN   = 15e3 : 5e3 : 90e3; 
else
  P.REFSPECTRA_ZTAN   = 45e3 : 5e3 : 105e3;     
end


%-------------------------------------------------------------------------------
%- F_GRID
%-------------------------------------------------------------------------------

% Frequency spacing of reference spectra
P.FGRID_TEST_DF     = 100e3;

% How much frequency margin to add, to both primary and image band
P.FGRID_EDGE_MARGIN = 20e6;



%-------------------------------------------------------------------------------
%- Absorption lookup tables
%-------------------------------------------------------------------------------

inputfolder     = fullfile( q2data_topfolder, 'DataInput', 'Absorption' );

% File holding description of absorption continua and models
P.CONTINUA_FILE = fullfile( inputfolder, 'continua_std.arts' );

% File holding partition functions
P.PARTITION_FILE = fullfile( inputfolder, 'tips.xml' );

% File holding all spectroscopy data
P.SPECTRO_FILE  = fullfile( inputfolder, 'smr_linedata.xml' );

% The set of temperature perturbations
%
% The mimimum value of the lookup table reference temperature is about 180
% K, and the reference temperature is not allowed to go above 300 K. You 
% should adopt ABS_T_PERT accordingly.
%
P.ABS_T_PERT    = [ symgrid( [0:10:100 120 160] ), 220 300 400 600 900 ]';
