function rad = define_geo_var_DMR(rad)

rad.SClat.data = nan(length(rad.UTCtime.data),1);
rad.SClat.longname = 'Sub-spacecraft latitude at radiometer sample rate';
rad.SClat.units = 'degrees';

rad.SClon.data = nan(length(rad.UTCtime.data),1);
rad.SClon.longname = 'Sub-spacecraft longitude at radiometer sample rate';
rad.SClon.units = 'degrees';

rad.SCalt.data = nan(length(rad.UTCtime.data),1);
rad.SCalt.longname = 'Spacecraft altitude at radiometer sample rate';
rad.SCalt.units = 'km';

rad.SCinc.data = nan(length(rad.UTCtime.data),1);
rad.SCinc.longname = 'Spacecraft off-nadir pointing angle from center of Earth';
rad.SCinc.units = 'degrees';

rad.blat.data = nan(length(rad.UTCtime.data),1);
rad.blat.longname = 'Boresight latitude at radiometer sample rate';
rad.blat.units = 'degrees';

rad.blon.data = nan(length(rad.UTCtime.data),1);
rad.blon.longname = 'Boresight longitude at radiometer sample rate';
rad.blon.units = 'degrees';

rad.binc.data = nan(length(rad.UTCtime.data),1);
rad.binc.longname = 'Boresight incidence angle at radiometer sample rate';
rad.binc.units = 'degrees';

rad.belev.data = nan(length(rad.UTCtime.data),1);
rad.belev.longname = 'Angle between boresight and center of Earth';
rad.belev.units = 'degrees';

rad.bhorz.data = nan(length(rad.UTCtime.data),1);
rad.bhorz.longname = 'Angle between boresight and Earth horizon';
rad.bhorz.units = 'degrees';

rad.asds.data = nan(length(rad.UTCtime.data),1);%= interp1(sc.UTCtime.data, sc.asds.data, rad.UTCtime.data, 'nearest');
rad.asds.longname = 'Ascending/Descending flag (asc=1,dsc=0)';
rad.asds.units = '/';

rad.SCyaw.data = [];
rad.SCyaw.longname = 'Spacecraft orientation: counter-clockwise rotation about the S/C z-axis';
rad.SCyaw.units = 'degree';

rad.SCroll.data = [];
rad.SCroll.longname = 'Spacecraft orientation: counter-clockwise rotation about the S/C x-axis';
rad.SCroll.units = 'degree';

rad.SCpitch.data = [];
rad.SCpitch.longname = 'Spacecraft orientation: counter-clockwise rotation about the S/C y-axis';
rad.SCpitch.units = 'degree';