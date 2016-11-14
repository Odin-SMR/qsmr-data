% Q2_PRECALC_ABSLOOKUP
%
%    Atmospheric data are hard-coded to be taken from the local version of the
%    Bdx database (Q.ABS_SPECIES.SOURCE = 'Bdx') and MSIS90 (Q.T_SOURCE =
%    'MSIS90').
%
% FORMAT   q2_precalc_abslookup(QQ,P,workfolder,precs)
%        
% IN    QQ      An array of Q structures
%       P       A P structure
%       workfolder   Folder to use for running ARTS.
% OPT   precs        Vector of precision limits [K]. Default is 200 mK.
%       do_cubic Flag to use f_grid assuming cubic interpolation. Default is false.

% 2015-05-25   Created by Patrick Eriksson.

function q2_precalc_abslookup(QQ,P,workfolder,varargin)
%
[precs,do_cubic] = optargs( varargin, { 0.2, false } );


%- Check folder and file names
%
for i = 1 : length( QQ )
  for j = 1 : length( precs )
    
    [outfolder,outfile] = create_folderfile( QQ(i), precs(j), do_cubic );
    
    if ~exist( outfolder, 'dir' )
      error( 'The following folder does not exist: %s', outfolder );
    end
    if exist( outfile )
      error( 'The following file does already exist: %s', outfile );
    end
    
  end
end


%- Loop all fmodess
%
for i = 1 : length( QQ )

  for j = 1 : length( precs )
  
    A = do_1fmode( QQ(i), P, workfolder, precs(j), do_cubic );

    [outfolder,outfile] = create_folderfile( QQ(i), precs(j), do_cubic );    
    
    xmlStore( outfile, A, 'GasAbsLookup', 'binary' );

    %- Create a simple README
    %
    fid = fopen( fullfile( outfolder, 'README' ), 'w' );
    fprintf( fid, 'The absorption lookup table files in this folder were\n' );
    fprintf( fid, sprintf( 'created by the function *%s*.', mfilename ) );
    fclose( fid );  
  end
end
return
%--------------------------------------------------------------------------


function A = do_1fmode( Q, P, workfolder, prec, do_cubic )

  %- Hard-coded Q settings
  % 
  Q.T.SOURCE             = 'MSIS90';
  [Q.ABS_SPECIES.SOURCE] = deal( 'Bdx' ); 
    
    
  % Table is calculated for atmospheric state behind first reference spectrum
  LOG = l1b_homemade( Q, 30e3, P.REFSPECTRA_LAT(1), ...
                      P.REFSPECTRA_LON(1), P.REFSPECTRA_MJD(1) );
  ATM =  q2_get_atm( LOG, Q );

  C.ABSORPTION     = 'CalcTable';
  C.PARTITION_FILE = P.PARTITION_FILE;
  C.CONTINUA_FILE  = P.CONTINUA_FILE;
  C.SPECTRO_FILE   = P.SPECTRO_FILE;
  C.SPECTRO_FMIN   = 0;
  C.SPECTRO_FMAX   = 2e12;
  C.REFRACTION_DO  = false;
  C.SPECIES        = arts_tgs_cnvrt( Q.ABS_SPECIES );
  C.R_EARTH        = earth_radius;

  fgridfile = whichfiles( sprintf( 'fgrid_fmode%02d*.xml', Q.FREQMODE ), ...
                          Q.FOLDER_FGRID );
  if length(fgridfile) == 0
    error( 'No fgrid-file was found for fmode %d.', Q.FREQMODE );
  elseif length(fgridfile) > 1
    error( 'Multiple fgrid-file were found for fmode %d.', Q.FREQMODE );
  end
  f_grid    = xmlLoad( fgridfile{1} );
  %
  xmlStore( fullfile( workfolder, 'f_grid.xml' ), f_grid, ...
                                                        'Vector', 'binary' );
  xmlStore( fullfile( workfolder, 'p_grid.xml' ), Q.P_GRID, ...
                                                        'Vector', 'binary' );
  % We set an upper limit on abs_t! This helps to handle the thermosphere.
  tlim   = 300;
  t_grid = ATM.T;
  t_grid(find(t_grid>tlim)) = tlim;
  %
  xmlStore( fullfile( workfolder, 'abs_t.xml' ), t_grid, ...
                                                         'Vector', 'binary' );
  xmlStore( fullfile( workfolder, 'abs_t_pert.xml' ), P.ABS_T_PERT, ...
                                                         'Vector', 'binary' );
  xmlStore( fullfile( workfolder, 'abs_vmrs.xml' ), ATM.VMR, ...
                                                         'Matrix', 'binary' );
  %
  cfile  = q2_artscfile_full( C, workfolder );
  %
  status = q2_arts( Q, cfile );
  A      = xmlLoad( fullfile( workfolder, 'abs_lookup.xml' ) );
  
return
%--------------------------------------------------------------------------

  
  
function [outfolder,outfile] = create_folderfile( Q, precs, do_cubic );

  outfolder = Q.FOLDER_ABSLOOKUP;

  outfile = fullfile( outfolder, sprintf( 'abslookup_fmode%02d.xml', ...
                                                            Q.FREQMODE ) );
return
%--------------------------------------------------------------------------
