%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main_L1.m
% 
% This is the main script that includes all code for producing geolocated
% TA and TB
% eventually I will make this a function that takes an input file, but for
% now I will hard code a nc file input path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; clc;tic

%% define directories and other static input -----------------------------%
% setting up to be applicable to L0 DMR input DMR_L0_20241021T224728_20241021T230256_V1.2.0_20250912T195641.nc
granule_start_time = '21-Oct-2024 22:48:00'; % currently based on the amount of S/C data I have (7 minutes)
granule_end_time = '21-Oct-2024 22:55:00'; % currently based on the amount of S/C data I have
granuleNumStr = '000001';
dn1 = datenum(granule_start_time,'dd-mmm-yyyy HH:MM:ss'); % need to add precision to this field or the L0 filename 
dn2 = datenum(granule_end_time,'dd-mmm-yyyy HH:MM:ss');
verstr = 'V0010';
%%%% SDPC - START
% L0_DMR_folder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L0\outputs\';
% static_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L1b\static\static_parameters.nc';
% LO_sc_file = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L1b\inputs\BCT_sample-with-velocity.nc';
% L1_DMR_folder = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L1\outputs\';
% L1_out_path = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L1b\outputs\data\';
% land_mask_path = 'C:\Users\marym\Documents\INCUS\code\DMR\dev\DMR-ground-processing-public\DMR-ground-processing\L1b\inputs\2min_Landmask.dat';
L0_DMR_folder = '/data/DMR-L0/'; % input data - DMR L0 files
static_file = '/reference/static_parameters.nc'; % reference - static parameters
LO_sc_file = '/data/telemetry/BCT_sample-with-velocity.nc'; % input data - BCT telemetry (will be 1A-SC)
% L1_DMR_folder = '../../../dev-output/1b-tb/0.1.0-matlab-test/'; % not used?
L1_out_path = '/output/'; % output data dir
land_mask_path = '/reference/2min_Landmask.dat'; % reference - land mask
%%%% SDPC - END

%% load static parameters ------------------------------------------------%
c = read_static_nc(static_file);

%% load L0 data ----------------------------------------------------------%
% d = read_L0_nc(L0_file);
% 'Time at capture, seconds since J2000'
% secondsPerDay = 24*60*60;
% matlabConversionTime = datenum(2000,1,1) + 7.940274826689999E8./secondsPerDay;
d = create_L0_granule(granule_start_time,granule_end_time,L0_DMR_folder);

%% process inst data
% preallocation and metadata definitions
inst = define_inst_var_DMR(d);
% process data
inst = process_inst_data(inst,d);

%% load spacecraft telemetry ---------------------------------------------%
% note that CubeOlocate needs time in matlab datetime convention, but
% elsewhere, we are consistent in using J2000
sc.filename.data = LO_sc_file;
sc = define_sc_var_DMR(sc); % setting up attributes for sc structure
sc = read_spacecraft(sc,c); % read s/c data % reminder that I need to make sure that the time conventions in the s/c data match the DMR TIMESTAMP
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

% apply land/ocean/scene flags
rad = get_landflag_TEMPEST(rad,c,land_mask_path);

%% extract calibration data ----------------------------------------------%
[calWL,calCS,cal] = cal_preprocess(d,c,rad);
% check if the data can be calibrated
if(cal.process_abort.data == 0) % continue with nominal data
    %% compute TA ------------------------------------------------------------%
    rad = compute_TA_DMR(d,c,rad,cal);
    
    %% filter and flag data --------------------------------------------------%
    rad = filter_TA_DMR(c,rad);
    
    %% compute TB ------------------------------------------------------------%
    rad = compute_TB_DMR(d,c,rad);
    
    %% filter and flag data --------------------------------------------------%
    rad = filter_TB_DMR(c,rad);
    
    %% output netCDF ---------------------------------------------------------%
    %%%% SDPC START
    % [yyo, mmo, ddo, ~, ~, ~] = datevec(granule_start_time);
    % output_path = [L1_out_path, sprintf('%04d',yyo),'\', sprintf('%02d',mmo),'\'];
    output_path = L1_out_path;
    %     system(['mkdir ',output_path]);
    % end
    % output_path = [L1_out_path, sprintf('%04d',yyo),'\', sprintf('%02d',mmo),'\', sprintf('%02d',ddo), '\'];
    % if (~exist(output_path, 'dir'))
    %     system(['mkdir ',output_path]);
    % end
    %%%% SDPC END
    createTime = datetime('now','TimeZone', 'Z');
    output_file = [output_path,'DMR_L1B_',granuleNumStr,'_',datestr(dn1,'yyyymmddTHHMMSS'),'_',datestr(dn2,'yyyymmddTHHMMSS'),'_',verstr,'_',datestr(createTime,'yyyymmddTHHMMSS'),'.nc'];
    % time ordered version
    output_netcdf(d,inst,rad,cal,sc,output_file)
    toc           
end