% TEST1SPECIES   Test impact of species in a band
%
%   This is a simple help function to estimate impact of a species on a
%   frequency mode. Pencil beam spectra are calculated for given tangent
%   altitudes, latitude and DOY. No sideband filtering factor is included,
%   i.e. 100% contribution from primary or image band is assumed.
%
%   Only transitions relatively close to the band are considered 
%   (see q2_arts_y for range included).
%
% FORMAT [F,Y] = test1species( Q, ztans, lat, doy, species [,do_imageband] )
%
% OUT   F   Frequencies matching Y
%       Y   Simulated spectra.
% IN    Q        Q structure for fmode
%       ztans    Vector with tangent altitudes
%       lat      Latitude
%       doy      Day of the year
%       species  Species tag string, e.g. 'O3-668'
% OPT   do_imageband  Boolean to set if primary or amge band shall be
%                     simulated. Default is false (i.e. primary band is default).

% 2016-02-20   Patrick Eriksson

function [F,Y] = test1species( Q, ztans, lat, doy, species, do_imageband )

Q.ABS_SPECIES             = [];
Q.ABS_SPECIES(1).TAG{1}   = species;
Q.ABS_SPECIES(1).SOURCE   = 'Bdx';
Q.ABS_SPECIES(1).RETRIEVE = false;

Q.T.SOURCE                = 'MSIS90';


[LOG,L1B] = l1b_homemade( Q, ztans, lat, 0, date2mjd(2010,1,1)+doy );

if nargin > 5  &  do_imageband
  L1B.Frequency.IFreqGrid = sort( -L1B.Frequency.IFreqGrid );
end


ATM = q2_get_atm( LOG, Q );


[Y,F] = q2_arts_y( L1B, ATM, Q, false, false );

plot( F/1e9, Y, '.' )
xlabel( 'Frequency [GHz]' );
ylabel( 'Tb [K]' );