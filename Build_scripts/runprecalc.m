% Run precalc to generate abs lookup data for an invemode and freqmode.
function []=runprecalc(out_path, invemode, freqmode)
   freqmode = str2num(freqmode)
   disp(sprintf('Using Q config with freqmode %d and invmode %s', ...
                freqmode, invemode));

   Q = eval(sprintf('q_%s(%d)', invemode, freqmode));
   Q = q_paths( Q );
   Q = q_versions( Q );
   
   P = p_stnd

   % Fix paths
   Q.ARTS               = 'LD_LIBRARY_PATH="" arts';
   Q.FOLDER_WORK        = '/tmp';

   datadir              = '/QsmrData';

   investr              = Q.INVEMODE;
   investr(1)           = upper( investr(1) );
   investr(2:end)       = lower( investr(2:end) );

   Q.FOLDER_ABSLOOKUP   = fullfile( out_path, 'AbsLookup', investr);

   Q.FOLDER_FGRID       = fullfile( datadir, 'DataPrecalced', ...
                                    'Fgrid', investr );
   Q.FOLDER_ANTENNA     = fullfile( datadir, 'DataPrecalced', 'Antenna' );
   Q.FOLDER_BACKEND     = fullfile( datadir, 'DataPrecalced', 'Backend' );
   Q.FOLDER_BDX         = fullfile( datadir, 'DataPrecalced', ...
                                    'SpeciesApriori', 'Bdx' );

   Q.FOLDER_MSIS90      = fullfile( datadir, 'DataInput', ...
                                    'Temperature');
   
   inputfolder = fullfile(datadir, 'DataInput', 'Absorption');
   P.CONTINUA_FILE = fullfile( inputfolder, 'continua_std.arts' );
   P.PARTITION_FILE = fullfile( inputfolder, 'tips.xml' );
   P.SPECTRO_FILE  = fullfile( inputfolder, 'smr_linedata.xml' );

   q2_precalc_abslookup(Q, P, '/tmp');
   save(fullfile(out_path, 'Q.mat'), 'Q');

exit(0);
