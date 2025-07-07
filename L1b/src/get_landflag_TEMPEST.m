function rad = get_landflag_TEMPEST(rad,c,land_mask_path)

A = textread(land_mask_path);
[lonx,latx] = size(A);

A = reshape(A,numel(A),1);

%%% boresight
rad.landmask.data=nan(size(rad.blat.data));
ind = find(abs(rad.blat.data)<90 & ~isnan(rad.blat.data));
[xs,ys] = size(rad.blat.data(ind));
latr = floor((reshape(rad.blat.data(ind),xs*ys,1)+90)*latx./180)+1;
lonr = reshape(rad.blon.data(ind),xs*ys,1);lonr = lonr + (lonr<0)*360;
lonr = floor(lonr.*lonx./360)+1;

rad.landmask.data(ind) = reshape(A((latr-1)*lonx + lonr),xs,ys);
rad.landmask.longname = 'Ocean=0, Inland Water=1, Land=3 - resolution is 2 minutes';
rad.landmask.units = '/';

%%% spacecraft
rad.landmaskSC.data=nan(size(rad.SClat.data));
ind = find(abs(rad.SClat.data)<90 & ~isnan(rad.SClat.data));

[xs,ys] = size(rad.SClat.data(ind));
latr = floor((reshape(rad.SClat.data(ind),xs*ys,1)+90)*latx./180)+1;
lonr = reshape(rad.SClon.data(ind),xs*ys,1);lonr = lonr + (lonr<0)*360;
lonr = floor(lonr.*lonx./360)+1;

rad.landmaskSC.data(ind) = reshape(A((latr-1)*lonx + lonr),xs,ys);
rad.landmaskSC.longname = 'Ocean=0, Inland Water=1, Land=3 - resolution is 2 minutes';
rad.landmaskSC.units = '/';

%%% scene
rad.scene.data=rad.scanang.data.*0;
tmp = rad.landmask.data+2;
tmp(isnan(tmp))=1;
rad.scene.data=rad.scene.data+tmp;
rad.scene.data(rad.bhorz.data>5)=0;
rad.scene.longname = 'Scene code (0=cold sky,1=limb, 2=ocean, 5=land)' ;
rad.scene.units = '/';

%%% earth inc flag
rad.earth_inc_flag.data = zeros(size(rad.scanang.data));
rad.earth_inc_flag.data(rad.earth_inc_flag.data>c.EIA_max) = 1;
rad.earth_inc_flag.longname = 'Earth Incidence Angle Flag, Earth incidence angle too oblique (0=acceptable).';
clear latr lonr A lonx latx xs ys