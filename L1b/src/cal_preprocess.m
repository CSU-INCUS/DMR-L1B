%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cal_preprocess.m
% 
% Mary Morris
%
% This code processes the user specifed data assuming that we are operating
% in rotating mode 
% outputs will be used to calculate TA etc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [calWL,calCS,cal] = cal_preprocess(d,c,rad)
%% set flag to assume we will get through pre processing
cal.process_abort.data = 0;

%% get warm cal target temperature
calTargetTemps = [d.h.THERM_COUNT0 d.h.THERM_COUNT1 d.h.THERM_COUNT2];
TWL = nanmean(calTargetTemps,2).*c.WLf+c.Tsky*(1-c.WLf);

%% get cold sky temperature
TCS = NaN([length(TWL),5]);
for ch = 1:5
    CSfi = polyval(c.coefSCf(:,ch),rad.scanang.data);
    % interp CSf at housekeeping times
    CSf = interp1(d.s.TIMESTAMP,CSfi,d.h.TIMESTAMP);
    TCS(:,ch) = c.Tsky.*CSf + (1-CSf).*TWL;
end

%% define each scan time -----------------------------------------
DCE_speed_cmd_rpm_s = interp1(d.h.TIMESTAMP,d.h.DCE_SPEED_CMD_RPM,d.s.TIMESTAMP,'nearest');
indsNormalEncoderRange = find((d.s.ENCODER>0)&(d.s.ENCODER<18000)&(DCE_speed_cmd_rpm_s>0)); % subset data by normal rotating science data
encoderDiff = diff(d.s.ENCODER(indsNormalEncoderRange));
maxDiff = max(encoderDiff)-50;
indsScanStart = find(encoderDiff >= maxDiff)+1;

scan_start_times = d.s.TIMESTAMP(indsNormalEncoderRange(indsScanStart(1:end)));
if(length(scan_start_times)>2)
%% calculate mean + standard deviation of counts for each scan time/target
stdWindow = 3;
% initialize
calWL.adc_m.data = NaN([length(scan_start_times)-1 5]);
calWL.adc_s.data = NaN([length(scan_start_times)-1 5]);
calWL.Tcal.data = NaN([length(scan_start_times)-1 5]);
calWL.Tcal_s.data = NaN([length(scan_start_times)-1 5]);
calCS.adc_m.data = NaN([length(scan_start_times)-1 5]);
calCS.adc_s.data = NaN([length(scan_start_times)-1 5]);
calCS.Tcal.data = NaN([length(scan_start_times)-1 5]);
calCS.Tcal_s.data = NaN([length(scan_start_times)-1 5]);
num_cs_inds = NaN([length(scan_start_times)-1 1]);
num_wl_inds = NaN([length(scan_start_times)-1 1]);

% loop through each scan
for nn = 1:length(scan_start_times)-1
    % define scan window
    tmA = scan_start_times(nn);
    tmB = scan_start_times(nn+1);

    % indexes of targets for that particular scan time
    CSinds = find((d.s.ENCODER>=c.CSstart)&((d.s.ENCODER<c.CSend))&(d.s.TIMESTAMP>=tmA)&(d.s.TIMESTAMP<tmB));
    WLinds = find((d.s.ENCODER>=c.WLstart)&((d.s.ENCODER<c.WLend))&(d.s.TIMESTAMP>=tmA)&(d.s.TIMESTAMP<tmB));

    num_cs_inds(nn) = length(CSinds);
    num_wl_inds(nn) = length(WLinds);

    % housekeeping indexes for temperatures
    HKinds = find((d.h.TIMESTAMP>=tmA)&(d.h.TIMESTAMP<tmB));

    % count stats cold sky
    calCS.adc_m.data(nn,:) = [mean(d.s.ADC0(CSinds)) mean(d.s.ADC1(CSinds)) mean(d.s.ADC2(CSinds)) mean(d.s.ADC3(CSinds)) mean(d.s.ADC4(CSinds))];
    temp = movstd(d.s.ADC0(CSinds),stdWindow);
    calCS.adc_s.data(nn,1) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC1(CSinds),stdWindow);
    calCS.adc_s.data(nn,2) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC2(CSinds),stdWindow);
    calCS.adc_s.data(nn,3) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC3(CSinds),stdWindow);
    calCS.adc_s.data(nn,4) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC4(CSinds),stdWindow);
    calCS.adc_s.data(nn,5) = sqrt(mean(temp(2:end-1).^2));

    % cold sky time
    calCS.time.data(nn) = mean(d.s.TIMESTAMP(CSinds));

    % count stats internal target
    calWL.adc_m.data(nn,:) = [mean(d.s.ADC0(WLinds)) mean(d.s.ADC1(WLinds)) mean(d.s.ADC2(WLinds)) mean(d.s.ADC3(WLinds)) mean(d.s.ADC4(WLinds))];
    temp = movstd(d.s.ADC0(WLinds),stdWindow);
    calWL.adc_s.data(nn,1) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC1(WLinds),stdWindow);
    calWL.adc_s.data(nn,2) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC2(WLinds),stdWindow);
    calWL.adc_s.data(nn,3) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC3(WLinds),stdWindow);
    calWL.adc_s.data(nn,4) = sqrt(mean(temp(2:end-1).^2));
    temp = movstd(d.s.ADC4(WLinds),stdWindow);
    calWL.adc_s.data(nn,5) = sqrt(mean(temp(2:end-1).^2));

    % warm load time
    calWL.time.data(nn) = mean(d.s.TIMESTAMP(WLinds));

    % warm load temperature stats
    calWL.Tcal.data(nn,:) = repmat(mean(TWL(HKinds)),1,5);
    calWL.Tcal_s.data(nn,:) = repmat(std(TWL(HKinds)),1,5);

    % cold sky stats
    calCS.Tcal.data(nn,:) = mean(TCS(HKinds,:));
    calCS.Tcal_s.data(nn,:) = std(TCS(HKinds,:));
end

%% decide on calibration time point
if (length(calCS.time.data) < length(calWL.time.data))
    cal.time.data = calCS.time.data;
else
    cal.time.data = calWL.time.data;
end

%% compute gain and NEDT at calibration time points
for ch = 1:5
    % warm load calculations
    ind3sig = find(calWL.adc_s.data(:,ch) < c.calstd_thres(ch)); % this is simplified from TEMPEST example code
    if(length(ind3sig)==0)
        fprintf('data do not meet quality control for calibration, consider adjusting thresholds\n')
        cal.process_abort.data = 1;
    else
        cal.adcWL_m.data(:,ch) = interp1(calWL.time.data(ind3sig), calWL.adc_m.data(ind3sig,ch),cal.time.data,'nearest','extrap');
        cal.TcalWL_m.data(:,ch) = interp1(calWL.time.data(ind3sig), calWL.Tcal.data(ind3sig,ch),cal.time.data,'nearest','extrap');
        cal.adcWL_s.data(:,ch) = interp1(calWL.time.data(ind3sig), calWL.adc_s.data(ind3sig,ch),cal.time.data,'nearest','extrap');
    
        % cold sky calculations
        ind3sig = find(calCS.adc_s.data(:,ch) < c.calstd_thres(ch));
        cal.TcalCS_m.data(:,ch) = interp1(calCS.time.data(ind3sig), calCS.Tcal.data(ind3sig,ch),cal.time.data,'nearest','extrap');
        cal.adcCS_m.data(:,ch) = interp1(calCS.time.data(ind3sig), calCS.adc_m.data(ind3sig,ch),cal.time.data,'nearest','extrap');
        cal.adcCS_s.data(:,ch) = interp1(calCS.time.data(ind3sig), calCS.adc_s.data(ind3sig,ch),cal.time.data,'nearest','extrap');
        
        % gain
        cal.gain.data(:,ch) = (cal.adcWL_m.data(:,ch)-cal.adcCS_m.data(:,ch))./(cal.TcalWL_m.data(:,ch)-cal.TcalCS_m.data(:,ch));
        
        % NEDT
        cal.NEDTwl.data(:,ch) = cal.adcWL_s.data(:,ch)./abs(cal.gain.data(:,ch));
        cal.NEDTcs.data(:,ch) = cal.adcCS_s.data(:,ch)./abs(cal.gain.data(:,ch));
    end
 
end

% % flag assignment to calibration time
% cal.flagRegister.data = uint16(interp1(calWL.time.data,double(flagRegister),cal.time.data,'nearest','extrap'));
cal.num_wl_obs.data = interp1(calWL.time.data,num_wl_inds,cal.time.data,'nearest','extrap');
cal.num_cs_obs.data = interp1(calCS.time.data,num_cs_inds,cal.time.data,'nearest','extrap');

%% Setup attributes
cal.time.longname = 'Time for calibration set, seconds since J2000';
cal.time.units = 's';

cal.adcWL_m.longname = 'Mean warm load counts for each scan';
cal.adcWL_m.units = 'DN';

cal.adcCS_m.longname = 'Mean cold sky calibration counts for each scan';
cal.adcCS_m.units = 'DN';

cal.adcWL_s.longname = 'Standard deviation of warm load counts for each scan';
cal.adcWL_s.units = 'DN';

cal.adcCS_s.longname = 'Standard deviation of cold sky calibration counts for each scan';
cal.adcCS_s.units = 'DN';

cal.TcalCS_m.longname = 'Cold sky calibration brightness temperature for each scan';
cal.TcalCS_m.units = 'K';

cal.TcalWL_m.longname = 'Warm load brightness temperature for each scan';
cal.TcalWL_m.units = 'K';

cal.gain.longname = 'Calibrated reciever gain (time x channel) once per scan';
cal.gain.units = 'counts/K';

cal.NEDTwl.longname = 'Warm Load NEDT (time x channel) once per scan';
cal.NEDTwl.units = 'K';

cal.NEDTcs.longname = 'Cold Sky NEDT (time x channel) once per scan';
cal.NEDTcs.units = 'K';

cal.num_wl_obs.longname = 'Number of observations of the warm load';
cal.num_wl_obs.units = '/';

cal.num_cs_obs.longname = 'Number of observations of the cold sky';
cal.num_cs_obs.units = '/';

 
cal.process_abort.longname = 'flag for determing if we can continue to process data';
cal.process_abort.units = '/';
else
    fprintf('Non standard science data, aborting calibration pre processing\n')
    cal.process_abort.data = 1;
end % end check of scan times length

end % function end


