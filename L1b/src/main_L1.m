%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main_L1.m
% 
% This is the main script that includes all code for producing geolocated
% TA and TB
% eventually I will make this a function that takes an input file, but for
% now I will hard code a nc file input path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc;

%% define directories ----------------------------------------------------%
granule_start_time = '28-Feb-2025 02:37:14';
granule_end_time = '28-Feb-2025 03:11:22';
dn1 = datenum(granule_start_time,'dd-mmm-yyyy HH:MM:ss'); % need to add precision to this field or the L0 filename 
dn2 = datenum(granule_end_time,'dd-mmm-yyyy HH:MM:ss');

L0_DMR_folder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L0\outputs\';
static_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L1b\static\static_parameters.nc';
LO_sc_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L0\outputs\L0_sc_sYYYYmmddHHMMss_eYYYYmmddHHMMss.nc';
L1_DMR_folder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing\L1\outputs\';
%% load static parameters ------------------------------------------------%
c = read_static_nc(static_file);

%% load L0 data ----------------------------------------------------------%
% d = read_L0_nc(L0_file);
% 'Time at capture, seconds since J2000'
% secondsPerDay = 24*60*60;
% matlabConversionTime = datenum(2000,1,1) + 7.940274826689999E8./secondsPerDay;
d = create_L0_granule(granule_start_time,granule_end_time,L0_DMR_folder);
%% load spacecraft telemetry ---------------------------------------------%
sc.filename.data = 'TBD.csv';
sc = define_sc_var_DMR(sc); % setting up attributes for sc structure
sc = read_spacecraft(sc); % read s/c data % reminder that I need to make sure that the time conventions in the s/c data match the DMR TIMESTAMP
sc = process_spacecraft_data(sc); % for s/c position/orientation

%% observing geometry ----------------------------------------------------%
% scan angle calculation
maxEncoderCounts = 16383; % TEMPEST had this with +1?
rad.scanang.data = double(d.s.ENCODER)./maxEncoderCounts.*360-c.nadirang;
rad.scanang.data = rad.scanang.data - (rad.scanang.data>180)*360; %scan angle needs to be -180 to +180 to work with current code
rad.scanang.longname = 'Scan angle from encoder';
rad.scanang.units = 'degrees';

% preallocate geolocation variables
rad = define_geo_var_DMR(rad);

% geolocate DMR boresight for each observation
rad = locate_DMR(rad,sc,c,d); 

%% extract calibration data ----------------------------------------------%
[calWL,calCS,cal] = cal_preprocess(d,c,rad);

%% compute TA ------------------------------------------------------------%
rad = compute_TA_DMR(d,c,rad,cal);

%% filter and flag data --------------------------------------------------%
rad = filter_TA_DMR(c,rad);

%% compute TB ------------------------------------------------------------%
rad = compute_TB_DMR(d,c,rad);

%% filter and flag data --------------------------------------------------%
rad = filter_TB_DMR(c,rad);

%% output netCDF ---------------------------------------------------------%
[yyo, mmo, ddo, ~, ~, ~] = datevec(granule_start_time);
output_path = [L1out_pth, sprintf('%04d',yyo),'/', sprintf('%02d',mmo),'/'];
if (~exist(output_path, 'dir'))
    system(['mkdir ',output_path]);
end
output_path = [L1out_pth, sprintf('%04d',yyo),'/', sprintf('%02d',mmo),'/', sprintf('%02d',ddo), '/'];
if (~exist(output_path, 'dir'))
    system(['mkdir ',output_path]);
end
output_file = [output_path,'DMR_L1B_',datestr(dn1,'yyyymmddTHHMMSS'),'_',datestr(dn2,'yyyymmddTHHMMSS'),'_',verstr,'.nc'];
% time ordered version
output_netcdf(rad,cal,sc,output_file)
            
           
