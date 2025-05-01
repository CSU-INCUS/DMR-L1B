function d = read_L0_nc(L0_file)
% clear all; clc;
% 
% L0_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L0\outputs\tlm.080.nc';

try
    d.file_info = ncinfo(L0_file);   
    
    % housekeeping variables
    d.h.THERM_COUNT0 = ncread(L0_file,'/HOUSEKEEPING/THERM_COUNT0');    % Calibration target number 1 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT1 = ncread(L0_file,'/HOUSEKEEPING/THERM_COUNT1');	% Calibration target number 2 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT2 = ncread(L0_file,'/HOUSEKEEPING/THERM_COUNT2');	% Calibration target number 3 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT3 = ncread(L0_file,'/HOUSEKEEPING/THERM_COUNT3');	% WR5 power divider counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT4 = ncread(L0_file,'/HOUSEKEEPING/THERM_COUNT4');	% WR5 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.THERM_COUNT5 = ncread(L0_file,'/HOUSEKEEPING/THERM_COUNT5');	% WR10 counts (See CTD 3.6.1) (This field has been transformed from the packet value and is represented here in K.)
    d.h.DCE_CMD_STATUS = ncread(L0_file,'/HOUSEKEEPING/DCE_CMD_STATUS');	% DCE Command Status (See BCT 148DOC0054)
    d.h.DCE_FILTERED_SPEED_RPM = ncread(L0_file,'/HOUSEKEEPING/DCE_FILTERED_SPEED_RPM');	% Wheel Measured Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
    d.h.DCE_SPEED_CMD_RPM = ncread(L0_file,'/HOUSEKEEPING/DCE_SPEED_CMD_RPM');	% Wheel Command Speed (See BCT 148DOC0054) (This field has been transformed from the packet value and is represented here in RPM.)
    d.h.SCI_CONFIG_BLK_ENABLE = ncread(L0_file,'/HOUSEKEEPING/SCI_CONFIG_BLK_ENABLE');	% DAR Blanking Enable State
    d.h.SCI_DROP_0 = ncread(L0_file,'/HOUSEKEEPING/SCI_DROP_0');	% Number of science dropped from start
    d.h.SCI_KEEP_1 = ncread(L0_file,'/HOUSEKEEPING/SCI_KEEP_1');	% Number of science kept from encoder window
    d.h.SCI_DROP_1 = ncread(L0_file,'/HOUSEKEEPING/SCI_DROP_1');	% Count of science dropped from encoder window
    d.h.SCI_KEEP_2 = ncread(L0_file,'/HOUSEKEEPING/SCI_KEEP_2');	% Number of science kept from encoder window
    d.h.SCI_DROP_2 = ncread(L0_file,'/HOUSEKEEPING/SCI_DROP_2');	% Count of science dropped from encoder window
    d.h.SCI_KEEP_3 = ncread(L0_file,'/HOUSEKEEPING/SCI_KEEP_3');	% Number of science kept from encoder window
    d.h.SCI_DROP_3 = ncread(L0_file,'/HOUSEKEEPING/SCI_DROP_3');	% Count of science dropped from encoder window
    d.h.SCI_SHIFT_ADC0 = ncread(L0_file,'/HOUSEKEEPING/SCI_SHIFT_ADC0');	% Science ADC0 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC1 = ncread(L0_file,'/HOUSEKEEPING/SCI_SHIFT_ADC1');	% Science ADC1 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC2 = ncread(L0_file,'/HOUSEKEEPING/SCI_SHIFT_ADC2');	% Science ADC2 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC3 = ncread(L0_file,'/HOUSEKEEPING/SCI_SHIFT_ADC3');	% Science ADC3 bit-shift value for 16-bit telemetry
    d.h.SCI_SHIFT_ADC4 = ncread(L0_file,'/HOUSEKEEPING/SCI_SHIFT_ADC4');	% Science ADC4 bit-shift value for 16-bit telemetry
    d.h.SCI_OFFSET_ADC0 = ncread(L0_file,'/HOUSEKEEPING/SCI_OFFSET_ADC0');	% Science ADC0 count offset prior to down shift
    d.h.SCI_OFFSET_ADC1 = ncread(L0_file,'/HOUSEKEEPING/SCI_OFFSET_ADC1');	% Science ADC1 count offset prior to down shift
    d.h.SCI_OFFSET_ADC2 = ncread(L0_file,'/HOUSEKEEPING/SCI_OFFSET_ADC2');	% Science ADC2 count offset prior to down shift
    d.h.SCI_OFFSET_ADC3 = ncread(L0_file,'/HOUSEKEEPING/SCI_OFFSET_ADC3');	% Science ADC3 count offset prior to down shift
    d.h.SCI_OFFSET_ADC4 = ncread(L0_file,'/HOUSEKEEPING/SCI_OFFSET_ADC4');	% Science ADC4 count offset prior to down shift
    d.h.TIMESTAMP = ncread(L0_file,'/HOUSEKEEPING/TIMESTAMP');	% Timestamp of housekeeping, seconds since J2000 (This field is derived from one or more housekeeping fields.)
    % science variables
    d.s.TIMESTAMP = ncread(L0_file,'/SCIENCE/TIMESTAMP');	% Time at capture, seconds since J2000
    d.s.ENCODER = ncread(L0_file,'/SCIENCE/ENCODER');	% Encoder position at capture
    d.s.ADC0 = ncread(L0_file,'/SCIENCE/ADC0');	% ADC 0 Counts (89 GHz Co-Added Counts)
    d.s.ADC1 = ncread(L0_file,'/SCIENCE/ADC1');	% ADC 1 Counts (165 GHz Co-Added Counts)
    d.s.ADC2 = ncread(L0_file,'/SCIENCE/ADC2');	% ADC 2 Counts (176 GHz Co-Added Counts)
    d.s.ADC3 = ncread(L0_file,'/SCIENCE/ADC3');	% ADC 3 Counts (180 GHz Co-Added Counts)
    d.s.ADC4 = ncread(L0_file,'/SCIENCE/ADC4');	% ADC 4 Counts (182 GHz Co-Added Counts)
    
    fprintf('Successfully loaded all variables from %s\n', L0_file);

catch ME
    fprintf('Error reading NetCDF file: %s\n', ME.message);
end