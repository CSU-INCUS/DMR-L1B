function rad = compute_TB_DMR(d,c,rad)

rad.TB.data=nan(size(rad.TA_tp.data));
for ch = 1:5
    calTargetTemps = [d.h.THERM_COUNT0 d.h.THERM_COUNT1 d.h.THERM_COUNT2];
    TWL = nanmean(calTargetTemps,2);

    % assume tp data will be default TB
    ind = find(rad.TA_tp.data(:,ch) ~= c.fill_val);
    CSf = polyval(c.coefSCf(:,ch),rad.scanang.data(ind));
    rad.TB.data(ind,ch) = (rad.TA_tp.data(ind,ch) - (1-CSf).*TWL)./CSf;
    
    % sp warm load
    ind = find(rad.TA_spWL.data(:,ch) ~= c.fill_val);
    CSf = polyval(c.coefSCf(:,ch),rad.scanang.data(ind));
    rad.TB_spWL.data(ind,ch) = (rad.TA_spWL.data(ind,ch) - (1-CSf).*TWL)./CSf;

    % sp cold sky
    ind = find(rad.TA_spCS.data(:,ch) ~= c.fill_val);
    CSf = polyval(c.coefSCf(:,ch),rad.scanang.data(ind));
    rad.TB_spCS.data(ind,ch) = (rad.TA_spCS.data(ind,ch) - (1-CSf).*TWL)./CSf;
end

rad.TB.longname = 'Calibrated brightness temperature based on two-point calibration';
rad.TB.units = 'K';

rad.TB_spWL.longname = 'Calibrated brightness temperature based on single-point warm load calibration';
rad.TB_spWL.units = 'K';

rad.TB_spCS.longname = 'Calibrated brightness temperature based on single-point cold sky calibration';
rad.TB_spCS.units = 'K';