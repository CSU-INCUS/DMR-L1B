function d = create_L0_granule(granule_start_time,granule_end_time,L0_DMR_folder)
% granule_start_time = '28-Feb-2025 02:37:14';
% granule_end_time = '28-Feb-2025 03:11:22';
% L0_DMR_folder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L0\outputs\';
%% convert string time to matlab time 
dn1 = datenum(granule_start_time,'dd-mmm-yyyy HH:MM:ss'); % need to add precision to this field or the L0 filename 
dn2 = datenum(granule_end_time,'dd-mmm-yyyy HH:MM:ss');

%% get a list of start times in the folder
list_of_files = dir(strcat(L0_DMR_folder,'*.nc'));

%% find relevant files
numFiles = length(list_of_files);
if(numFiles>0)
    for ff = 1:numFiles
        temp = list_of_files(ff).name;
        string_time_1 = temp(6:19); % hard coded for now
        string_time_2 = temp(22:35); % hard coded for now

        tm1(ff) = datenum(string_time_1,'yyyymmddHHMMss');
        tm2(ff) = datenum(string_time_2,'yyyymmddHHMMss');
        
    end
else
    disp('No DMR L0 data available')
end

% decide which files to read and concatinate
inds = find((tm2>dn1)&(tm1<dn2));

%% initialize
d.h.THERM_COUNT0 = [];    % Calibration target number 1 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT1 = [];	% Calibration target number 2 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT2 = [];	% Calibration target number 3 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT3 = [];	% WR5 power divider counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT4 = [];	% WR5 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT5 = [];	% WR10 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.DCE_CMD_STATUS = [];	% DCE Command Status (See BCT 148DOC0054)
d.h.DCE_FILTERED_SPEED_RPM = [];	% Wheel Measured Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
d.h.DCE_SPEED_CMD_RPM = [];	% Wheel Command Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
d.h.SCI_CONFIG_BLK_ENABLE = [];	% DAR Blanking Enable State
d.h.SCI_DROP_0 = [];	% Number of science dropped from start
d.h.SCI_KEEP_1 = [];	% Number of science kept from encoder window
d.h.SCI_DROP_1 = [];	% Count of science dropped from encoder window
d.h.SCI_KEEP_2 = [];	% Number of science kept from encoder window
d.h.SCI_DROP_2 = [];	% Count of science dropped from encoder window
d.h.SCI_KEEP_3 = [];	% Number of science kept from encoder window
d.h.SCI_DROP_3 = [];	% Count of science dropped from encoder window
d.h.SCI_SHIFT_ADC0 = [];	% Science ADC0 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC1 = [];	% Science ADC1 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC2 = [];	% Science ADC2 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC3 = [];	% Science ADC3 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC4 = [];	% Science ADC4 bit-shift value for 16-bit telemetry
d.h.SCI_OFFSET_ADC0 = [];	% Science ADC0 count offset prior to down shift
d.h.SCI_OFFSET_ADC1 = [];	% Science ADC1 count offset prior to down shift
d.h.SCI_OFFSET_ADC2 = [];	% Science ADC2 count offset prior to down shift
d.h.SCI_OFFSET_ADC3 = [];	% Science ADC3 count offset prior to down shift
d.h.SCI_OFFSET_ADC4 = [];	% Science ADC4 count offset prior to down shift
d.h.TIMESTAMP = [];	% Timestamp of housekeeping, seconds since J2000 (This field is derived from one or more housekeeping fields.)
% science variables
d.s.TIMESTAMP = [];	% Time at capture, seconds since J2000
d.s.ENCODER = [];	% Encoder position at capture
d.s.ADC0 = [];	% ADC 0 Counts (89 GHz Co-Added Counts)
d.s.ADC1 = [];	% ADC 1 Counts (165 GHz Co-Added Counts)
d.s.ADC2 = [];	% ADC 2 Counts (176 GHz Co-Added Counts)
d.s.ADC3 = [];	% ADC 3 Counts (180 GHz Co-Added Counts)
d.s.ADC4 = [];	% ADC 4 Counts (182 GHz Co-Added Counts)
    
%% read and concatinate data
for dd = 1:length(inds)
    L0_file = fullfile(L0_DMR_folder,list_of_files(inds(dd)).name);
    d2 = read_L0_nc(L0_file);
    d.h.THERM_COUNT0 = [d.h.THERM_COUNT0;d2.h.THERM_COUNT0];    % Calibration target number 1 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT1 = [d.h.THERM_COUNT1;d2.h.THERM_COUNT1];	% Calibration target number 2 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT2 = [d.h.THERM_COUNT2;d2.h.THERM_COUNT2];	% Calibration target number 3 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT3 = [d.h.THERM_COUNT3;d2.h.THERM_COUNT3];	% WR5 power divider counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT4 = [d.h.THERM_COUNT4;d2.h.THERM_COUNT4];	% WR5 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT5 = [d.h.THERM_COUNT5;d2.h.THERM_COUNT5];	% WR10 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.DCE_CMD_STATUS = [d.h.DCE_CMD_STATUS;d2.h.DCE_CMD_STATUS];	% DCE Command Status (See BCT 148DOC0054)
    d.h.DCE_FILTERED_SPEED_RPM = [d.h.DCE_FILTERED_SPEED_RPM;d2.h.DCE_FILTERED_SPEED_RPM];	% Wheel Measured Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
    d.h.DCE_SPEED_CMD_RPM = [d.h.DCE_SPEED_CMD_RPM;d2.h.DCE_SPEED_CMD_RPM];	% Wheel Command Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
    d.h.SCI_CONFIG_BLK_ENABLE = [d.h.SCI_CONFIG_BLK_ENABLE;d2.h.SCI_CONFIG_BLK_ENABLE];	% DAR Blanking Enable State
    d.h.SCI_DROP_0 = [d.h.SCI_DROP_0;d2.h.SCI_DROP_0];	% Number of science dropped from start
    d.h.SCI_KEEP_1 = [d.h.SCI_KEEP_1;d2.h.SCI_KEEP_1];	% Number of science kept from encoder window
    d.h.SCI_DROP_1 = [d.h.SCI_DROP_1;d2.h.SCI_DROP_1];	% Count of science dropped from encoder window
    d.h.SCI_KEEP_2 = [d.h.SCI_KEEP_2;d2.h.SCI_KEEP_2];	% Number of science kept from encoder window
    d.h.SCI_DROP_2 = [d.h.SCI_DROP_2;d2.h.SCI_DROP_2];	% Count of science dropped from encoder window
    d.h.SCI_KEEP_3 = [d.h.SCI_KEEP_3;d2.h.SCI_KEEP_3];	% Number of science kept from encoder window
    d.h.SCI_DROP_3 = [d.h.SCI_DROP_3;d2.h.SCI_DROP_3];	% Count of science dropped from encoder window
    d.h.SCI_SHIFT_ADC0 = [d.h.SCI_SHIFT_ADC0;d2.h.SCI_SHIFT_ADC0];	% Science ADC0 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC1 = [d.h.SCI_SHIFT_ADC1;d2.h.SCI_SHIFT_ADC1];	% Science ADC1 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC2 = [d.h.SCI_SHIFT_ADC2;d2.h.SCI_SHIFT_ADC2];	% Science ADC2 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC3 = [d.h.SCI_SHIFT_ADC3;d2.h.SCI_SHIFT_ADC3];	% Science ADC3 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC4 = [d.h.SCI_SHIFT_ADC4;d2.h.SCI_SHIFT_ADC4];	% Science ADC4 bit-shift value for 16-bit telemetry
    d.h.SCI_OFFSET_ADC0 = [d.h.SCI_OFFSET_ADC0;d2.h.SCI_OFFSET_ADC0];	% Science ADC0 count offset prior to down shift
    d.h.SCI_OFFSET_ADC1 = [d.h.SCI_OFFSET_ADC1;d2.h.SCI_OFFSET_ADC1];	% Science ADC1 count offset prior to down shift
    d.h.SCI_OFFSET_ADC2 = [d.h.SCI_OFFSET_ADC2;d2.h.SCI_OFFSET_ADC2];	% Science ADC2 count offset prior to down shift
    d.h.SCI_OFFSET_ADC3 = [d.h.SCI_OFFSET_ADC3;d2.h.SCI_OFFSET_ADC3];	% Science ADC3 count offset prior to down shift
    d.h.SCI_OFFSET_ADC4 = [d.h.SCI_OFFSET_ADC4;d2.h.SCI_OFFSET_ADC4];	% Science ADC4 count offset prior to down shift
    d.h.TIMESTAMP = [d.h.TIMESTAMP;d2.h.TIMESTAMP];	% Timestamp of housekeeping, seconds since J2000 (This field is derived from one or more housekeeping fields.)
    % science variables
    d.s.TIMESTAMP = [d.s.TIMESTAMP;d2.s.TIMESTAMP];	% Time at capture, seconds since J2000
    d.s.ENCODER = [d.s.ENCODER;d2.s.ENCODER];	% Encoder position at capture
    d.s.ADC0 = [d.s.ADC0;d2.s.ADC0];	% ADC 0 Counts (89 GHz Co-Added Counts)
    d.s.ADC1 = [d.s.ADC1;d2.s.ADC1];	% ADC 1 Counts (165 GHz Co-Added Counts)
    d.s.ADC2 = [d.s.ADC2;d2.s.ADC2];	% ADC 2 Counts (176 GHz Co-Added Counts)
    d.s.ADC3 = [d.s.ADC3;d2.s.ADC3];	% ADC 3 Counts (180 GHz Co-Added Counts)
    d.s.ADC4 = [d.s.ADC4;d2.s.ADC4];	% ADC 4 Counts (182 GHz Co-Added Counts)
end

%% find times
secondsPerDay = 24*60*60;
j2000base = datenum(2000,1,1);
jtm1 = (dn1 - j2000base)*secondsPerDay;
jtm2 = (dn2 - j2000base)*secondsPerDay;
% subset housekeeping
hinds = find((d.h.TIMESTAMP>=jtm1)&(d.h.TIMESTAMP<=jtm2));
d.h.THERM_COUNT0 = d.h.THERM_COUNT0(hinds);    % Calibration target number 1 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT1 = d.h.THERM_COUNT1(hinds);	% Calibration target number 2 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT2 = d.h.THERM_COUNT2(hinds);	% Calibration target number 3 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT3 = d.h.THERM_COUNT3(hinds);	% WR5 power divider counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT4 = d.h.THERM_COUNT4(hinds);	% WR5 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.THERM_COUNT5 = d.h.THERM_COUNT5(hinds);	% WR10 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
d.h.DCE_CMD_STATUS = d.h.DCE_CMD_STATUS(hinds);	% DCE Command Status (See BCT 148DOC0054)
d.h.DCE_FILTERED_SPEED_RPM = d.h.DCE_FILTERED_SPEED_RPM(hinds);	% Wheel Measured Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
d.h.DCE_SPEED_CMD_RPM = d.h.DCE_SPEED_CMD_RPM(hinds);	% Wheel Command Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
d.h.SCI_CONFIG_BLK_ENABLE = d.h.SCI_CONFIG_BLK_ENABLE(hinds);	% DAR Blanking Enable State
d.h.SCI_DROP_0 = d.h.SCI_DROP_0(hinds);	% Number of science dropped from start
d.h.SCI_KEEP_1 = d.h.SCI_KEEP_1(hinds);	% Number of science kept from encoder window
d.h.SCI_DROP_1 = d.h.SCI_DROP_1(hinds);	% Count of science dropped from encoder window
d.h.SCI_KEEP_2 = d.h.SCI_KEEP_2(hinds);	% Number of science kept from encoder window
d.h.SCI_DROP_2 = d.h.SCI_DROP_2(hinds);	% Count of science dropped from encoder window
d.h.SCI_KEEP_3 = d.h.SCI_KEEP_3(hinds);	% Number of science kept from encoder window
d.h.SCI_DROP_3 = d.h.SCI_DROP_3(hinds);	% Count of science dropped from encoder window
d.h.SCI_SHIFT_ADC0 = d.h.SCI_SHIFT_ADC0(hinds);	% Science ADC0 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC1 = d.h.SCI_SHIFT_ADC1(hinds);	% Science ADC1 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC2 = d.h.SCI_SHIFT_ADC2(hinds);	% Science ADC2 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC3 = d.h.SCI_SHIFT_ADC3(hinds);	% Science ADC3 bit-shift value for 16-bit telemetry
d.h.SCI_SHIFT_ADC4 = d.h.SCI_SHIFT_ADC4(hinds);	% Science ADC4 bit-shift value for 16-bit telemetry
d.h.SCI_OFFSET_ADC0 = d.h.SCI_OFFSET_ADC0(hinds);	% Science ADC0 count offset prior to down shift
d.h.SCI_OFFSET_ADC1 = d.h.SCI_OFFSET_ADC1(hinds);	% Science ADC1 count offset prior to down shift
d.h.SCI_OFFSET_ADC2 = d.h.SCI_OFFSET_ADC2(hinds);	% Science ADC2 count offset prior to down shift
d.h.SCI_OFFSET_ADC3 = d.h.SCI_OFFSET_ADC3(hinds);	% Science ADC3 count offset prior to down shift
d.h.SCI_OFFSET_ADC4 = d.h.SCI_OFFSET_ADC4(hinds);	% Science ADC4 count offset prior to down shift
d.h.TIMESTAMP = d.h.TIMESTAMP(hinds);	% Timestamp of housekeeping, seconds since J2000 (This field is derived from one or more housekeeping fields.)

%subset science
sinds = find((d.s.TIMESTAMP>=jtm1)&(d.s.TIMESTAMP<=jtm2));
d.s.TIMESTAMP = d.s.TIMESTAMP(sinds);	% Time at capture, seconds since J2000
d.s.ENCODER = d.s.ENCODER(sinds);	% Encoder position at capture
d.s.ADC0 = d.s.ADC0(sinds);	% ADC 0 Counts (89 GHz Co-Added Counts)
d.s.ADC1 = d.s.ADC1(sinds);	% ADC 1 Counts (165 GHz Co-Added Counts)
d.s.ADC2 = d.s.ADC2(sinds);	% ADC 2 Counts (176 GHz Co-Added Counts)
d.s.ADC3 = d.s.ADC3(sinds);	% ADC 3 Counts (180 GHz Co-Added Counts)
d.s.ADC4 = d.s.ADC4(sinds);	% ADC 4 Counts (182 GHz Co-Added Counts)
% end