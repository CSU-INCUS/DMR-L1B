function sc = define_sc_var_DMR(sc)
% Spacecraft information at its sample rate
sc.ECI.data = []; %x,y,z position in ECI frame in km
sc.ECI.longname = 'x,y,z position in ECI frame';
sc.ECI.units = 'km';

sc.Q_ECI.data = [];  %S/C body orientation quaterion in ECI frame
sc.Q_ECI.longname = 'S/C body orientation quaterion in ECI frame';
sc.Q_ECI.units = '\';

sc.R_ECI.data = [];  %S/C body orientation quaterion in ECI frame
sc.R_ECI.longname = 'S/C body orientation rotation matrix in ECI frame';
sc.R_ECI.units = '\';

sc.UTCtime.data = []; %this is in matlab format now
sc.UTCtime.longname = 'UTC time of spacecraft telmetry';
sc.UTCtime.units = 's';

sc.lat.data = [];
sc.lat.longname = 'Sub-spacecraft latitude';
sc.lat.units = 'degrees';

sc.lon.data = [];
sc.lon.longname = 'Sub-spacecraft longitude';
sc.lon.units = 'degrees';

sc.alt.data = [];
sc.alt.longname = 'Spacecraft altitude';
sc.alt.units = 'km';

sc.asds.data=[];
sc.asds.longname = 'Ascending/Descending flag (asc=1,dsc=0)';
sc.asds.units = '/';

sc.yaw.data = [];
sc.yaw.longname = 'Counter-clockwise rotation about the S/C z-axis';
sc.yaw.units = 'degree';

sc.roll.data = [];
sc.roll.longname = 'Counter-clockwise rotation about the S/C x-axis';
sc.roll.units = 'degree';

sc.pitch.data = [];
sc.pitch.longname = 'Counter-clockwise rotation about the S/C y-axis';
sc.pitch.units = 'degree';

sc.R_ECI_LVL.data = [];
sc.R_ECI_LVL.longname = 'S/C body orientation rotation matrix for level flight in ECI frame';
sc.R_ECI_LVL.units = '/';

