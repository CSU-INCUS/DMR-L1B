%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute_TA_DMR.m
% 
% This script calculates DMR TA, two point, and single point calibrated
% options. Not including filtering for now
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rad = compute_TA_DMR(d,c,rad,cal)

% initialize
rad.TA_tp.data = NaN([length(d.s.TIMESTAMP) 5]);
rad.TA_spWL.data = NaN([length(d.s.TIMESTAMP) 5]);
rad.TA_spCS.data = NaN([length(d.s.TIMESTAMP) 5]);

% loop through channels
for ch = 1:5
    
    % two point calibrated TA
    calADC = interp1(cal.time.data',cal.adcWL_m.data(:,ch),d.s.TIMESTAMP);% mean WL counts interpolated to obs time
    calADCcs = interp1(cal.time.data',cal.adcCS_m.data(:,ch),d.s.TIMESTAMP);% mean CS counts interpolated to obs time
    
    calGain = interp1(cal.time.data',cal.gain.data(:,ch),d.s.TIMESTAMP);% gain interpolated to obs time
    calTarTemps = interp1(cal.time.data',cal.TcalWL.data(:,ch),d.s.TIMESTAMP);% mean of WL target
    calTBcs = interp1(cal.time.data',cal.TcalCS.data(:,ch),d.s.TIMESTAMP);% mean of cold sky
    if(ch==1)
        current_ADC = d.s.ADC0;
    elseif(ch==2)
        current_ADC = d.s.ADC1;
    elseif(ch==3)
        current_ADC = d.s.ADC2;
    elseif(ch==4)
        current_ADC = d.s.ADC3;
    else
        current_ADC = d.s.ADC4;
    end
    rad.TA_tp.data(:,ch) = (current_ADC-calADC)./calGain + calTarTemps;

    % get a parameterized Trx based on an instrument temperature
    if(ch ==1)
        inst_temp = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT5,d.s.TIMESTAMP,'linear','extrap');
    else
        inst_temp = interp1(d.h.TIMESTAMP,d.h.THERM_COUNT4,d.s.TIMESTAMP,'linear','extrap');
    end
    rad.trx.data(:,ch) = interp1(c.param_Trx_x(ch,:),c.param_Trx_y(ch,:),inst_temp); %temperature dependence

    % single point calibration using WL
    rad.TA_spWL.data(:,ch) = (current_ADC./calADC-1).*rad.trx.data(:,ch) + current_ADC./calADC.*calTarTemps;

    % single point calibration using CS
    rad.TA_spCS.data(:,ch) = (current_ADC./calADCcs-1).*rad.trx.data(:,ch) + current_ADC./calADCcs.*calTBcs;

end

rad.TA_tp.longname = 'Two-Point Calibrated antenna temperature';
rad.TA_tp.units = 'K';

rad.trx.longname = 'Receiver Noise Temperature (K) (based-on temperature parameterization)';
rad.trx.units = 'K';

rad.TA_spWL.longname = 'Single-Point Calibrated antenna temperature, based on warm load';
rad.TA_spWL.units = 'K';

rad.TA_spCS.longname = 'Single-Point Calibrated antenna temperature, based on cold sky';
rad.TA_spCS.units = 'K';
